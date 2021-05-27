import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApp extends StatefulWidget {
  static const String id = 'notification';
  @override
  _NotificationAppState createState() => _NotificationAppState();
}
class _NotificationAppState extends State<NotificationApp> {
  FlutterLocalNotificationsPlugin localNotifications = new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new  AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOsInitialize = new IOSInitializationSettings();
    // var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: iOsInitialize);
    // localNotifications = new FlutterLocalNotificationsPlugin();
    // localNotifications.initialize(initializationSettings);
    var initializationSettings = new InitializationSettings(android: androidInitialize );
    localNotifications.initialize(initializationSettings ,
         onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload)async{
    if(payload!=null){
      debugPrint('notification payload $payload');
    }
    showDialog(context: context,
    builder: (_) => new AlertDialog(
      title: new Text('Notification'),
      content: new Text('$payload'),
    ));
    //await Navigator.push(context, new MaterialPageRoute(builder: (context)=> new SecondRoute()));
  }
  Future RecievedSettingAndroid(int id ,String title,String body ,String payload)async{
    await showDialog(context: context,
    builder: (BuildContext)=>CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(isDefaultAction: true,
        child: Text('ok'),
      onPressed: ()async{
          Navigator.of(context,rootNavigator: true).pop();
      },
        ),
      ],
    ));
  }
  void _showNotification()async{
     _demo();
    // var androidDetails = new AndroidNotificationDetails('channelId', 'Local Notification', 'this is the description of the notification',importance: Importance.high);
    // var iOSDetails = new IOSNotificationDetails();
    // var generalNotification = new NotificationDetails(android: androidDetails,iOS: iOSDetails);
    // await localNotifications.show(0, 'Notification title', 'the body of notification', generalNotification);
  }
  Future <void> _demo(){
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('channelId',
        'Local Notification'
        , 'this is the description of the notification'
        ,importance: Importance.max
        ,priority: Priority.high
        ,ticker: 'ticker');
    var ioschannel = IOSNotificationDetails();
    var platformandroid = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: ioschannel);
    localNotifications.show(0, 'hello', 'buddy' , platformandroid, payload: 'other user is near');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('click the button to a notification'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotification,
      ),
    );
  }
  
}

// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('second route'),
//       ),
//           body: Center(
//         child: RaisedButton(
//           child: Text('go back'),
//         onPressed: (){
//             Navigator.pop(context);
//     },
//     )
//     ),
//
//     );
//   }
// }
