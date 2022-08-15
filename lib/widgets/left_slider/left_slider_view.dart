import 'package:ex6/api/api_client.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/local_data/data_home.dart';
import 'package:ex6/repository/genres_repo.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/user_repo.dart';
import 'package:ex6/screen/login_screen/login_cubit/login_cubit.dart';
import 'package:ex6/screen/login_screen/login_screen.dart';
import 'package:ex6/screen/movie_screen/movie_cubit/movie_cubit.dart';
import 'package:ex6/screen/movie_screen/popular_movie_screen.dart';
import 'package:ex6/style.dart';
import 'package:ex6/widgets/dialog/dialog_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeftSlider extends StatefulWidget {
  const LeftSlider({Key? key}) : super(key: key);

  @override
  State<LeftSlider> createState() => _LeftSliderState();
}

class _LeftSliderState extends State<LeftSlider> {
  late APIClient apiClient;

  late bool movieSub;
  late bool tvShowSub;
  late bool peopleSub;
  late bool moreSub;
  late bool isLocked;

  late final UserRequest userRepo;
  late final MovieRequest movieRequest;
  late final GenreRequest genreRequest;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiClient = APIClient();

    movieSub = false;
    tvShowSub = false;
    peopleSub = false;
    moreSub = false;
    isLocked = currentAuthenticate;

    userRepo = UserRequest(apiClient);
    movieRequest = MovieRequest(apiClient);
    genreRequest = GenreRequest(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff032541),
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildLogOut(),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const LanguageDialog());
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          child: Text(currentLanguage.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white))),
                    ),
                    buildSetLocalAuth(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(AppColors.lightGreen)),
                      child: Center(
                        child: Text(
                          currentUsername != ''
                              ? currentUsername.substring(0, 1).toUpperCase()
                              : '?',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        currentUsername,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xff032541)),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Search movie, TV show,...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1)),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.search,
                            size: 18,
                          ),
                        )),
                    onChanged: (text) {},
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const TitleSlideBar(title: "Tham gia TMDB"),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: buildTitleSlideBar(title: "Movies"),
                  onTap: () {
                    setState(() {
                      movieSub = !movieSub;
                    });
                  },
                ),
                Visibility(
                  visible: movieSub,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (_) => MovieCubit(movieRequest,genreRequest),
                                        child: const MoviePopularScreen())));
                          },
                          child: buildSubTitleSlideBar(title: "Popular")),
                      buildSubTitleSlideBar(title: "Now Playing"),
                      buildSubTitleSlideBar(title: "Upcoming"),
                      buildSubTitleSlideBar(title: "Top Rated"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: buildTitleSlideBar(title: "TV Show"),
                  onTap: () {
                    setState(() {
                      tvShowSub = !tvShowSub;
                    });
                  },
                ),
                Visibility(
                  visible: tvShowSub,
                  child: Column(
                    children: [
                      buildSubTitleSlideBar(title: "Popular"),
                      buildSubTitleSlideBar(title: "Airing Today"),
                      buildSubTitleSlideBar(title: "On TV"),
                      buildSubTitleSlideBar(title: "Top Rated"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: buildTitleSlideBar(title: "People"),
                  onTap: () {
                    setState(() {
                      peopleSub = !peopleSub;
                    });
                  },
                ),
                Visibility(
                  visible: peopleSub,
                  child: Column(
                    children: [
                      buildSubTitleSlideBar(title: "Popular People"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: buildTitleSlideBar(title: "More"),
                  onTap: () {
                    setState(() {
                      moreSub = !moreSub;
                    });
                  },
                ),
                Visibility(
                  visible: moreSub,
                  child: Column(
                    children: [
                      buildSubTitleSlideBar(title: "Discussions"),
                      buildSubTitleSlideBar(title: "Leaderboard"),
                      buildSubTitleSlideBar(title: "Support"),
                      buildSubTitleSlideBar(title: "API"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogOut(){
    return InkWell(
        onTap: () async {
          // Obtain shared preferences.
          final prefs = await SharedPreferences.getInstance();
          var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))),
                title: const Text('Đăng xuất'),
                content: const Text(
                    'Bạn có chắc muốn đăng xuất?'),
                titlePadding: const EdgeInsets.fromLTRB(
                    20, 20, 20, 10),
                contentPadding: const EdgeInsets.fromLTRB(
                    20, 10, 20, 0),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Hủy')),
                  TextButton(
                      onPressed: () {
                        if (isLoggedIn) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider(
                                        create: (_) =>
                                            LoginCubit(userRepo),
                                        child:
                                        const Login())),
                                (Route<dynamic> route) => false,
                          );
                          prefs.remove('isLoggedIn');
                          prefs.remove('currentUsername');
                          prefs.remove('currentPassword');
                          prefs.remove('currentToken');
                          prefs.remove('isAuthenticate');
                        }
                      },
                      child: const Text('OK')),
                ],
              ));
        },
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ));
  }

  Widget buildSetLocalAuth(){
    return InkWell(
        onTap: () async {
          // Obtain shared preferences.
          final prefs = await SharedPreferences.getInstance();

          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))),
                title: const Text(
                  'Khóa ứng dụng',
                  style: TextStyle(color: Color(AppColors.darkBlue)),
                ),
                content: SizedBox(
                    width:
                    MediaQuery.of(context).size.width,
                    child: const Text(
                        'Khóa ứng dụng bằng xác thực của điện thoại')),
                actionsPadding: EdgeInsets.zero,
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      prefs.setBool(
                          'isAuthenticate', false);
                      Navigator.pop(context, 'Cancel');
                      currentAuthenticate = false;
                      setState(() {
                        isLocked = false;
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          backgroundColor:
                          Colors.redAccent,
                          content: Text(
                              'Hủy xác thực khi vào ứng dụng')));
                    },
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                          color: Color(AppColors.lightBlue)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap,
                      ),
                      onPressed: () {
                        prefs.setBool(
                            'isAuthenticate', true);
                        Navigator.pop(context, 'OK');
                        currentAuthenticate = true;
                        setState(() {
                          isLocked = true;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            backgroundColor:
                            Color(AppColors.lightGreen),
                            content: Text(
                                'Ứng dụng đã được bảo vệ bằng xác thực')));
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Color(AppColors.lightBlue)),
                      )),
                ],
              ));
        },
        child: isLocked
            ? const Icon(
          Icons.lock,
          color: Colors.green,
        )
            : const Icon(
          Icons.lock_open,
          color: Colors.red,
        ));
  }
}
