import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_cubit.dart';
import 'package:ex6/screen/detail_poster_screen/poster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class Poster extends StatefulWidget {
  const Poster(
      {Key? key,
      required this.name,
      this.date = '',
      required this.imgLink,
      this.percent = 0,
      required this.id,
      required this.pageIndex,
      this.mediaType})
      : super(key: key);
  final int id;
  final String name;
  final String? date;
  final String imgLink;
  final double? percent;
  final int pageIndex;
  final MediaType? mediaType;

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  late APIClient apiClient;

  late TvRequest tvRequest;
  late MovieRequest movieRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiClient = APIClient();

    tvRequest = TvRequest(apiClient);
    movieRequest = MovieRequest(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => DetailPosterCubit(tvRequest, movieRequest),
                    ),
                  ],
                  child: DetailPoster(
                    id: widget.id,
                    pageIndex: widget.pageIndex,
                  )),
            ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 200,
              width: 130,
              // margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Stack(fit: StackFit.expand, children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: widget.imgLink,
                      placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child: Container(
                                // width: MediaQuery.of(context).size.width - 20,
                                // height: 180,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                              ))),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )),
                widget.percent! > 0
                    ? Positioned(
                        bottom: 2,
                        left: 2,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.percent! > 0
                    ? Positioned(
                        bottom: 5,
                        left: 5,
                        child: CircularPercentIndicator(
                            radius: 22,
                            lineWidth: 3,
                            animation: true,
                            percent: widget.percent! / 100,
                            center: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.percent!.round().toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                )
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: widget.percent! > 70
                                ? const Color(0xff21D07A)
                                : widget.percent! > 40
                                    ? const Color(0xffCDD02F)
                                    : const Color(0xffDB2360)),
                      )
                    : const SizedBox(),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: widget.mediaType == MediaType.TV
                          ? const Icon(Icons.tv)
                          : const Icon(Icons.movie_creation_outlined)),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
              alignment: Alignment.center,
              width: 130,
              child: Text(
                widget.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
          widget.date != '' ? Text(widget.date!) : const SizedBox()
        ],
      ),
    );
  }
}
