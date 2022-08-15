import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_cubit.dart';
import 'package:ex6/screen/detail_poster_screen/poster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class PosterRecommendation extends StatefulWidget {
  const PosterRecommendation(
      {Key? key,
      required this.name,
      required this.date,
      required this.imgLink,
      required this.percent,
      required this.id,
      required this.pageIndex})
      : super(key: key);
  final String name;
  final String date;
  final String imgLink;
  final double percent;
  final int id;
  final int pageIndex;

  @override
  State<PosterRecommendation> createState() => _PosterRecommendationState();
}

class _PosterRecommendationState extends State<PosterRecommendation> {
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => DetailPosterCubit(tvRequest,movieRequest),
                    ),
                  ],
                  child: DetailPoster(
                    id: widget.id,
                    pageIndex: widget.pageIndex,
                  )),
            ));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 125,
              width: 200,
              // margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                              ))),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: CircularPercentIndicator(
                      radius: 20,
                      lineWidth: 3,
                      animation: true,
                      percent: widget.percent / 100,
                      center: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.percent.round().toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          const Text(
                            "%",
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          )
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: widget.percent > 70
                          ? const Color(0xff21D07A)
                          : widget.percent > 40
                              ? const Color(0xffCDD02F)
                              : const Color(0xffDB2360)),
                ),
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
                overflow: TextOverflow.fade,
                //maxLines: 2,
                softWrap: false,
              )),
        ],
      ),
    );
  }
}
