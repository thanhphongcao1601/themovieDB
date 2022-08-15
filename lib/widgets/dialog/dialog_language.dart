import 'package:ex6/configs/constant.dart';
import 'package:ex6/local_data/data_home.dart';
import 'package:flutter/material.dart';
import '../../screen/home_screen/home_screen.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: const Center(
        child: Text(
          'Chọn ngôn ngữ',
          style: TextStyle(
            color: Color(AppColors.darkBlue),
          ),
        ),
      ),
      content: SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listLanguage.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        currentLanguage = listLanguage[index].iso6391!;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                                (route) => false);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: Text(
                                listLanguage[index].iso6391!.toUpperCase(),
                                style: const TextStyle(fontSize: 18),
                              )),
                              Text(listLanguage[index].englishName!,
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          const Divider(
                            thickness: 0.8,
                            color: Colors.black45,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
      contentPadding:
          const EdgeInsets.only(bottom: 0, top: 10, left: 10, right: 10),
    );
  }
}
