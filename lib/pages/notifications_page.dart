import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

class NotificationsPage extends StatefulWidget {
  final User currentUser;
  
  const NotificationsPage({super.key, required this.currentUser});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Widget _buildNotificationWidget(ReportNotification reportNotification) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(reportNotification.message, style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${reportNotification.date.day}/${reportNotification.date.month}/${reportNotification.date.year}",
              style: TextStyle(fontSize: 15, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

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
      body: ListView.builder(
        itemCount: widget.currentUser.notifList.length,
        itemBuilder: (BuildContext context, int index) {
          final ReportNotification reportNotification = widget.currentUser.notifList[index];
          return _buildNotificationWidget(reportNotification);
          }
        )
      
      // body: Column(
      //   children: [
      //     widget.currentUser.notifList.isEmpty ? SizedBox() : Text(widget.currentUser.notifList[0].message),
      //     widget.currentUser.notifList.length >= 2 ? Text(widget.currentUser.notifList[1].message) : SizedBox(),
      //     widget.currentUser.notifList.length >= 3 ? Text(widget.currentUser.notifList[2].message) : SizedBox(),
      //     widget.currentUser.notifList.length >= 4 ? Text(widget.currentUser.notifList[3].message) : SizedBox(),
      //     widget.currentUser.notifList.length >= 5 ? Text(widget.currentUser.notifList[4].message) : SizedBox(),
      //     widget.currentUser.notifList.length >= 6 ? Text(widget.currentUser.notifList[5].message) : SizedBox(),
      //   ],
      // ),

    );
  }
}