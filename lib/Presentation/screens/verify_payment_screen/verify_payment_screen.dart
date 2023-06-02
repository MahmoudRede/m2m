import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';

class VerifyPaymentScreen extends StatelessWidget {
  const VerifyPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit,PaymentStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = PaymentCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Verify Payment',
              style: TextStyle(
                fontSize: SizeConfig.headline2Size,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical :SizeConfig.height*0.02,
              horizontal :SizeConfig.height*0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // uploaded image widget
                InkWell(
                  onTap: ()=>cubit.getPaymentImage(),
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
                    child: cubit.uploadedPaymentImage == null ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(
                          Icons.image_outlined,
                          color: ColorManager.lightBlue,
                          size: SizeConfig.height*0.05,
                        ),
                        Text(
                          'Upload your payment screen',
                          style: TextStyle(
                            fontSize: SizeConfig.headline4Size,
                            color: ColorManager.lightBlue,
                          ),
                        ),
                      ],
                    ) :
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: FileImage(cubit.uploadedPaymentImage!),
                        fit: BoxFit.fill,
                        height: double.maxFinite,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.05,
                ),

                // upload button
                state is UploadPaymentImageLoadingState?
                const CircularProgressIndicator(
                  color: ColorManager.primary,
                ):DefaultButton(
                  text: AppLocalizations.of(context)!.translate('upload').toString(),
                  onPressed: (){
                    if(cubit.uploadedPaymentImage != null){
                      cubit.uploadPaymentImage().then((value) async{
                            await customToast(title: 'image is uploaded', color: ColorManager.gold);
                            cubit.uploadedPaymentImage = null;
                            await navigateAndRemove(context, const PackageScreen());
                      });
                    }else{
                      customToast(title: 'please select image', color: ColorManager.red);
                    }
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
