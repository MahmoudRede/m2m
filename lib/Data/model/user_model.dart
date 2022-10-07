class UserModel{

  String? uId;
  String ?username;
  String ?email;
  String ?phone;
  String ?nationalIdImage;
  String ?personalImage;
  String ?package;


  UserModel({
    this.uId,
    this.username,
    this.email,
    this.phone,
    this.nationalIdImage,
    this.personalImage,
    this.package,

  });

  UserModel.formJson( Map <String , dynamic> json ){
    username = json['username'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];
    nationalIdImage=json['nationalIdImage'];
    personalImage=json['personalImage'];
    package=json['package'];

  }

  Map <String,dynamic> toMap(){
    return{
      'username':username,
      'email':email,
      'uId':uId,
      'phone':phone,
      'nationalIdImage':nationalIdImage,
      'personalImage':personalImage,
      'package':package,
    };
  }

}