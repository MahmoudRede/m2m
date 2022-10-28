import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/model/payment_model.dart';
import 'package:m2m/Presentation/screens/admin_screens/payment_screens/widget/payment_list_item.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';

class PaymentRequestsScreen extends StatelessWidget {
  const PaymentRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> PaymentCubit()..getPaymentData(),
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (context,state){},
        builder: (context,state){
          List<PaymentModel> paymentData = PaymentCubit.get(context).paymentData;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.translate('paymentRequests').toString(),
                style: TextStyle(
                  fontSize: SizeConfig.headline2Size,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: state is GetPaymentDataSuccessState? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return PaymentListItem(paymentModel: paymentData[index]);
                    },
                    separatorBuilder: (context,index){
                      return Container();
                    },
                    itemCount: paymentData.length,
                  ) : const Center(child: CircularProgressIndicator(),),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
