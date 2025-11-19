import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';
import 'lista_reportes_page.dart';
import 'select_create_report_page.dart';

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
        foregroundColor: Colors.white,
        title: Text("Menú Principal", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        elevation: 1,
        centerTitle: true,
      ),
      body: Center(
        child:Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Boton para crear reporte
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: const Text("Crear Reporte",),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectCreateReportPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Boton para ver reportes
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
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
      ),
    );
  }
}