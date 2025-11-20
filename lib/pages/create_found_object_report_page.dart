import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart'; 
import 'osm_map_picker.dart'; 
import 'package:proyecto_ing_sw_10/utils/logic.dart';

class CreateFoundObjectReportPage extends StatefulWidget {
  const CreateFoundObjectReportPage({super.key});

  @override
  State<CreateFoundObjectReportPage> createState() => _CreateFoundObjectReportPageState();
}

class _CreateFoundObjectReportPageState extends State<CreateFoundObjectReportPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ubicationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _notasController = TextEditingController();
  final List<String> categoryOptions = ["Estudio", "Tecnología", "Personal", "Higene", "Ropa", "Deportivo", "Otros"];
  final String objectState = "Encontrado";
  DateTime? pickedDate;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: const Text("Formulario Reporte Objeto Encontrado",
            style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8),
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
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Descripción",
                hintText: "Ingrese la descripción del objeto (máx. 100 palabras)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              onChanged: (value) {
                final words = value.trim().split(RegExp(r'\s+'));
                if (words.length > 100) {
                  final trimmed = words.sublist(0, 100).join(' ');
                  _descriptionController.text = trimmed;
                  _descriptionController.selection = TextSelection.fromPosition(
                    TextPosition(offset: trimmed.length),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Máximo 100 palabras alcanzado"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _ubicationController,
              readOnly: true,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OsmMapPicker(isLostObject: false), 
                  ),
                );

                if (result != null && result is Map) {
                  final LatLng loc = result['location'];
                  setState(() {
                    _ubicationController.text = 
                        "Lat: ${loc.latitude.toStringAsFixed(5)}, Lng: ${loc.longitude.toStringAsFixed(5)}, Rad: 0.0";
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: "Ubicación del objeto",
                hintText: "Toque para seleccionar en el mapa",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.map_outlined),
                suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _notasController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Notas adicionales",
                hintText: "Información extra sobre el objeto o contacto (máx. 30 palabras)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes_outlined),
              ),
              onChanged: (value) {
                final words = value.trim().split(RegExp(r'\s+'));
                if (words.length > 30) {
                  final trimmed = words.sublist(0, 30).join(' ');
                  _notasController.text = trimmed;
                  _notasController.selection = TextSelection.fromPosition(
                    TextPosition(offset: trimmed.length),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Máximo 30 palabras alcanzado"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8),
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
              keyboardType: TextInputType.emailAddress,
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
              keyboardType: TextInputType.phone,
              controller: _userPhoneController,
              decoration: const InputDecoration(
                labelText: "Teléfono de usuario",
                hintText: "Ingrese su teléfono de contacto",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                    if (_titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("El título no puede estar vacío")),
                    );
                    return;
                  }
                  if (_descriptionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("La descripción no puede estar vacía")),
                    );
                    return;
                  }
                  if (_ubicationController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Escriba la ubicacion donde Perdio/Encontro el objeto")),
                    );
                    return;
                  }
                  if (_dateController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Eliga la fecha de cuando Perdio/Encontro el objeto")),
                    );
                    return;
                  }
                  if (_categoryController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Debe seleccionar una categoría")),
                    );
                    return;
                  }
                  if (_userNameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("El nombre de usuario no puede estar vacío")),
                    );
                    return;
                  }
                  if (_userEmailController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ingrese un correo válido")),
                    );
                    return;
                  }
                  if (_userPhoneController.text.trim().isEmpty || !_userPhoneController.text.trim().contains(RegExp(r'^[0-9]+$'))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("El teléfono debe contener números")),
                    );
                    return;
                  }
                  
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
                    state: objectState,
                    dateReported: DateTime.now(),
                    notas: _notasController.text,
                    userName: _userNameController.text,
                    userEmail: _userEmailController.text,
                    userPhone: _userPhoneController.text,
                    userId: _userEmailController.text.trim(),
                  );
                  ReportManager.addReport(newReport);
                  print("Reporte creado: $newReport");                                  
                  print("Total reportes en memoria: ${ReportManager.reports.length}");  
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
          const SizedBox(height: 20)
        ]),
      ),
    );
  }
}