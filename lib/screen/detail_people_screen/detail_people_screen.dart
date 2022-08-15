import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/configs/constant.dart';
import 'package:ex6/helper/helper_function.dart';
import 'package:ex6/model/people/people_combine_credit.dart';
import 'package:ex6/model/people/people_detail.dart';
import 'package:ex6/model/timeline/timeline.dart';
import 'package:ex6/screen/detail_people_screen/people_cubit/detail_people_cubit.dart';
import 'package:ex6/screen/detail_people_screen/people_cubit/detail_people_state.dart';
import 'package:ex6/screen/home_screen/home_screen.dart';
import 'package:ex6/style.dart';
import 'package:ex6/widgets/left_slider/left_slider_view.dart';
import 'package:ex6/widgets/poster/poster_movie_and_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  late final DetailPeopleCubit peopleCubit;
  PeopleDetail? peopleDetail;
  List<PeopleCastAndCrew>? listPeopleKnowFor;
  List<PeopleCastAndCrew>? listPeopleCasts;
  List<PeopleCastAndCrew>? listPeopleCrews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetailPeopleCubit peopleCubit = context.read<DetailPeopleCubit>();
    peopleCubit.init(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(AppColors.darkBlue),
      child: SafeArea(
        child: SliderDrawer(
            appBar: buildSlideBar(),
            slider: const LeftSlider(),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocConsumer<DetailPeopleCubit, DetailPeopleState>(
                      listener: (context, state) {
                        if (state is DetailPeopleLoaded) {
                          peopleDetail = state.peopleDetail;
                        }
                        if (state is CreditPeopleLoaded) {
                          List<PeopleCastAndCrew> list = [];
                          if (state.knowFor.cast != null) {
                            list = list + state.knowFor.cast!;
                            listPeopleCasts = state.knowFor.cast!;
                          }
                          if (state.knowFor.crew != null) {
                            list = list + state.knowFor.crew!;
                            listPeopleCrews = state.knowFor.crew!;
                          }
                          listPeopleKnowFor = list;
                        }
                      },
                      builder: (context, state) => state is DetailPeopleLoading
                          ? Container(
                              color: const Color(AppColors.darkBlue),
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Column(
                              children: [
                                peopleDetail != null
                                    ? buildPeopleDetail(peopleDetail!)
                                    : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      listPeopleKnowFor != null
                                          ? buildPeopleKnowFor()
                                          : const SizedBox(),
                                      listPeopleCasts != null
                                          ? buildPeopleTimeline()
                                          : const SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    ));
  }

  Widget buildSlideBar() {
    return SliderAppBar(
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
          onTap: (){
            print('back');
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildPeopleDetail(PeopleDetail peopleDetail) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(AppColors.darkBlue), Colors.white])),
          child: Row(
            children: [
              //Avatar
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        imageUrl:
                            '${AppConfig.baseUrlImg}/${peopleDetail.profilePath}',
                        placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  // width: MediaQuery.of(context).size.width - 20,
                                  // height: 160,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey),
                                ))),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      peopleDetail.name.toString(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    //Main info
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      peopleDetail.knownForDepartment.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: buildTextMainTitle(text: "Biography"),
              ),
              const SizedBox(
                height: 5,
              ),
              peopleDetail.biography != ''
                  ? Text(peopleDetail.biography.toString())
                  : Lottie.asset('assets/lotties/empty.json',
                      height: 100, width: 100),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: buildTextSubTitle(text: 'Gender'),
                  ),
                  Text(peopleDetail.gender == 1
                      ? 'Female'
                      : peopleDetail.gender == 2
                          ? 'Male'
                          : 'null')
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 120, child: buildTextSubTitle(text: 'Birthday')),
                  Text(getShortDate(peopleDetail.birthday.toString(), 10))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 120,
                      child: buildTextSubTitle(text: 'Place of Birth')),
                  Expanded(
                    child: Text(peopleDetail.placeOfBirth.toString()),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 120,
                      child: buildTextSubTitle(text: 'Also Known As')),
                  Expanded(child: Text(peopleDetail.alsoKnownAs.toString()))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPeopleKnowFor() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: buildTextMainTitle(text: 'Known For'),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in listPeopleKnowFor!)
                Poster(
                  id: item.id,
                  pageIndex: item.mediaType! == MediaType.TV ? 0 : 1,
                  name: item.name ??= item.title ??= '',
                  imgLink: '${AppConfig.baseUrlImg}/${item.posterPath}',
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPeopleTimeline() {
    List<TimeLineValue> listTimeLineCast = [];
    List<TimeLineValue> listTimeLineCrew = [];
    List<String> listDepartment = [];

    for (var item in listPeopleCasts!) {
      String year = item.releaseDate.toString() != 'null'
          ? getShortDate(item.releaseDate.toString(), 4)
          : getShortDate(item.firstAirDate.toString(), 4);
      String name = item.name.toString();
      String role = item.character.toString() != 'null'
          ? item.character.toString()
          : item.job.toString();
      TimeLineValue timeLineValue = TimeLineValue(year, name, role, '');
      listTimeLineCast.add(timeLineValue);
    }

    //Sap xep timeline theo nam moi nhat
    listTimeLineCast.sort((a, b) => (a.year.toString().compareTo(b.year)));
    listTimeLineCast = listTimeLineCast.reversed.toList();

    for (var item in listPeopleCrews!) {
      String year = item.releaseDate.toString() != 'null'
          ? getShortDate(item.releaseDate.toString(), 4)
          : getShortDate(item.firstAirDate.toString(), 4);
      String name = item.title ?? '____';
      String role = item.character.toString() != 'null'
          ? item.character.toString()
          : item.job.toString();
      String department = item.department.toString();
      TimeLineValue timeLineValue = TimeLineValue(year, name, role, department);
      listTimeLineCrew.add(timeLineValue);
    }

    listTimeLineCrew.sort((a, b) => (a.year.toString().compareTo(b.year)));
    listTimeLineCrew = listTimeLineCrew.reversed.toList();

    for (var element in listPeopleCrews!) {
      print(element.department);
      if (!listDepartment.contains(element.department)) {
        if (element.department != null) {
          listDepartment.add(element.department.toString());
        }
      }
    }

    return Column(
      children: [
        listTimeLineCast.isNotEmpty
            ? Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildTextMainTitle(text: 'Acting'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (var item in listTimeLineCast)
                        TimelineTile(
                            indicatorStyle: const IndicatorStyle(
                                width: 10, color: Color(AppColors.darkBlue)),
                            alignment: TimelineAlign.manual,
                            lineXY: 0.2,
                            endChild: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text("${item.name} as ${item.role}"),
                            ),
                            startChild: Center(
                                child: item.year != 'null'
                                    ? Text(item.year)
                                    : const Text('____'))),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        for (String department in listDepartment)
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: buildTextMainTitle(text: department),
              ),
              const SizedBox(
                height: 10,
              ),
              for (var item in listTimeLineCrew)
                department == item.department
                    ? TimelineTile(
                        indicatorStyle: const IndicatorStyle(
                            width: 10, color: Color(AppColors.darkBlue)),
                        alignment: TimelineAlign.manual,
                        lineXY: 0.2,
                        endChild: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("${item.name} ... ${item.role}"),
                        ),
                        startChild: Center(
                            child: item.year != 'null'
                                ? Text(item.year)
                                : const Text('____')),
                      )
                    : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
