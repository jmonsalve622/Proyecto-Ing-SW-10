import 'package:flutter/material.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Text("Hola Mundo!"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Introduce el nombre del objeto",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Introduce la descripción del objeto",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.short_text)
              ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                hintText: "Introduce la ubicación del objeto",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.place)
              ),
              ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(onPressed: () {}, child: Text("Publicar Reporte")),
              )
        ],
        )
    );
  }
}