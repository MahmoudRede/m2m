

class PublicChatModel{
  String? senderId;
  String? senderName;
  String? senderImage;
  String? dateTime;
  String? text;


  PublicChatModel({
    this.senderId,
    this.senderImage,
    this.senderName,
    this.dateTime,
    this.text,

  });
  PublicChatModel.fromJson(Map<String , dynamic> json){
    senderId=json['senderId'];
    senderName=json['senderName'];
    senderImage=json['senderImage'];
    dateTime=json['dateTime'];
    text=json['text'];

  }

  Map <String , dynamic> toMap(){
    return{
      'senderId':senderId,
      'dateTime':dateTime,
      'text':text,
      'senderImage':senderImage,
      'senderName':senderName,

    };
  }
}