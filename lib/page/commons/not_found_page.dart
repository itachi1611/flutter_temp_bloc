import 'package:flutter/material.dart';
import 'package:flutter_temp/extensions/widget_ext.dart';
import 'package:flutter_temp/router/router_extension.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../common/app_animations.dart';
import '../../common/app_colors.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.pureWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppAnimation.pageNotFound, // Example Lottie animation
              fit: BoxFit.cover,
            ).flex(3),
            const Gap(20),
            const Text(
              'Oops! The page you are looking for does not exist.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).flex(2),
            const Gap(10),
            ElevatedButton(
              onPressed: () => context.goHome,
              child: const Text('Home'),
            ),
          ],
        ).flex(94),
      ),
    );
  }
}
