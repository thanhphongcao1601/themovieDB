import 'package:cached_network_image/cached_network_image.dart';
import 'package:ex6/api/api_client.dart';
import 'package:ex6/repository/people_repo.dart';
import 'package:ex6/screen/detail_people_screen/people_cubit/detail_people_cubit.dart';
import 'package:ex6/screen/detail_people_screen/detail_people_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Cast extends StatefulWidget {
  const Cast(
      {Key? key,
        required this.name,
        required this.imgLink,
        required this.id, required this.knowFor,})
      : super(key: key);
  final String name;
  final String imgLink;
  final int id;
  final String knowFor;

  @override
  State<Cast> createState() => _CastState();
}

class _CastState extends State<Cast> {
  late APIClient apiClient;
  late PeopleRequest peopleRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiClient = APIClient();
    peopleRequest = PeopleRequest(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('cast ${widget.id}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlocProvider(
            create: (_)=>DetailPeopleCubit(peopleRequest),
            child: PeopleScreen(id: widget.id,))));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 200,
              width: 130,
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
          Container(
              alignment: Alignment.center,
              width: 130,
              child: Text(
                widget.knowFor,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                //softWrap: false,
              )),
        ],
      ),
    );
  }
}
