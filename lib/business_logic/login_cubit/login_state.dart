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