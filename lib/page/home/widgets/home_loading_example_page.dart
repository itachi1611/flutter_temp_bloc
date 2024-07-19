import 'package:flutter/material.dart';
import 'package:flutter_temp/extensions/loading_animation_ext.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_enums.dart';

class HomeLoadingExamplePage extends StatelessWidget {
  HomeLoadingExamplePage({super.key});

  final listTitle = LoadingAnimationType.values.map((e) => e.title).toList();
  final list = LoadingAnimationType.values.map((e) => e.loadingWidget).toList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(listTitle[index],
                  style: GoogleFonts.sourceCodePro(fontSize: 10)),
              list[index],
            ],
          ),
        );
      },
      itemCount: list.length,
    );
  }
}