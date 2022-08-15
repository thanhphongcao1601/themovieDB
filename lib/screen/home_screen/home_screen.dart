import 'package:ex6/api/api_client.dart';
import 'package:ex6/app/app_cubit.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/repository/search_repo.dart';
import 'package:ex6/repository/trending_repo.dart';
import 'package:ex6/repository/tv_repo.dart';
import 'package:ex6/screen/home_screen/home_content_view.dart';
import 'package:ex6/widgets/left_slider/left_slider_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'home_cubit/home_cubit.dart';
import 'search_cubit/search_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SearchRequest searchRequest;
  late final TvRequest tvRequest;
  late final MovieRequest movieRequest;
  late final TrendingRequest trendingRequest;
  late final APIClient apiClient;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiClient = BlocProvider.of<AppCubit>(context).apiClient;

    searchRequest = SearchRequest(apiClient);
    tvRequest = TvRequest(apiClient);
    movieRequest = MovieRequest(apiClient);
    trendingRequest = TrendingRequest(apiClient);
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
              title: SizedBox(
                height: 25,
                child: Image.asset("assets/images/logo.png"),
              ),
              drawerIconColor: Colors.white,
              trailing: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
            slider: const LeftSlider(),
            child: MultiBlocProvider(providers: [
              BlocProvider<HomeCubit>(
                  create: (_) => HomeCubit(tvRequest, movieRequest, trendingRequest)),
              BlocProvider<SearchCubit>(
                  create: (_) => SearchCubit(searchRequest))
            ], child: const ContentView())),
    ),
        ));
  }
}
