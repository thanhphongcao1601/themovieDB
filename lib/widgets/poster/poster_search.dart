import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/people_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:ex6/screen/detail_people_screen/detail_people_screen.dart';
import 'package:ex6/screen/detail_people_screen/people_cubit/detail_people_cubit.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_cubit.dart';
import 'package:ex6/screen/detail_poster_screen/poster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PosterSearch extends StatefulWidget {
  const PosterSearch(
      {Key? key,
      required this.name,
      required this.date,
      required this.imgLink,
      required this.id,
      required this.pageIndex,
      required this.overview,
      this.mediaType})
      : super(key: key);
  final int id;
  final String name;
  final String date;
  final String imgLink;
  final int pageIndex;
  final String overview;
  final MediaType? mediaType;

  @override
  State<PosterSearch> createState() => _PosterSearchState();
}

class _PosterSearchState extends State<PosterSearch> {
  late APIClient apiClient;

  late TvRequest tvRequest;
  late MovieRequest movieRequest;
  late PeopleRequest peopleRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiClient = APIClient();

    tvRequest = TvRequest(apiClient);
    movieRequest = MovieRequest(apiClient);
    peopleRequest = PeopleRequest(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              //Goto People Screen
              builder: (context) => widget.pageIndex == 2
                  ? MultiBlocProvider(
                      providers: [
                          BlocProvider(
                            create: (_) => DetailPeopleCubit(peopleRequest),
                          ),
                        ],
                      child: PeopleScreen(
                        id: widget.id,
                      ))
                  : MultiBlocProvider(
                      providers: [
                          BlocProvider(
                            create: (_) =>
                                DetailPosterCubit(tvRequest, movieRequest),
                          ),
                        ],
                      child: DetailPoster(
                        id: widget.id,
                        pageIndex: widget.pageIndex,
                      )),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 100,
              width: 65,
              // margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: ClipRRect(
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
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(widget.date),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: widget.mediaType == MediaType.TV
                              ? const Icon(Icons.tv)
                              : widget.mediaType == MediaType.MOVIE
                                  ? const Icon(Icons.movie_creation_outlined)
                                  : const Icon(Icons.person))
                    ],
                  ),
                  Text(
                    widget.overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
