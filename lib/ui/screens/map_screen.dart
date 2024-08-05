import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:running_app/core/providers/view_model_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);

  @override
  void initState() {
    super.initState();
    ref.read(locationViewModelProvider.notifier).getCurrentLocation();
  }

  void _toggleRecording() {
    final locationState = ref.watch(locationViewModelProvider);
    if (locationState.isRecording) {
      print("stop recording");
      ref.read(locationViewModelProvider.notifier).stopRecording();
    } else {
      print("start recording");
      ref.read(locationViewModelProvider.notifier).startRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationViewModelProvider);

    if (!locationState.isLocationReady) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    print("path length: ${locationState.path.length}");
    print(locationState.path);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              initialCenter: LatLng(
                locationState.locationData!.latitude,
                locationState.locationData!.longitude,
              ),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                      points: locationState.path.map((loc) => LatLng(loc.latitude, loc.longitude)).toList(),
                      color: Colors.blue,
                      strokeWidth: 4.0,
                      strokeJoin: StrokeJoin.round),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(
                      locationState.locationData!.latitude,
                      locationState.locationData!.longitude,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          locationState.isRecording
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    color: Colors.black54,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Elapsed Time: ${locationState.elapsedTime}s',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleRecording,
        child: Icon(locationState.isRecording ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
