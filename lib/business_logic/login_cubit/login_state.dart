abstract class LoginState{


}

class InitialState extends LoginState{

}

class UserLoginLoadingState extends LoginState{}
class UserLoginSuccessState extends LoginState{

  String uid;

  UserLoginSuccessState(this.uid);

}
class UserLoginErrorState extends LoginState{}

class ForgetPasswordLoadingState extends LoginState{}
class ForgetPasswordSuccessState extends LoginState{}
class ForgetPasswordErrorState extends LoginState{}