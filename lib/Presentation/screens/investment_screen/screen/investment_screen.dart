import 'package:flutter/material.dart';
import 'package:m2m/Presentation/screens/investment_screen/widget/Investment_custom_appbar.dart';
import 'package:m2m/Presentation/screens/investment_screen/widget/default_text_field.dart';
import 'package:m2m/Presentation/screens/investment_screen/widget/investment_divider.dart';
import 'package:m2m/Presentation/screens/investment_screen/widget/investment_welcome_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amountController = TextEditingController();
    return Scaffold(
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// screen appBar
            const InvestmentCustomAppbar(),
            /// Screen Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// instructions card
                    const InvestmentWelcomeCard(),
                    SizedBox(
                      height: SizeConfig.height *0.04,
                    ),
                    const InvestmentDivider(),
                    /// add amount of money investment
                    DefaultTextField(
                        hintText: 'Enter amount start 1000\$ to 10000\$',
                        controller: amountController,
                        textInputType: TextInputType.number,
                        prefixIcon: Icons.monetization_on_outlined,
                    ),
                    SizedBox(
                      height: SizeConfig.height *0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width*0.06,
                      ),
                      child: Text(
                        'Months profit 10% :',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: SizeConfig.headline2Size,
                          color: ColorManager.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    /// show months profit
                    DefaultTextField(
                      hintText: 'Months profit',
                      controller: amountController,
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.monetization_on_outlined,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width*0.06,
                      ),
                      child: Text(
                        'Total profit at 6 months:',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: SizeConfig.headline2Size,
                          color: ColorManager.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    /// show total profit
                    DefaultTextField(
                      hintText: 'Total profit for 6 months',
                      controller: amountController,
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.monetization_on_outlined,
                    ),
                    SizedBox(
                      height: SizeConfig.height *0.04,
                    ),
                    /// join button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width*0.05,
                        vertical: SizeConfig.height * 0.01,
                      ),
                      child: DefaultButton(
                        text: 'Join Now',
                        onPressed: (){},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
