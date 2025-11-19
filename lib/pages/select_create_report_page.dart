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
        foregroundColor: Colors.black,
        title: Text("Selecciona el tipo de reporte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Boton para crear reporte
            ElevatedButton(
              child: const Text("Reporte Objeto Encontrado"),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFoundObjectReportPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Boton para ver reportes
            ElevatedButton(
              child: const Text("Reporte Objeto Perdido"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateLostObjectReportPage(),
                  )
                );
              },
            ),
          ],
        )
        )
    );
  }
}