import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/pages/create_report_page.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';
import 'lista_reportes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Text("Menú Principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Boton para crear reporte
            ElevatedButton(
              child: const Text("Crear Reporte"),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateReportPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Boton para ver reportes
            ElevatedButton(
              child: const Text("Ver Reportes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaReportesScreen(
                      reportesActuales: ReportManager.reports,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}