import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/model/movie/movie_credit.dart';
import 'package:ex6/model/movie/movie_detail.dart';
import 'package:ex6/model/movie/movie_recommendation.dart';
import 'package:ex6/model/movie/movie_video.dart';
import 'package:ex6/model/tv/tv_credit.dart';
import 'package:ex6/model/tv/tv_detail.dart';
import 'package:ex6/model/tv/tv_recommendation.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_cubit.dart';
import 'package:ex6/screen/detail_poster_screen/poster_cubit/detail_poster_state.dart';
import 'package:ex6/screen/home_screen/home_screen.dart';
import 'package:ex6/style.dart';
import 'package:ex6/widgets/left_slider/left_slider_view.dart';
import 'package:ex6/widgets/poster/poster_cast.dart';
import 'package:ex6/widgets/poster/poster_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPoster extends StatefulWidget {
  const DetailPoster({Key? key, required this.id, required this.pageIndex})
      : super(key: key);
  final int id;
  final int pageIndex;

  @override
  State<DetailPoster> createState() => _DetailPosterState();
}

class _DetailPosterState extends State<DetailPoster> {
  late APIClient apiClient;
  late DetailPosterCubit detailPosterCubit;

  late TvDetail? tvDetail;
  late List<TvCastAndCrew>? listTvCasts;
  late List<TvCastAndCrew>? listTvCrews;
  late List<ResultVideoTrailer>? listTvTrailer;
  late List<TvRecommendationResult>? listTvRecommendation;

  late MovieDetail? movieDetail;
  late List<MovieCastAndCrew>? listMovieCasts;
  late List<MovieCastAndCrew>? listMovieCrews;
  late List<ResultVideoTrailer>? listMovieTrailer;
  late List<MovieRecommendationResult>? listMovieRecommendation;

  @override
  initState() {
    super.initState();
    apiClient = APIClient();

    tvDetail = null;
    listTvCasts = null;
    listTvCrews = null;
    listTvTrailer = null;
    listTvRecommendation = null;

    movieDetail = null;
    listMovieCasts = null;
    listMovieCrews = null;
    listMovieTrailer = null;
    listMovieRecommendation = null;

    DetailPosterCubit detailPosterCubit = context.read<DetailPosterCubit>();
    detailPosterCubit.init(widget.pageIndex, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(AppColors.darkBlue),
      child: SafeArea(
        child: SliderDrawer(
          appBar: SliderAppBar(
            appBarHeight: 50,
            appBarPadding: const EdgeInsets.only(top: 0),
            appBarColor: const Color(AppColors.darkBlue),
            title: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
              },
              child: SizedBox(
                height: 25,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            drawerIconColor: Colors.white,
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  print('back');
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          slider: const LeftSlider(),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Detail
                  BlocConsumer<DetailPosterCubit, DetailPosterState>(
                    listener: (context, state) {
                      setData(state);
                    },
                    builder: (context, state) => widget.pageIndex == 0
                        ? Column(
                            children: [
                              tvDetail != null
                                  ? buildTvHeader()
                                  : buildHeaderShimmer(),
                              tvDetail != null
                                  ? buildTvGenres()
                                  : buildGenresShimmer(),
                              tvDetail != null
                                  ? buildTvOverview()
                                  : buildOverviewShimmer(),
                              listTvCasts != null
                                  ? buildListTvCast()
                                  : buildListCastShimmer(),
                              listTvTrailer != null
                                  ? listTvTrailer!
                                          .where((video) =>
                                              video.type == 'Trailer')
                                          .isNotEmpty
                                      ? buildTvTrailer()
                                      : const SizedBox()
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              listTvCrews != null
                                  ? buildListTvCrew()
                                  : buildListCrewShimmer(),
                              listTvRecommendation != null
                                  ? buildListTvRecommendation()
                                  : buildListRecommendationShimmer(),
                            ],
                          )
                        : widget.pageIndex == 1
                            ? Column(
                                children: [
                                  movieDetail != null
                                      ? buildMovieHeader()
                                      : buildHeaderShimmer(),
                                  movieDetail != null
                                      ? buildMovieGenres()
                                      : buildGenresShimmer(),
                                  movieDetail != null
                                      ? buildMovieOverview()
                                      : buildOverviewShimmer(),
                                  listMovieCasts != null
                                      ? buildListMovieCast()
                                      : buildListCastShimmer(),
                                  listMovieTrailer != null
                                      ? listMovieTrailer!
                                              .where((video) =>
                                                  video.type == 'Trailer')
                                              .isNotEmpty
                                          ? buildMovieTrailer()
                                          : const SizedBox()
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  listMovieCrews != null
                                      ? buildListMovieCrew()
                                      : buildListCrewShimmer(),
                                  listMovieRecommendation != null
                                      ? buildListMovieRecommendation()
                                      : buildListRecommendationShimmer(),
                                ],
                              )
                            : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  buildTvHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppConfig.baseUrlImg}${tvDetail!.backdropPath.toString()}'),
              opacity: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Anh poster
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl:
                              '${AppConfig.baseUrlImg}${tvDetail!.posterPath.toString()}',
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
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        color: const Color(AppColors.darkBlue),
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              ' ${tvDetail!.episodeRunTime} m',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              //Title
                              Text(
                                tvDetail!.name.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              //Date
                              Text(
                                getShortDate(
                                    tvDetail!.firstAirDate.toString(), 10),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          //color: Colors.black,
                        ),
                        child: CircularPercentIndicator(
                            radius: 22,
                            lineWidth: 5,
                            animation: true,
                            percent: tvDetail!.voteAverage! * 10 / 100,
                            center: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (tvDetail!.voteAverage! * 10)
                                      .round()
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(AppColors.darkBlue)),
                                ),
                                const Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: Color(AppColors.darkBlue)),
                                )
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: (tvDetail!.voteAverage! * 10) > 70
                                ? const Color(0xff21D07A)
                                : (tvDetail!.voteAverage! * 10) > 40
                                    ? const Color(0xffCDD02F)
                                    : const Color(0xffDB2360)),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.format_list_bulleted,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.bookmark,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildHeaderShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Anh poster
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: '',
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
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              //Title
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: const SizedBox(
                                  width: 100,
                                  height: 10,
                                ),
                              ),
                              //Date
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: const SizedBox(
                                  width: 80,
                                  height: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: CircularPercentIndicator(
                              radius: 22,
                              lineWidth: 5,
                              center: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [],
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          child: const Icon(
                            Icons.format_list_bulleted,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          child: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMovieHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppConfig.baseUrlImg}${movieDetail!.backdropPath.toString()}'),
              opacity: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Anh poster
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl:
                              '${AppConfig.baseUrlImg}${movieDetail!.posterPath.toString()}',
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
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        color: const Color(AppColors.darkBlue),
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              ' ${movieDetail!.runtime} m',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              //Title
                              Text(
                                movieDetail!.title.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              //Date
                              Text(
                                getShortDate(
                                    movieDetail!.releaseDate.toString(), 10),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          //color: Colors.black,
                        ),
                        child: CircularPercentIndicator(
                            radius: 22,
                            lineWidth: 5,
                            animation: true,
                            percent: movieDetail!.voteAverage! * 10 / 100,
                            center: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (movieDetail!.voteAverage! * 10)
                                      .round()
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(AppColors.darkBlue)),
                                ),
                                const Text(
                                  "%",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: Color(AppColors.darkBlue)),
                                )
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: (movieDetail!.voteAverage! * 10) > 70
                                ? const Color(0xff21D07A)
                                : (movieDetail!.voteAverage! * 10) > 40
                                    ? const Color(0xffCDD02F)
                                    : const Color(0xffDB2360)),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.format_list_bulleted,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.bookmark,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff032541)),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildTvGenres() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10),
      color: const Color(0xff032541),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: [
              for (var genres in tvDetail!.genres!)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    genres.name!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  buildGenresShimmer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 5,
              children: [
                for (var i = 0; i < 3; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: const Text(
                        '                   ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  buildMovieGenres() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10),
      color: const Color(0xff032541),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 5,
            children: [
              for (var genres in movieDetail!.genres!)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    genres.name!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  buildTvOverview() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: 'Overview')),
          const SizedBox(
            height: 10,
          ),
          tvDetail!.overview!.isNotEmpty
              ? Text(
                  tvDetail!.overview!,
                  style: const TextStyle(fontSize: 16),
                )
              : Lottie.asset('assets/lotties/empty.json',
                  height: 100, width: 100),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  buildOverviewShimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: 'Overview')),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Lottie.asset('assets/lotties/empty.json',
                height: 100, width: 100),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  buildMovieOverview() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: 'Overview')),
          const SizedBox(
            height: 10,
          ),
          movieDetail!.overview!.isNotEmpty
              ? Text(
                  movieDetail!.overview!,
                  style: const TextStyle(fontSize: 16),
                )
              : Lottie.asset('assets/lotties/empty.json',
                  height: 100, width: 100),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  buildListTvCast() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: "Top Billed Cast")),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var cast in listTvCasts!)
                  Cast(
                    id: cast.id,
                    knowFor: cast.character.toString(),
                    name: cast.name!,
                    imgLink: '${AppConfig.baseUrlImg}${cast.profilePath}',
                  ),
                listTvCasts == null
                    ? Lottie.asset('assets/lotties/empty.json',
                        height: 100, width: 100)
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildListCastShimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: "Top Billed Cast")),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 5; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: const Cast(
                      id: 86831,
                      knowFor: '',
                      name: '',
                      imgLink: '',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildListMovieCast() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: buildTextMainTitle(text: "Top Billed Cast")),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var cast in listMovieCasts!)
                  Cast(
                    id: cast.id,
                    knowFor: cast.character.toString(),
                    name: cast.name!,
                    imgLink: '${AppConfig.baseUrlImg}${cast.profilePath}',
                  ),
                listMovieCasts == null
                    ? Lottie.asset('assets/lotties/empty.json',
                        height: 100, width: 100)
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildTvTrailer() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: buildTextMainTitle(text: "Trailer"),
            )),
        const SizedBox(height: 5),
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: listTvTrailer!
                  .where((video) => video.type == 'Trailer')
                  .first
                  .key!,
              flags: const YoutubePlayerFlags(autoPlay: false, loop: false),
            ),
          ),
          builder: (context, player) {
            return Column(
              children: [
                // some widgets
                player,
                //some other widgets
              ],
            );
          },
        ),
      ],
    );
  }

  buildMovieTrailer() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: buildTextMainTitle(text: "Trailer"),
            )),
        const SizedBox(height: 5),
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: listMovieTrailer!
                  .where((video) => video.type == 'Trailer')
                  .first
                  .key!,
              flags: const YoutubePlayerFlags(autoPlay: false, loop: false),
            ),
          ),
          builder: (context, player) {
            return Column(
              children: [
                // some widgets
                player,
                //some other widgets
              ],
            );
          },
        ),
      ],
    );
  }

  buildListTvCrew() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff032541),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var crew in listTvCrews!)
                Column(
                  children: [
                    Text(
                      crew.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    Text(crew.job!, style: const TextStyle(color: Colors.white))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  buildListCrewShimmer() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < 5; i++)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                    width: 70,
                    height: 15,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                    width: 100,
                    height: 15,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  buildListMovieCrew() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff032541),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var crew in listMovieCrews!)
                Column(
                  children: [
                    Text(
                      crew.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    Text(crew.job!, style: const TextStyle(color: Colors.white))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  buildListTvRecommendation() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: buildTextMainTitle(text: "Recommendations")),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (TvRecommendationResult posterRecommendation
                  in listTvRecommendation!)
                PosterRecommendation(
                  pageIndex: 1,
                  id: posterRecommendation.id!,
                  name: posterRecommendation.name.toString() != 'null'
                      ? posterRecommendation.name.toString()
                      : posterRecommendation.originalName.toString(),
                  date: posterRecommendation.firstAirDate.toString(),
                  imgLink:
                      '${AppConfig.baseUrlImg}${posterRecommendation.backdropPath}',
                  percent: posterRecommendation.voteAverage! * 10.toInt(),
                ),
              (listTvRecommendation != null && listTvRecommendation!.isEmpty)
                  ? Lottie.asset('assets/lotties/empty.json',
                      height: 100, width: 100)
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  buildListRecommendationShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < 5; i++)
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: const PosterRecommendation(
                pageIndex: 0,
                id: 1,
                name: '',
                date: '',
                imgLink: '',
                percent: 50,
              ),
            ),
        ],
      ),
    );
  }

  buildListMovieRecommendation() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: buildTextMainTitle(text: "Recommendations")),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (MovieRecommendationResult posterRecommendation
                  in listMovieRecommendation!)
                PosterRecommendation(
                  pageIndex: 1,
                  id: posterRecommendation.id!,
                  name: posterRecommendation.title.toString() != 'null'
                      ? posterRecommendation.title.toString()
                      : posterRecommendation.originalTitle.toString(),
                  date: posterRecommendation.releaseDate.toString(),
                  imgLink:
                      '${AppConfig.baseUrlImg}${posterRecommendation.backdropPath}',
                  percent: posterRecommendation.voteAverage! * 10.toInt(),
                ),
              (listMovieRecommendation != null &&
                      listMovieRecommendation!.isEmpty)
                  ? Lottie.asset('assets/lotties/empty.json',
                      height: 100, width: 100)
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  setData(state) {
    if (state is DetailPosterLoadedTvDetail) {
      tvDetail = state.tvDetail;
    }
    if (state is DetailPosterLoadedTvCasts) {
      listTvCasts = state.listTvCasts;
    }
    if (state is DetailPosterLoadedTvCrews) {
      listTvCrews = state.listTvCrews;
    }
    if (state is DetailPosterLoadedTvVideo) {
      listTvTrailer = state.listTvVideo;
    }
    if (state is DetailPosterLoadedTvRecommendations) {
      listTvRecommendation = state.listTvReCommendations;
    }
    if (state is DetailPosterLoadedMovieDetail) {
      movieDetail = state.movieDetail;
    }
    if (state is DetailPosterLoadedMovieCasts) {
      listMovieCasts = state.listMovieCasts;
    }
    if (state is DetailPosterLoadedMovieCrews) {
      listMovieCrews = state.listMovieCrews;
    }
    if (state is DetailPosterLoadedMovieVideo) {
      listMovieTrailer = state.listMovieVideo;
    }
    if (state is DetailPosterLoadedMovieRecommendations) {
      listMovieRecommendation = state.listMovieReCommendations;
    }
  }
}
