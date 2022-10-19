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
