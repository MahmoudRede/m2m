import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> callFcmApiSendPushNotificationsChat({
  required String title,
  required String imageUrl,
  required String description,
  required String token,
})async{

  const postUrl ='https://fcm.googleapis.com/fcm/send';
  final data ={
    "to":token,
    "notification": {
      "title": title,
      "body": description,
      "image": imageUrl,
    },
    "data": {
      "type": '0rder',
      "id": "28",
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      'title': title,
      'imageurl': imageUrl,
      'description': description,
    },
  };
  final headers = {
    'content-type': 'application/json',
    'Authorization':
    'key=AAAAnnl0NBg:APA91bFwrwG02P9sZ4bmjg6NjLh3aAzOPSUBdtntZs8bOo_CKIxRjdEltUcCwonJDp-Q_ts5Q0sFwukQets_BErNykkqFS6o8LCbnfrH-Y20bk7nQ2tgwpNJiBSIfHssJYRV4W5YTt7E' ,// 'key=YOUR_SERVER_KEY'

  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    print('Push Notification Succeded');
  } else {
    print('Push Notification Error');
  }

}