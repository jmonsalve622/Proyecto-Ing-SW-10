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

        minimumSize: const Size(double.infinity, height),
        alignment: Alignment.center,
      ),
      // Lo que va a mostrar el boton de reporte
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Ocupar Top
          const SizedBox(height: 10),

          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
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
          ),

          // Ocupar Bottom
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Text(
                "Tipo de reporte: ${reportInstance.initialState}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: reportInstance.initialState == "Encontrado" ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                  children: [
                    TextSpan(text: "Fecha de publicación: "),
                    TextSpan(
                      text: DateFormat('dd/MM/yyyy').format(reportInstance.dateReported),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // El valor no es bold
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                  children: [
                    TextSpan(text: "Publicado por: "), // Etiqueta más corta
                    TextSpan(
                      text: reportInstance.userId,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
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
    const double margenY = 20;
    const EdgeInsets paddingGrid = EdgeInsets.all(20);

    return ListView.builder(
      padding: paddingGrid,
      itemCount: reportes.length,
      itemBuilder: (BuildContext context, int index) {
        final Report report = reportes[index];

        return Padding(
          padding: EdgeInsets.only(bottom: margenY),
          child: BuildBotonReporte(
            reportInstance: report,
            onReportPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(report: report),
                ),
              );
            },
          ),
        );
      },
    );

    /*
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

     */
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
        title: const Text("Reportes actuales",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: reportesActuales.isEmpty
          ? const Center(
        child: Text("No hay reportes ingresados todavía.",
          style: TextStyle(fontSize: 18, color: Colors.black),
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