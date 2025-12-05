import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';
import 'dart:io';

class ReportPage extends StatefulWidget {
  final Report report;
  final User currentUser;

  const ReportPage({
    super.key,
    required this.report,
    required this.currentUser
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  
  Map<String, dynamic>? _getLocationData(String ubication) {
    try {
      if (ubication.contains("Lat:") && ubication.contains("Lng:")) {
        final parts = ubication.split(',');
        
        final latString = parts[0].split(':')[1].trim();
        final lat = double.parse(latString);
        
        final lngString = parts[1].split(':')[1].trim();
        final lng = double.parse(lngString);

        double radius = 0.0;
        if (parts.length > 2 && parts[2].contains("Rad:")) {
           final radString = parts[2].split(':')[1].trim();
           radius = double.parse(radString);
        }

        return {
          'coordinates': LatLng(lat, lng),
          'radius': radius,
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final locationData = _getLocationData(widget.report.ubication);
    final LatLng? coordinates = locationData?['coordinates'];
    final double radius = locationData?['radius'] ?? 0.0;
    final String stateText = (widget.report.initialState == ObjectState.Found) ? "Encontrado" : "Perdido";

    return Scaffold(
      appBar: AppBar(
        title: Text("Reporte: ${widget.report.object.name}"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: (widget.report.image != null)
                      ? Image.file(
                    widget.report.image!,
                    fit: BoxFit.contain,
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "No hay imagen disponible",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Tipo: $stateText",
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildDetailRow(
                  icon: Icons.note_outlined,
                  title: "Descripción del Objeto",
                  content: widget.report.description,
              ),

              const Divider(height: 30, thickness: 1),

              const Row(
                children: [
                   Icon(Icons.place_outlined, color: Colors.blue, size: 28),
                   SizedBox(width: 12),
                   Text("Ubicación:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),

              if (coordinates != null)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullMapScreen(
                          location: coordinates,
                          radius: radius, 
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          FlutterMap(
                            options: MapOptions(
                              initialCenter: coordinates,
                              initialZoom: 16.5,
                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.none, 
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.proyecto.ing_sw_10',
                              ),
                              if (radius > 0)
                                CircleLayer(
                                  circles: [
                                    CircleMarker(
                                      point: coordinates,
                                      color: Colors.purple.withOpacity(0.3),
                                      borderColor: Colors.purple,
                                      borderStrokeWidth: 2,
                                      useRadiusInMeter: true,
                                      radius: radius,
                                    ),
                                  ],
                                ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: coordinates,
                                    width: 50,
                                    height: 50,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    alignment: Alignment.topCenter,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                                boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
                              ),
                              child: const Icon(Icons.fullscreen, size: 28, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(widget.report.ubication, style: const TextStyle(fontSize: 16)),
                ),

              const SizedBox(height: 10),
              
              _buildDetailRow(
                icon: Icons.category_outlined,
                title: "Categoría",
                content: widget.report.category,
              ),
              _buildDetailRow(
                icon: Icons.calendar_today_outlined,
                title: "Fecha del Reporte",
                content: "${widget.report.dateReported.day}/${widget.report.dateReported.month}/${widget.report.dateReported.year}",
              ),
              _buildDetailRow(
                icon: Icons.event_busy_outlined,
                title: "Fecha incidente",
                content: "${widget.report.object.dateLost.day}/${widget.report.object.dateLost.month}/${widget.report.object.dateLost.year}",
              ),
              _buildDetailRow(
                icon: Icons.notes_outlined,
                title: "Notas adicionales",
                content: widget.report.notas,
              ),

              const Divider(height: 30, thickness: 1),

              const Text(
                "Información de Contacto",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildDetailRow(
                icon: Icons.person_outline,
                title: "Publicado por",
                content: widget.report.userName,
              ),
              _buildDetailRow(
                icon: Icons.email_outlined,
                title: "Email de Contacto",
                content: widget.report.userEmail,
              ),
              _buildDetailRow(
                icon: Icons.phone_outlined,
                title: "Teléfono de Contacto",
                content: widget.report.userPhone,
              ),

            _buildAdminWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String content}) {
    if (content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeStateWidget() {
    return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Estado", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      activeColor: Colors.blue,
                      value: ReportState.Pending,
                      // ignore: deprecated_member_use
                      groupValue: widget.report.reportState,
                      onChanged: (value) {
                        setState(() {
                          widget.report.reportState = value!;
                          ReportNotification noti = ReportNotification(reportState: value, reportTitle: widget.report.title);
                          widget.report.creatorUser.notifList.add(noti);
                        });
                      },
                    ),
                    Text("Pendiente")
                  ]),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      activeColor: Colors.blue,
                      value: ReportState.Resolved,
                      // ignore: deprecated_member_use
                      groupValue: widget.report.reportState,
                      onChanged: (value) {
                        setState(() {
                          widget.report.reportState = value!;
                          ReportNotification noti = ReportNotification(reportState: value, reportTitle: widget.report.title);
                          widget.report.creatorUser.notifList.add(noti);
                        });
                      },
                    ),
                    Text("Resuelto")
                  ])
              ]
              ),
          )
        );
  }

  Widget _buildDeleteReportWidget() {
    return Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: widget.report.reportState == ReportState.Resolved ? () {
                  ReportManager.removeReport(widget.report.id);
                  Navigator.pop(context, widget.report);
                } : null,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.delete, color: Colors.black, size: 25),
                    Text("Eliminar Reporte",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildAdminWidget() {
    if (!widget.currentUser.isAdmin) return const SizedBox.shrink();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(height: 30, thickness: 1),

        const Text(
          "Acciones de Administrador",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        _buildChangeStateWidget(),
        _buildDeleteReportWidget()
      ]
      );
  }
}



// Pantalla de Mapa Completo
class FullMapScreen extends StatelessWidget {
  final LatLng location;
  final double radius;

  const FullMapScreen({
    super.key, 
    required this.location,
    this.radius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubicación exacta"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: location,
          initialZoom: 18.0, 
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none, 
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.proyecto.ing_sw_10',
          ),
          if (radius > 0)
            CircleLayer(
              circles: [
                CircleMarker(
                  point: location,
                  color: Colors.purple.withOpacity(0.3),
                  borderColor: Colors.purple,
                  borderStrokeWidth: 2,
                  useRadiusInMeter: true,
                  radius: radius,
                ),
              ],
            ),
          MarkerLayer(
            markers: [
              Marker(
                point: location,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 60,
                ),
                alignment: Alignment.topCenter,
              ),
            ],
          ),
          const RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors'),
            ],
          ),
        ],
      ),
    );
  }
}