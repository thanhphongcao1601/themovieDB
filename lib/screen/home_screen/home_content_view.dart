import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/local_data/data_home.dart';
import 'package:ex6/model/movie/movie_popular.dart';
import 'package:ex6/model/trending/trending.dart';
import 'package:ex6/model/tv/tv_popular.dart';
import 'package:ex6/screen/home_screen/home_cubit/home_cubit.dart';
import 'package:ex6/screen/home_screen/home_cubit/home_state.dart';
import 'package:ex6/screen/home_screen/search_cubit/search_cubit.dart';
import 'package:ex6/screen/home_screen/search_cubit/search_state.dart';
import 'package:ex6/style.dart';
import 'package:ex6/widgets/avatar/user_in_leader_board.dart';
import 'package:ex6/widgets/poster/poster_movie_and_tv.dart';
import 'package:ex6/widgets/poster/poster_search.dart';
import 'package:ex6/widgets/shimmer/poster_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContentView extends StatefulWidget {
  const ContentView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late HomeCubit homeCubit;
  late SearchCubit searchCubit;
  late TextEditingController searchC;
  late APIClient apiClient;
  Timer? _debounce;

  late List<TvPopularResult> listTvPopular;
  late List<MoviePopularResult> listMoviePopular;
  late List<TrendingResult> listTrendingDay;
  late List<TrendingResult> listTrendingWeek;

  @override
  initState() {
    super.initState();
    listTvPopular = [];
    listMoviePopular = [];
    listTrendingDay = [];
    listTrendingWeek = [];

    homeCubit = context.read<HomeCubit>();
    homeCubit.init();
    searchCubit = context.read<SearchCubit>();
    searchC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              buildWelcome(),
              const SizedBox(
                height: 10,
              ),
              buildSearchBar(),
              const SizedBox(
                height: 10,
              ),
              buildSearchResult(),
              const SizedBox(
                height: 10,
              ),
              //What's pupular
              buildListPopular(),
              //Latest Trailers
              //buildLatestTrailers(),
              //Trending
              const SizedBox(
                height: 15,
              ),
              buildHeaderTrending(),
              const SizedBox(
                height: 10,
              ),
              buildListTrending(),
              //Join Today
              const SizedBox(
                height: 15,
              ),
              //buildJoinToday(),
              //Leaderboard
              //buildLeaderBoardFake(),
              //Footer
              //buildFooter(),
            ],
          )),
    );
  }

  Widget buildSearchResult() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => state is SearchLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state is SearchLoaded
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Xem tất cả kết quả tìm kiếm',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (var searchItem in state.listSearch.where(
                          (searchItem) =>
                              state.listSearch.indexOf(searchItem) < 3))
                        PosterSearch(
                          mediaType: searchItem.mediaType,
                          name: searchItem.title ?? searchItem.name ?? '',
                          date: (searchItem.mediaType == MediaType.MOVIE &&
                                  searchItem.releaseDate != null)
                              ? getShortDate(
                                  searchItem.releaseDate.toString(), 10)
                              : (searchItem.mediaType == MediaType.TV &&
                                      searchItem.firstAirDate != null)
                                  ? getShortDate(
                                      searchItem.firstAirDate.toString(), 10)
                                  : '',
                          imgLink: searchItem.mediaType == MediaType.PERSON
                              ? '${AppConfig.baseUrlImg}${searchItem.profilePath.toString()}'
                              : '${AppConfig.baseUrlImg}${searchItem.posterPath.toString()}',
                          id: searchItem.id!,
                          pageIndex: searchItem.mediaType == MediaType.TV
                              ? 0
                              : searchItem.mediaType == MediaType.MOVIE
                                  ? 1
                                  : 2,
                          overview: searchItem.overview ?? '',
                        ),
                    ],
                  ),
                )
              : state is SearchError
                  ? Text(
                      state.alert,
                      style: const TextStyle(color: Colors.blueAccent),
                    )
                  : const SizedBox(),
    );
  }

  Widget buildWelcome() {
    return Stack(children: [
      CachedNetworkImage(
        height: 200,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        imageUrl:
            "https://www.themoviedb.org/t/p/w1920_and_h600_multi_faces_filter(duotone,032541,01b4e4)/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg",
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
      Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(30),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Welcome.",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
                "Millions of movies, TV shows and people to discover. Explore now.",
                style: TextStyle(fontSize: 20, color: Colors.white))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20.0,
            activeBgColors: const [
              [Color(AppColors.darkBlue)],
              [Color(AppColors.darkBlue)]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            borderWidth: 1,
            minHeight: 20,
            borderColor: const [Colors.black],
            inactiveFgColor: Colors.black,
            //index
            initialLabelIndex: homeCubit.popularToggle,
            totalSwitches: 2,
            animate: true,
            animationDuration: 300,
            labels: const ['On TV', 'In Theaters'],
            customWidths: const [100, 100],
            radiusStyle: true,
            onToggle: (index) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                homeCubit.changePopularToggle(index!);
              });
            },
          ),
        ),
      ),
    ]);
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: searchC,
        style: const TextStyle(color: Color(AppColors.darkBlue)),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: "Search movie, TV show,...",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.white, width: 1)),
            suffixIcon: InkWell(
                onTap: () async {
                  searchCubit.emit(const SearchLoading());
                  await Future.delayed(const Duration(seconds: 1));
                  searchCubit.emit(const SearchInitial());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xff1DD4AC), Color(0xff02B5E0)])),
                  width: 80,
                  alignment: Alignment.center,
                  child: const Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ))),
        onChanged: (text) {
          searchCubit.emit(const SearchLoading());
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            searchCubit.fetchSearchMulti(text);
          });
        },
      ),
    );
  }

  Widget buildListPopular() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/images/red-wave-background.png"))),
          child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) async {
                if (state is HomePopularLoading) {
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (homeCubit.popularToggle == 0) {
                    homeCubit.fetchPopularTv();
                  } else {
                    homeCubit.fetchPopularMovie();
                  }
                }
                setList(state);
              },
              builder: (context, state) => (homeCubit.popularToggle == 0 &&
                          listTvPopular.isEmpty) ||
                      (homeCubit.popularToggle == 1 && listMoviePopular.isEmpty)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < 5; i++) const PosterShimmer()
                      ],
                    )
                  : (homeCubit.popularToggle == 0 && listTvPopular.isNotEmpty)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var tv in listTvPopular)
                              buildPoster(
                                  mediaType: MediaType.TV,
                                  pageIndex: 0,
                                  id: tv.id!,
                                  name: tv.name.toString(),
                                  date: getShortDate(
                                      tv.firstAirDate.toString(), 10),
                                  imgLink:
                                      '${AppConfig.baseUrlImg}${tv.posterPath}',
                                  percent: tv.voteAverage! * 10)
                          ],
                        )
                      : (homeCubit.popularToggle == 1 &&
                              listMoviePopular.isNotEmpty)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var movie in listMoviePopular)
                                  Poster(
                                      mediaType: MediaType.MOVIE,
                                      pageIndex: 1,
                                      id: movie.id!,
                                      name: movie.title.toString(),
                                      date: movie.releaseDate
                                          .toString()
                                          .substring(0, 10),
                                      imgLink:
                                          '${AppConfig.baseUrlImg}${movie.posterPath}',
                                      percent: movie.voteAverage! * 10)
                              ],
                            )
                          : const SizedBox()),
        ));
  }

  Widget buildLatestTrailers() {
    return Container(
      color: const Color(0xff425C71),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Latest Trailers",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [Color(AppColors.lightGreen)],
                    [Color(AppColors.lightGreen)]
                  ],
                  activeFgColor: const Color(0xff425C71),
                  inactiveBgColor: const Color(0xff425C71),
                  borderWidth: 1,
                  minHeight: 20,
                  borderColor: const [Color(0xff7CEDBF)],
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  animate: true,
                  animationDuration: 300,
                  labels: const ['On TV', 'In Theaters'],
                  customWidths: const [100, 100],
                  radiusStyle: true,
                  onToggle: (index) {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: const [
                Text(
                  "This panel didn't return any results. Try ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "refreshing",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  " it.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildHeaderTrending() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTextMainTitle(text: "Trending"),
          const SizedBox(
            width: 10,
          ),
          ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20.0,
            activeBgColors: const [
              [Color(AppColors.darkBlue)],
              [Color(AppColors.darkBlue)]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            borderWidth: 1,
            minHeight: 20,
            borderColor: const [Colors.black],
            inactiveFgColor: Colors.black,
            initialLabelIndex: homeCubit.trendingToggle,
            totalSwitches: 2,
            animate: true,
            animationDuration: 300,
            labels: const ['Today', 'This week'],
            customWidths: const [100, 100],
            radiusStyle: true,
            onToggle: (index) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                homeCubit.changeTrendingToggle(index!);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTrending() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/wave-background.png'))),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) async {
                if (state is HomeTrendingLoading) {
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (homeCubit.trendingToggle == 0) {
                    homeCubit.fetchTrendingDay();
                  } else {
                    homeCubit.fetchTrendingWeek();
                  }
                }
                setList(state);
              },
              builder: (context, state) => (homeCubit.trendingToggle == 0 &&
                          listTrendingDay.isEmpty) ||
                      (homeCubit.trendingToggle == 1 &&
                          listTrendingWeek.isEmpty)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < 5; i++) const PosterShimmer()
                      ],
                    )
                  : homeCubit.trendingToggle == 0
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var poster in listTrendingDay)
                              (poster.mediaType == homeCubit.currentToggle)
                                  ? Poster(
                                      pageIndex:
                                          poster.mediaType == MediaType.TV
                                              ? 0
                                              : 1,
                                      mediaType: poster.mediaType,
                                      id: poster.id!,
                                      name: poster.title != null
                                          ? poster.title.toString()
                                          : poster.originalName.toString(),
                                      date: poster.releaseDate.toString() !=
                                              "null"
                                          ? poster.releaseDate
                                              .toString()
                                              .substring(0, 10)
                                          : poster.firstAirDate
                                              .toString()
                                              .substring(0, 10),
                                      imgLink:
                                          '${AppConfig.baseUrlImg}${poster.posterPath}',
                                      percent: poster.voteAverage! * 10)
                                  : const SizedBox()
                          ],
                        )
                      : homeCubit.trendingToggle == 1
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var poster in listTrendingWeek)
                                  (poster.mediaType == homeCubit.currentToggle)
                                      ? Poster(
                                          mediaType: poster.mediaType,
                                          pageIndex:
                                              poster.mediaType == MediaType.TV
                                                  ? 0
                                                  : 1,
                                          id: poster.id!,
                                          name: poster.title != null
                                              ? poster.title.toString()
                                              : poster.originalName.toString(),
                                          date: poster.releaseDate.toString() !=
                                                  "null"
                                              ? poster.releaseDate
                                                  .toString()
                                                  .substring(0, 10)
                                              : poster.firstAirDate
                                                  .toString()
                                                  .substring(0, 10),
                                          imgLink:
                                              '${AppConfig.baseUrlImg}${poster.posterPath}',
                                          percent: poster.voteAverage! * 10)
                                      : const SizedBox()
                              ],
                            )
                          : const SizedBox(),
            )));
  }

  Widget buildLeaderBoardFake() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTextMainTitle(text: 'Leaderboard'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        " ● ",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff77ECBE)),
                      ),
                      Text("All Time Edits")
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        " ● ",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xffEC846A)),
                      ),
                      Text("Edits This Week")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //UserInLeaderboard
        const UserInLeaderBoard(
          imageLink:
              "https://elead.com.vn/wp-content/uploads/2020/04/anh-dep-hoa-huong-duong-va-mat-troi_022805970-1-1181x800-6.jpg",
          name: "Thanh Phong Cao",
          numofAllTime: 170567,
          totalAllTime: 200000,
          numofThisWeek: 2000,
          totalThisWeek: 4000,
        ),
        const UserInLeaderBoard(
          imageLink:
              "https://elead.com.vn/wp-content/uploads/2020/04/anh-dep-hoa-huong-duong-va-mat-troi_022805970-1-1181x800-6.jpg",
          name: "Thanh Phong Cao",
          numofAllTime: 170567,
          totalAllTime: 200000,
          numofThisWeek: 2000,
          totalThisWeek: 4000,
        ),
        const UserInLeaderBoard(
          imageLink:
              "https://elead.com.vn/wp-content/uploads/2020/04/anh-dep-hoa-huong-duong-va-mat-troi_022805970-1-1181x800-6.jpg",
          name: "Thanh Phong Cao",
          numofAllTime: 170567,
          totalAllTime: 200000,
          numofThisWeek: 2000,
          totalThisWeek: 4000,
        ),
        const UserInLeaderBoard(
          imageLink:
              "https://elead.com.vn/wp-content/uploads/2020/04/anh-dep-hoa-huong-duong-va-mat-troi_022805970-1-1181x800-6.jpg",
          name: "Thanh Phong Cao",
          numofAllTime: 170567,
          totalAllTime: 200000,
          numofThisWeek: 2000,
          totalThisWeek: 4000,
        ),
        const UserInLeaderBoard(
          imageLink:
              "https://elead.com.vn/wp-content/uploads/2020/04/anh-dep-hoa-huong-duong-va-mat-troi_022805970-1-1181x800-6.jpg",
          name: "Thanh Phong Cao",
          numofAllTime: 170567,
          totalAllTime: 200000,
          numofThisWeek: 2000,
          totalThisWeek: 4000,
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildJoinToday() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://www.themoviedb.org/t/p/w1920_and_h800_multi_faces_filter(duotone,190235,ad47dd)/lMnoYqPIAVL0YaLP5YjRy7iwaYv.jpg'))),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Join Today",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              children: [
                const Text(
                  "Get access to maintain your own custom personal lists, track what you've seen and search and filter for what to watch next—regardless if it's in theatres, on TV or available on popular streaming services like .",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "● Enjoy TMDB ad free",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "● Maintain a personal watchlist",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "● Filter by your subscribed streaming services and find something to watch",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "● Log the movies and TV shows you've seen",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "● Build custom lists",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff805BE7)),
                      child: InkWell(
                          onTap: () => goToPageUrl(
                              'https://www.themoviedb.org/u/$currentUsername'),
                          child: const Text("Join now"))),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      width: MediaQuery.of(context).size.width,
      color: const Color(AppColors.darkBlue),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/square_logo.png",
                  height: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      goToPageUrl(
                          'https://www.themoviedb.org/u/$currentUsername');
                    },
                    child: Text(
                      currentUsername == ''
                          ? "JOIN THE COMUNITY"
                          : 'Hi $currentUsername',
                      style: const TextStyle(
                          color: Color(0xff01B4E4),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Text("THE BASICS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => goToPageUrl('https://www.themoviedb.org/about'),
                  child: const Text(
                    "About TMDB",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl(
                      'https://www.themoviedb.org/about/staying-in-touch'),
                  child: const Text("Contact us",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl(
                      'https://www.themoviedb.org/about/staying-in-touch'),
                  child: const Text("Support Forums",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () => goToPageUrl(
                        'https://www.themoviedb.org/documentation/api'),
                    child: const Text("API",
                        style: TextStyle(color: Colors.white))),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl('https://status.themoviedb.org/'),
                  child: const Text("System Status",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Text("GET INVOLVED",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => goToPageUrl('https://www.themoviedb.org/bible'),
                  child: const Text("Contribution Bible",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () =>
                      goToPageUrl('https://www.themoviedb.org/movie/new'),
                  child: const Text("Add New Movie",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl('https://www.themoviedb.org/tv/new'),
                  child: const Text("Add New TV Show",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Text(
                  "COMMUNITY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => goToPageUrl(
                      'https://www.themoviedb.org/documentation/community/guidelines'),
                  child: const Text("Guidelines",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () =>
                      goToPageUrl('https://www.themoviedb.org/discuss'),
                  child: const Text("Discussions",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () =>
                      goToPageUrl('https://www.themoviedb.org/leaderboard'),
                  child: const Text("Leaderboard",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl('https://twitter.com/themoviedb'),
                  child: const Text("Twitter",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Text("LEGAL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () =>
                      goToPageUrl('https://www.themoviedb.org/terms-of-use'),
                  child: const Text("Term of Use",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => goToPageUrl(
                      'https://www.themoviedb.org/documentation/api/terms-of-use'),
                  child: const Text("API Terms of Use",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () =>
                      goToPageUrl('https://www.themoviedb.org/privacy-policy'),
                  child: const Text("Privacy Policy",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setList(state) {
    if (state is HomeLoadedPopularTv) {
      listTvPopular = state.listTvPopular;
    } else if (state is HomeLoadedPopularMovie) {
      listMoviePopular = state.listMoviePopular;
    } else if (state is HomeLoadedTrendingToday) {
      listTrendingDay = state.listTrendingDay;
    } else if (state is HomeLoadedTrendingThisWeek) {
      listTrendingWeek = state.listTrendingWeek;
    }
  }

  Poster buildPoster({MediaType? mediaType, required int pageIndex,
    required int id, required String name,
    String? date, required String imgLink, double? percent}) {
    return Poster(
        mediaType: mediaType,
        pageIndex: pageIndex,
        id: id,
        name: name,
        date: date,
        imgLink: imgLink,
        percent: percent);
  }
}
