import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class StartScreenCard extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  const StartScreenCard({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.height*0.1,
        width: SizeConfig.width *0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: SizeConfig.headline1Size,
            color: ColorManager.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
