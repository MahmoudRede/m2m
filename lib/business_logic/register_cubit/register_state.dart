abstract class RegisterState{


}

class InitialState extends RegisterState{}

class UserRegisterLoadingState extends RegisterState{}
class UserRegisterSuccessState extends RegisterState{}
class UserRegisterErrorState extends RegisterState{}

class SaveInfoLoadingState extends RegisterState{}
class SaveInfoSuccessState extends RegisterState{}
class SaveInfoErrorState extends RegisterState{}

class PickNationalCardSuccessState extends RegisterState{

}
class PickNationalCardErrorState extends RegisterState{

}

class PickPersonalImageSuccessState extends RegisterState{

}
class PickPersonalImageErrorState extends RegisterState{

}

class UploadNationalIdLoadingState extends RegisterState{}
class UploadNationalIdSuccessState extends RegisterState{}
class UploadNationalIdErrorState extends RegisterState{}

class UploadPersonalImageLoadingState extends RegisterState{}
class UploadPersonalImageSuccessState extends RegisterState{}
class UploadPersonalImageErrorState extends RegisterState{}


class ChangeGovernmentDropDownState extends RegisterState{}

class SelectSkillSuccessState extends RegisterState{}
