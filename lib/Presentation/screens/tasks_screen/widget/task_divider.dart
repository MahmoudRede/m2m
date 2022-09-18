import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';

class TaskDivider extends StatelessWidget {
  const TaskDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Container(
        height: SizeConfig.height * 0.08,
        child: Row(
          children: [
            Lottie.asset(AssetsManager.taskCompeteImage),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              'Today tasks,',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
