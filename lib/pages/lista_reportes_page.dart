import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // Lo que va a mostrar el boton de reporte
        children: [
          Text(
            reportInstance.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Text(
            reportInstance.ubication,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            overflow: TextOverflow.ellipsis,
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
      ),
      //backgroundColor: Colors.grey,

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