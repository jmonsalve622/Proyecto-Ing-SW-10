import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OsmMapPicker extends StatefulWidget {
  final bool isLostObject; 

  const OsmMapPicker({
    super.key, 
    required this.isLostObject, 
  });

  @override
  State<OsmMapPicker> createState() => _OsmMapPickerState();
}

class _OsmMapPickerState extends State<OsmMapPicker> {
  static const LatLng _udecCenter = LatLng(-36.8295, -73.0360);

  final Key _mapKey = UniqueKey(); 

  final LatLngBounds _cameraBounds = LatLngBounds(
    const LatLng(-36.8600, -73.0800), 
    const LatLng(-36.8000, -73.0000), 
  );

  final List<LatLng> _yellowPolygon = [
    const LatLng(-36.8274, -73.0403), 
    const LatLng(-36.8230, -73.0335), 
    const LatLng(-36.8360, -73.0285), 
    const LatLng(-36.8400, -73.0355), 
  ];

  LatLng? _pickedLocation;
  double _currentRadius = 20.0; 

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length - 1; j++) {
      if (_rayCastIntersect(point, polygon[j], polygon[j + 1])) {
        intersectCount++;
      }
    }
    if (_rayCastIntersect(point, polygon.last, polygon.first)) {
      intersectCount++;
    }
    return (intersectCount % 2) == 1;
  }

  bool _rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
    final double aY = vertA.latitude;
    final double bY = vertB.latitude;
    final double aX = vertA.longitude;
    final double bX = vertB.longitude;
    final double pY = point.latitude;
    final double pX = point.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }
    if (aY == bY) return false;

    final double m = (bX - aX) / (bY - aY);
    final double bee = (-aX) + m * aY;
    final double x = -(bee - m * pY);

    return x > pX;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLostObject ? "Zona de pérdida" : "Ubicación exacta"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    Navigator.pop(context, {
                      'location': _pickedLocation,
                      'radius': widget.isLostObject ? _currentRadius : 0.0,
                    });
                  },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            key: _mapKey, 
            options: MapOptions(
              initialCenter: _udecCenter,
              initialZoom: 15.5,
              minZoom: 12.0,
              maxZoom: 19.0,
              cameraConstraint: CameraConstraint.contain(bounds: _cameraBounds),
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onTap: (tapPosition, point) {
                if (_isPointInPolygon(point, _yellowPolygon)) {
                  setState(() {
                    _pickedLocation = point;
                  });
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Marca una ubicación dentro del área amarilla."),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.proyecto.ing_sw_10',
              ),
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: _yellowPolygon,
                    color: Colors.yellow.withOpacity(0.15),
                    borderColor: Colors.orange,
                    borderStrokeWidth: 3,
                  ),
                ],
              ),
              if (widget.isLostObject && _pickedLocation != null)
                 CircleLayer(
                   circles: [
                     CircleMarker(
                       point: _pickedLocation!,
                       color: Colors.purple.withOpacity(0.3),
                       borderColor: Colors.purple,
                       borderStrokeWidth: 2,
                       useRadiusInMeter: true, 
                       radius: _currentRadius,
                     ),
                   ],
                 ),
              if (_pickedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _pickedLocation!,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
            ],
          ),
          
          if (widget.isLostObject && _pickedLocation != null)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0,4))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Radio de búsqueda: ${_currentRadius.toInt()} metros", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Slider(
                      value: _currentRadius,
                      min: 5.0,
                      max: 100.0,
                      activeColor: Colors.purple,
                      onChanged: (value) {
                        setState(() {
                          _currentRadius = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}