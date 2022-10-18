class UserModel{

  String? uId;
  String ?username;
  String ?email;
  String ?phone;
  String ?nationalIdImage;
  String ?personalImage;
  String ?package;
  String ?government;
  String ?age;
  String ?skills;
  String ?inviteCode;
  bool ?isConfirmed;


  UserModel({
    this.uId,
    this.username,
    this.email,
    this.phone,
    this.nationalIdImage,
    this.personalImage,
    this.package,
    this.government,
    this.age,
    this.skills,
    this.inviteCode,
    this.isConfirmed,

  });

  UserModel.formJson( Map <String , dynamic> json ){
    username = json['username'];
    email=json['email'];
    uId=json['uId'];
    phone=json['phone'];
    nationalIdImage=json['nationalIdImage'];
    personalImage=json['personalImage'];
    package=json['package'];
    government=json['government'];
    age=json['age'];
    skills=json['skills'];
    inviteCode=json['inviteCode'];
    isConfirmed=json['isConfirmed'];

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
      'government':government,
      'age':age,
      'skills':skills,
      'inviteCode':inviteCode,
      'isConfirmed':isConfirmed,
    };
  }

}