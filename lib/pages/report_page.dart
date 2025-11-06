import 'package:flutter/material.dart';
import 'package:proyecto_ing_sw_10/utils/logic.dart';

class ReportPage extends StatefulWidget {
  final Report report;

  const ReportPage({
    super.key,
    required this.report,
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.report.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
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
                  child: Image.network(
                    widget.report.object.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 100,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                widget.report.object.name,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Text(
                widget.report.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              
              const Divider(height: 30, thickness: 1),

              _buildDetailRow(
                icon: Icons.place_outlined,
                title: "Ubicación",
                content: widget.report.ubication,
              ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String content}) {
    if (content.isEmpty) {
      // Si el contenido está vacío, no muestra nada.
      return const SizedBox.shrink(); 
    }
    
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
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}