import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:running_app/core/models/location_data.dart';
import 'package:running_app/core/services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.data});
  final LocationData data;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  // chmaaneha l ticker hedhika
  late final _animatedMapController = AnimatedMapController(vsync: this);

  late final LatLng _currentPosition;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _currentPosition = LatLng(widget.data.latitude, widget.data.longitude);
    _locationService.locationStream().listen((locationData) {
      print('Location updated: ${locationData.latitude}, ${locationData.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(initialCenter: _currentPosition, initialZoom: 16),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: _currentPosition,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
