abstract class PaymentStates{}

class InitialState extends PaymentStates{}

class GetUserSuccessState extends PaymentStates{}
class GetUserLoadingState extends PaymentStates{}
class GetUserErrorState extends PaymentStates{}

class PickPersonalImageErrorState extends PaymentStates{}
class UploadImageSuccessState extends PaymentStates{}
class UploadImageErrorState extends PaymentStates{}


class UrlLaunchState extends PaymentStates{}

class UploadPaymentImageLoadingState extends PaymentStates{}
class UploadPaymentImageSuccessState extends PaymentStates{}
class UploadPaymentImageErrorState extends PaymentStates{}

class GetPaymentDataLoadingState extends PaymentStates{}
class GetPaymentDataSuccessState extends PaymentStates{}
class GetPaymentDataErrorState extends PaymentStates{}

class ConfirmPaymentLoadingState extends PaymentStates{}
class ConfirmPaymentSuccessState extends PaymentStates{}
class ConfirmPaymentErrorState extends PaymentStates{}

class ChangeLastWalletState extends PaymentStates{}
class GetLastProfitState extends PaymentStates{}