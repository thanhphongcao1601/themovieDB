import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/model/movie/movie_popular.dart';
import 'package:ex6/repository/genres_repo.dart';
import 'package:ex6/repository/movie_repo.dart';
import 'package:ex6/screen/home_screen/home_screen.dart';
import 'package:ex6/screen/movie_screen/movie_cubit/movie_cubit.dart';
import 'package:ex6/screen/movie_screen/movie_cubit/movie_state.dart';
import 'package:ex6/widgets/left_slider/left_slider_view.dart';
import 'package:ex6/widgets/poster/poster_movie_and_tv.dart';
import 'package:ex6/widgets/shimmer/poster_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:group_radio_button/group_radio_button.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MoviePopularScreen extends StatefulWidget {
  const MoviePopularScreen({Key? key}) : super(key: key);

  @override
  State<MoviePopularScreen> createState() => _MoviePopularScreenState();
}

class _MoviePopularScreenState extends State<MoviePopularScreen> {
  late final MovieCubit movieCubit;
  late final APIClient apiClient;
  late final MovieRequest movieRequest;
  late final GenreRequest genreRequest;

  final scrollController = ScrollController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final List<String> _status = ["Pending", "Released", "Blocked"];

  bool isShowFilter = false;
  String dropdownValue = 'Popularity Descending';
  String _verticalGroupValue = "Pending";
  bool isSearchAllAvailabilities = false;
  Timer? _debounce;

  List<MoviePopularResult> listMoviePopular = [];
  List listGenre = [];

  void loadMoreWhenScrollNearBottom(context) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels /
              scrollController.position.maxScrollExtent >
          0.7) {
        //fetch only 1 in 0.2s
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 200), () {
          movieCubit.fetchMorePopularMovie();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.fetchMorePopularMovie();
    movieCubit.fetchListGenre();
    loadMoreWhenScrollNearBottom(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () async {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    scrollController.animateTo(
                        scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(AppColors.darkBlue),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.keyboard_double_arrow_up,
                    color: Colors.white,
                    size: 35,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
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
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
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
                      onTap: () async {
                        print('back');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                                (route) => false);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                slider: const LeftSlider(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          buildSortBy(),
                          const SizedBox(
                            height: 10,
                          ),
                          buildFilter(),
                          buildContentOfFilter(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(thickness: 2,),
                          buildListPopularMovie(),
                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }

  Widget buildSortBy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Sort by',
          style: TextStyle(fontSize: 20),
        ),
        DropdownButton2<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          //elevation: 16,
          style:
              const TextStyle(color: Color(AppColors.darkBlue), fontSize: 16),
          underline: Container(
            height: 2,
            color: const Color(AppColors.darkBlue),
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'Popularity Descending',
            'Popularity Ascending',
            'Rating Descending',
            'Rating Ascending',
            'Release Date Descending',
            'Release Date Ascending',
            'Title A-Z'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildFilter() {
    return InkWell(
      onTap: () {
        setState(() {
          isShowFilter = !isShowFilter;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Filter', style: TextStyle(fontSize: 20)),
          isShowFilter
              ? const Icon(Icons.arrow_drop_up)
              : const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  Widget buildContentOfFilter() {
    return Visibility(
      visible: isShowFilter,
      child: Column(children: [
        const Text('Show me',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        RadioGroup<String>.builder(
          groupValue: _verticalGroupValue,
          onChanged: (value) => setState(() {
            _verticalGroupValue = value!;
          }),
          items: _status,
          itemBuilder: (item) => RadioButtonBuilder(
            item,
          ),
        ),
        const Text('Abilities',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Checkbox(
                value: isSearchAllAvailabilities,
                onChanged: (value) {
                  setState(() {
                    isSearchAllAvailabilities = value!;
                  });
                }),
            const Text('Search all availabilities?')
          ],
        ),
        const Text('Release Day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: dateFromController,
            //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                //icon of text field
                labelText: "From" //label text of field
                ),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateFromController.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: dateToController,
            //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                //icon of text field
                labelText: "To" //label text of field
                ),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateToController.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Genres',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        BlocBuilder<MovieCubit,MovieState>(
          builder: (context,state) {
            if (listGenre.isNotEmpty){
              return buildListMovieGenres(listGenre);
            }
            return const SizedBox();
          }
        ),
      ]),
    );
  }

  Widget buildListPopularMovie() {
    return BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is MoviePopularLoaded) {
            listMoviePopular.addAll(state.listMoviePopular);
          }
          if (state is ListGenreLoaded){
            listGenre = state.listGenre;
          }
        },
        builder: (context, state) => listMoviePopular.isEmpty
            ? GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 3 / 7,
                children: [for (var i = 0; i < 10; i++) const PosterShimmer()],
              )
            : listMoviePopular.isNotEmpty
                ? GridView.count(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 7,
                    children: [
                      for (var movie in listMoviePopular)
                        Poster(
                            pageIndex: 1,
                            id: movie.id!,
                            name: movie.title.toString(),
                            date:
                                getShortDate(movie.releaseDate.toString(), 10),
                            imgLink:
                                '${AppConfig.baseUrlImg}${movie.posterPath}',
                            percent: movie.voteAverage! * 10),
                      //lay shimmer loadmore vua khit man hinh
                      for (var i = 0; i < 6 - listMoviePopular.length % 3; i++)
                        const PosterShimmer()
                    ],
                  )
                : const SizedBox());
  }

  Widget buildListMovieGenres(listGenre) {
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
              for (var genres in listGenre)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    genres.name!,
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
}
