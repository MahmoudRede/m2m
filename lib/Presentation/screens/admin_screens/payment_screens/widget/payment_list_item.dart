import 'package:flutter/material.dart';
import 'package:m2m/Data/model/payment_model.dart';
import 'package:m2m/Presentation/screens/admin_screens/payment_screens/confirm_payment.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class PaymentListItem extends StatelessWidget {
  final PaymentModel paymentModel;
  const PaymentListItem({Key? key, required this.paymentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>navigateTo(context, ConfirmPaymentScreen(paymentModel: paymentModel)),
      child: Padding(
        padding: EdgeInsets.all(
            SizeConfig.height*.02
        ),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(
              SizeConfig.height*.02,
            ),
            decoration: BoxDecoration(
              color: ColorManager.secondDarkColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(paymentModel.userImage.toString()),
                      radius: SizeConfig.height*.03,
                    ),
                    SizedBox(width: SizeConfig.height*.01,),
                    Expanded(
                      child: Text(
                        paymentModel.userName.toString(),
                        style: textManager(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: SizeConfig.height*.02,),
                rowData(title: 'Phone', data:  paymentModel.userPhone.toString()),

                SizedBox(height: SizeConfig.height*.02,),
                rowData(title: 'Package Name', data: paymentModel.packageName.toString()),

                SizedBox(height: SizeConfig.height*.02,),
                rowData(title: 'Package Id', data: paymentModel.packageId.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowData ({required String title , required String data}){
    return Row(
      children: [
        Text(
          '$title : ',
          style: textManager(color: ColorManager.primary),
          overflow: TextOverflow.ellipsis,
        ),

        Expanded(
          child: Text(
            data,
            style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}
