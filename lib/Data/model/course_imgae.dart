class CourseModel {

  CourseModel({

    required this.courseTitle,
    required this.courseLink,
    required this.courseImage,

  });

  final String courseTitle;
  final String courseLink;
  final String courseImage;


  factory CourseModel.fromMap(Map<String, dynamic> json) => CourseModel(

    courseTitle: json["courseTitle"]??"",
    courseLink: json["courseLink"]??"",
    courseImage: json["courseImage"]??"",

  );

  Map<String, dynamic> toMap() => {

    "courseTitle": courseTitle,
    "courseLink": courseLink,
    "courseImage": courseImage,

  };
}