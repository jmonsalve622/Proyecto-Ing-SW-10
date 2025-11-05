import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/pages/create_report_page.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Report> reportList = List.empty(growable: true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Text("Hola Mundo!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReportPage()));
            }, 
            child: Icon(Icons.add)//Text("Publicar")
            )
            ],
      ),

    );
  }
}