import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  String currentTileUrl = 'https://tile.openstreetmap.de/{z}/{x}/{y}.png';

  final Map<String, String> mapStyles = {
    'Normal': 'https://tile.openstreetmap.de/{z}/{x}/{y}.png',
    'Dark': 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
    'Satellite': 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  };
  LatLng? tappedPoint;
  final LatLng _initialCenter = const LatLng(33.5104, 36.2783);

  void _resetMap() {
    _mapController.move(_initialCenter, 13.0);
  }

  void _zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom + 1);
  }

  void _zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom - 1);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  tappedPoint = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: currentTileUrl,
                userAgentPackageName: 'com.example.mytasks',
              ),
              if (tappedPoint != null)
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: tappedPoint!,
                      radius: 500,
                      useRadiusInMeter: true,
                      color: Colors.blue.withOpacity(0.3),
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
              if (tappedPoint != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: tappedPoint!,
                      width: 80,
                      height: 80,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: _resetMap,
              backgroundColor: Colors.black,
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: _zoomIn,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: _zoomOut,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: tappedPoint != null ? 20 : -100,
            left: 80,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.gps_fixed, color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Selected Location",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Text(
                          "Lat: ${tappedPoint?.latitude.toStringAsFixed(5)}, "
                              "Lng: ${tappedPoint?.longitude.toStringAsFixed(5)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => tappedPoint = null),
                    icon: const Icon(Icons.close, color: Colors.white54, size: 18),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: DropdownButton<String>(
                value: mapStyles.keys.firstWhere((k) => mapStyles[k] == currentTileUrl),
                underline: const SizedBox(),
                icon: const Icon(Icons.layers, color: Colors.black),
                items: mapStyles.keys.map((String style) {
                  return DropdownMenuItem<String>(
                    value: style,
                    child: Text(style, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      currentTileUrl = mapStyles[newValue]!;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );

  }
}