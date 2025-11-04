import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/pages/create_report_page.dart';
import 'package:proyecto_ing_sw_10/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: CreateReportPage()  //HomePage()
      );
  }
}
