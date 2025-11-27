import 'package:flutter/material.dart';
import 'create_found_object_report_page.dart';
import 'create_lost_object_report_page.dart';

class SelectCreateReportPage extends StatefulWidget {
  const SelectCreateReportPage({super.key});

  @override
  State<SelectCreateReportPage> createState() => _SelectCreateReportPageState();
}

class _SelectCreateReportPageState extends State<SelectCreateReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Selecciona el tipo de reporte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Boton para crear reporte de objeto encontrado
            SizedBox(
              height: 70,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                child: const Text("Reporte Objeto Encontrado", style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateFoundObjectReportPage(),
                    ),
                  );
                },
              ),
            ),

            // Boton para crear reporte de objeto perdido
            SizedBox(
              height: 70,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                child: const Text("Reporte Objeto Perdido" , style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLostObjectReportPage(),
                    )
                  );
                },
              ),
            ),
          ],
        )
        )
    );
  }
}