import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/model/payment_model.dart';
import 'package:m2m/Presentation/screens/admin_screens/payment_screens/payment_requests_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final PaymentModel paymentModel;
  const ConfirmPaymentScreen({Key? key, required this.paymentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit,PaymentStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = PaymentCubit.get(context);
        debugPrint(paymentModel.paymentImage.toString());
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Confirm Payment',
              style: TextStyle(
                fontSize: SizeConfig.headline2Size,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(
              SizeConfig.height*0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // uploaded image widget
                Expanded(
                  child: Container(
                    height: SizeConfig.height*0.7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorManager.secondDarkColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.white,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: NetworkImage(paymentModel.paymentImage.toString()),
                        fit: BoxFit.fill,
                        height: double.maxFinite,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),

                // upload button
                state is ConfirmPaymentLoadingState?
                const CircularProgressIndicator(
                  color: ColorManager.primary,
                ):DefaultButton(
                  text: AppLocalizations.of(context)!.translate('confirm').toString(),
                  onPressed: (){
                    cubit.confirmPayment(paymentModel: paymentModel).then((value) {
                      customToast(title: "Confirm Payment Success" , color: ColorManager.gold);
                      navigateAndRemove(context, const PaymentRequestsScreen());
                    });
                  },
                  color: ColorManager.secondDarkColor,
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
