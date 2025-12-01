import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/pages/notifications_page.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';
import 'lista_reportes_page.dart';
import 'select_create_report_page.dart';

class HomePage extends StatefulWidget {
  final User currentUser;

  const HomePage({super.key, required this.currentUser});

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
        actions: [
          IconButton(
            onPressed: widget.currentUser.isAdmin ? null : () async {
              await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsPage(currentUser: widget.currentUser),
                      ),
                    );
              }, 
            icon: Icon(Icons.notifications),
            color: Colors.white,
            iconSize: 30,
            )
        ],
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Boton para crear reporte
              SizedBox(
                height: 70,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  onPressed: widget.currentUser.isAdmin ? null : () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCreateReportPage(currentUser: widget.currentUser),
                      ),
                    );
                  },
                  child: const Text("Crear Reporte", style: TextStyle(fontSize: 20))
                ),
              ),

              // Boton para ver reportes
              SizedBox(
                height: 70,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text("Ver Reportes", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaReportesScreen(
                          reportesActuales: ReportManager.reports,
                          currentUser: widget.currentUser,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}