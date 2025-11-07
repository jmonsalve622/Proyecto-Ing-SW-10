import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/pages/report_page.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';
import 'package:intl/intl.dart';

/// Clase para crear un botón de un reporte,
/// donde al presionarlo, llevara a la vista completa del reporte
/// titulo, estado, fecha
/// en cuestión.
class BuildBotonReporte extends StatelessWidget {
  final VoidCallback onReportPressed;
  final Report reportInstance;

  const BuildBotonReporte({
    super.key,
    required this.onReportPressed,
    required this.reportInstance,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 60;
    const double radioBordes = 12;
    const Color buttonColor = Colors.blue;
    const Color borderColor = Colors.deepPurpleAccent;
    const double anchoBorde = 10;

    return ElevatedButton(
      onPressed: onReportPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radioBordes),
        ),
        side: const BorderSide(
          color: borderColor,
          width: anchoBorde,
        ),

        minimumSize: const Size(0, height),
        alignment: Alignment.center,
        //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      // Lo que va a mostrar el boton de reporte
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ocupar Top
          SizedBox(),

          // Ocupar Centro
          FittedBox(
            fit: BoxFit.scaleDown,

            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Reporte: "',
                  ),
                  TextSpan(
                    text: reportInstance.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(text: '"'),
                ],
              ),
            ),
          ),

          // Ocupar Bottom
          Column(
            children: [
              Text(
                "Tipo de reporte: ${reportInstance.state}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: reportInstance.state == "Encontrado" ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Fecha de publicación:",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black38,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(reportInstance.dateReported),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Publicado por:",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black38,
                ),
              ),
              Text(
                reportInstance.userId,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

/// Clase para crear la cuadricula de reportes que han sido creados,
/// de modo que el usuario pueda ver todos los reportes actuales.
class BuildReportesGrid extends StatelessWidget {
  final List<Report> reportes;

  const BuildReportesGrid({
    super.key,
    required this.reportes,
  });

  @override
  Widget build(BuildContext context) {
    const int maxColumnas = 4;
    const double margenY = 20;
    const double margenX = 10;
    const EdgeInsets paddingGrid = EdgeInsets.all(20);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxColumnas,
        mainAxisSpacing: margenY,
        crossAxisSpacing: margenX,
      ),

      padding: paddingGrid,

      itemCount: reportes.length,
      itemBuilder: (BuildContext context, int index) {
        final Report report = reportes[index];

        return BuildBotonReporte(
          reportInstance: report,
          onReportPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportPage(report: report),
              ),
            );
            print("Ingresando a reporte: ${report.title}");
          },
        );
      },
    );
  }

}

/// Inicializador del Screen de los reportes
class ListaReportesScreen extends StatelessWidget {
  final List<Report> reportesActuales;

  const ListaReportesScreen({
    super.key,
    required this.reportesActuales,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes actuales"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),

      body: reportesActuales.isEmpty
          ? const Center(
        child: Text("No hay reportes ingresados todavía.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      )
          : BuildReportesGrid(
        reportes: reportesActuales,
      ),
    );
  }
}


/*
// Main de prueba
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ListaReportesScreen(),
    );
  }
}
 */