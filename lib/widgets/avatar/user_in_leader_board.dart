import 'package:flutter/material.dart';

class UserInLeaderBoard extends StatelessWidget {
  const UserInLeaderBoard({
    Key? key,
    required this.imageLink,
    required this.name,
    required this.numofAllTime,
    required this.totalAllTime,
    required this.numofThisWeek,
    required this.totalThisWeek,
  }) : super(key: key);
  final String imageLink;
  final String name;
  final int numofAllTime;
  final int totalAllTime;
  final int numofThisWeek;
  final int totalThisWeek;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff032541),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xffB8FCCE), Color(0xff21D6AA)])),
                      height: 10,
                      width: numofAllTime /
                          totalAllTime *
                          (MediaQuery.of(context).size.width - 160),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      numofAllTime.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xffFDC070), Color(0xffD93D63)])),
                      height: 10,
                      width: (MediaQuery.of(context).size.width - 160) *
                          numofThisWeek /
                          totalThisWeek,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      numofThisWeek.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}