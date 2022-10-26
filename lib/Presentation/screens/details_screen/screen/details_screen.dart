import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/verify_payment_screen/verify_payment_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/CustomBoxInformation.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit,PaymentStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: SizeConfig.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorManager.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(
                    SizeConfig.height*0.025,
                  ),
                  child: CustomActionButton(
                    boxIcon: FontAwesomeIcons.chevronLeft,
                    iconColor: ColorManager.white,
                    backgroundColor: ColorManager.secondDarkColor,
                    onTap: ()=>  Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Lottie.asset(AssetsManager.investmentImage),
                  ),
                ),
                Container(
                  height: SizeConfig.height * 0.55,
                  width: SizeConfig.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: ColorManager.black,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      SizeConfig.height*0.03,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // package name text
                        Text(
                          "1st Package 200\$",
                          style: GoogleFonts.roboto(
                            color: ColorManager.lightGrey2,
                            fontSize: SizeConfig.headline1Size,
                            fontWeight: FontWeight.bold,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height * 0.015,
                        ),
                        // package details text
                        Text(
                          "Deposit 200\$, 5 Tasks for each Task 1.2\$, total income for months 180\$. "
                              "\nIf you don\'t invite anyone after the first months the task rate become 0.2\$.",
                          style: GoogleFonts.roboto(
                            color: ColorManager.lightGrey2,
                            fontSize: SizeConfig.headline3Size,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height * 0.035,
                        ),



                        // package properties
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomBoxInformation(
                                boxIcon: FontAwesomeIcons.calendarCheck,
                                label: "3 ${AppLocalizations.of(context)!.translate('months').toString()}",
                            ),
                            CustomBoxInformation(
                                boxIcon: FontAwesomeIcons.clock,
                                label: "5 ${AppLocalizations.of(context)!.translate('tasks').toString()}",
                            ),
                            const CustomBoxInformation(
                                boxIcon: FontAwesomeIcons.star,
                                label: "1.2\$",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height *0.03,
                        ),



                        // payment button
                        DefaultButton(
                          text: AppLocalizations.of(context)!.translate('payment').toString(),
                          onPressed: ()=>PaymentCubit.get(context).urlLunch(paymentLink: 'https://paypal.me/MmdouhMohamed?country.x=EG&locale.x=ar_EG'),
                        ),
                        SizedBox(
                          height: SizeConfig.height *0.02,
                        ),



                        // confirm payment button
                        DefaultButton(
                            text: AppLocalizations.of(context)!.translate('confirmPayment').toString(),
                            onPressed: ()=>navigateTo( context, const VerifyPaymentScreen())
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}