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

    String stateText;
    Color stateColor;
    switch (reportInstance.initialState) {
      case ObjectState.Found:
        stateText = "Encontrado";
        stateColor = Colors.green;
        break;
      case ObjectState.Lost:
        stateText = "Perdido";
        stateColor = Colors.redAccent;
        break;
    }

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Tipo de reporte: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: stateColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      stateText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Texto negro como pediste
                      ),
                    ),
                  ),
                ],
              ),

              /*
              Text(
                "Tipo de reporte: $stateText",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: stateColor,
                ),
              ),

               */
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
                      text: reportInstance.userName,
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
  final User currentUser;

  const BuildReportesGrid({
    super.key,
    required this.reportes,
    required this.currentUser
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
                  builder: (context) => ReportPage(report: report, currentUser: currentUser),
                ),
              );
            },
          ),
        );
      },
    );
  }

}

//Inicializador del Screen de los reportes e
//Implementacion de los filtros
class ListaReportesScreen extends StatefulWidget {
  final List<Report> reportesActuales;
  final User currentUser;

  const ListaReportesScreen({super.key, required this.reportesActuales, required this.currentUser});

  @override
  State<ListaReportesScreen> createState() => _ListaReportesScreenState();
}

class _ListaReportesScreenState extends State<ListaReportesScreen> {
  bool _newestFirst = true;
  String _selectedCategory = "Todos";

  final List<String> _categorias = [
    "Todos",
    "Estudio",
    "Tecnología",
    "Personal",
    "Higiene",
    "Ropa",
    "Deportivo",
    "Otros"
  ];

  @override
  Widget build(BuildContext context) {
    // Ordenamos por antigüedad
    var reportesOrdenados = [...widget.reportesActuales];
    reportesOrdenados.sort((a, b) => _newestFirst
        ? b.dateReported.compareTo(a.dateReported)
        : a.dateReported.compareTo(b.dateReported));

    // Filtramos por categoría
    if (_selectedCategory != "Todos") {
      reportesOrdenados = reportesOrdenados
          .where((r) => r.category == _selectedCategory)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes actuales",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Botón para alternar antigüedad
          IconButton(
            icon: Icon(_newestFirst ? Icons.arrow_downward : Icons.arrow_upward),
            tooltip: _newestFirst
                ? "Ordenar por más antiguos"
                : "Ordenar por más recientes",
            onPressed: () {
              setState(() {
                _newestFirst = !_newestFirst;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔥 Dropdown para categorías
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categorias.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: "Filtrar por categoría",
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),

          // Lista de reportes filtrados
          Expanded(
            child: reportesOrdenados.isEmpty
                ? const Center(
                    child: Text(
                      "No hay reportes en esta categoría.",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  )
                : BuildReportesGrid(reportes: reportesOrdenados, currentUser: widget.currentUser),
          ),
        ],
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