import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class CustomInvestmentRow extends StatelessWidget {
  const CustomInvestmentRow({
    Key? key,
    required this.title,
    required this.description,
    required this.profit,
  }) : super(key: key);

  final String title;
  final String description;
  final String profit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Container(
        height: SizeConfig.height * 0.07,
        width: SizeConfig.width,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.whiteDark,
              ),
              child: const Padding(
                padding:  EdgeInsets.all(10.0),
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetsManager.dollarImage),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: SizeConfig.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style:textManager(
                      color: ColorManager.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      description,
                      style: textManager(
                        color: ColorManager.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: ColorManager.SecondDarkColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                profit,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Roboto",
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}