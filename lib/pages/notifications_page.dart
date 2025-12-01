import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

class NotificationsPage extends StatefulWidget {
  final User currentUser;
  
  const NotificationsPage({super.key, required this.currentUser});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Notificaciones", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          widget.currentUser.notifList.isEmpty ? SizedBox() : Text(widget.currentUser.notifList[0].message),
          widget.currentUser.notifList.length >= 2 ? Text(widget.currentUser.notifList[1].message) : SizedBox(),
          widget.currentUser.notifList.length >= 3 ? Text(widget.currentUser.notifList[2].message) : SizedBox(),
          widget.currentUser.notifList.length >= 4 ? Text(widget.currentUser.notifList[3].message) : SizedBox(),
          widget.currentUser.notifList.length >= 5 ? Text(widget.currentUser.notifList[4].message) : SizedBox(),
          widget.currentUser.notifList.length >= 6 ? Text(widget.currentUser.notifList[5].message) : SizedBox(),
        ],
      ),

    );
  }
}