import 'dart:ui';

import 'package:flutter/material.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  String objectName = "";
  String objectDescription = "";
  String objectUbication = "";
  
  final TextEditingController _fechaController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Text("Formulario Reporte", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            child: Text("Información del reporte", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Título",
                hintText: "Ingrese el nombre del objeto",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.short_text)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Descripción",
                hintText: "Ingrese la descripción del objeto",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
              labelText: "Ubicación",
              hintText: "Ingrese la ubicación del objeto",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.place)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: TextField(
              controller: _fechaController,
              readOnly: true, 
              decoration: InputDecoration(
                labelText: 'Fecha',
                hintText: "dd/mm/aaaa",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_month)
                ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  _fechaController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
            )
          ),


          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.send, color: Colors.black, size: 25),
                    Text("Publicar Reporte", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),),
                  ],
                )
              ),
            ),
          )
      ])
    );
  }
}