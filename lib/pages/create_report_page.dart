import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';


class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ubicationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final List<String> categoryOptions = ["Estudio", "Tecnología", "Personal", "Higene", "Ropa", "Deportivo", "Otros"];
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();

  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: const Text("Formulario Reporte",
            style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text("Información del reporte",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Título",
              hintText: "Ingrese el nombre del objeto",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.short_text),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: "Descripción",
              hintText: "Ingrese la descripción del objeto",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.notes),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _ubicationController,
            decoration: const InputDecoration(
              labelText: "Ubicación",
              hintText: "Ingrese la ubicación del objeto",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.place),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _dateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Fecha',
              hintText: "dd/mm/aaaa",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_month),
            ),
            onTap: () async {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                _dateController.text =
                    "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
            labelText: "Categoría",
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            hint: Text("Categoría"),
            initialValue: _categoryController.text.isEmpty ? null : _categoryController.text,
            items: categoryOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
            );}).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _categoryController.text = newValue!;
              });
            },
          )
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text("Información de contacto",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _userNameController,
            decoration: const InputDecoration(
              labelText: "Nombre de usuario",
              hintText: "Ingrese su nombre de usuario",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _userEmailController,
            decoration: const InputDecoration(
              labelText: "Correo de usuario",
              hintText: "Ingrese su correo institucional",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _userPhoneController,
            decoration: const InputDecoration(
              labelText: "Teléfono de usuario",
              hintText: "Ingrese su teléfono de contacto",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                final newReport = Report(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  object: LostObject(
                    id: "obj-${DateTime.now().millisecondsSinceEpoch}",
                    name: _titleController.text,
                    imageUrl: "",
                    dateLost: pickedDate ?? DateTime.now(),
                  ),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  ubication: _ubicationController.text,
                  category: _categoryController.text,
                  dateReported: DateTime.now(),
                  userId: "user123", //Usuario de prueba
                  notas: "",
                  userName: _userNameController.text,
                  userEmail: _userEmailController.text,
                  userPhone: _userPhoneController.text,
                );

                ReportManager.addReport(newReport);
                print("Reporte creado: $newReport");                                  //Prints que demuestran que si se guardan
                print("Total reportes en memoria: ${ReportManager.reports.length}");  //los reportes con los datos escritos


                Navigator.pop(context, newReport);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.send, color: Colors.black, size: 25),
                  Text("Publicar Reporte",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
        const Spacer()
      ]),
    );
  }
}
