import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mock_data.dart';

class RouteDetailsScreen extends StatelessWidget {
  final int memberId;

  RouteDetailsScreen({required this.memberId});

  @override
  Widget build(BuildContext context) {
    final data = travelData[memberId] ?? [];
    if (data.length < 2) {
      return Scaffold(
        appBar: AppBar(title: const Text("Route Details")),
        body: const Center(child: Text("Not enough data to calculate route.")),
      );
    }

    final start = data[0]['location'];
    final end = data[data.length - 1]['location'];

    return Scaffold(
      appBar: AppBar(title: const Text("Route Details")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: start,
                zoom: 14,
              ),
              markers: {
                Marker(markerId: const MarkerId('start'), position: start),
                Marker(markerId: const MarkerId('end'), position: end),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: data.map((e) => e['location']).toList(),
                  color: Colors.blue,
                  width: 5,
                ),
              },
            ),
          ),
          ListTile(
            title: const Text("Start Location"),
            subtitle: Text("Lat: ${start.latitude}, Lng: ${start.longitude}"),
          ),
          ListTile(
            title: const Text("End Location"),
            subtitle: Text("Lat: ${end.latitude}, Lng: ${end.longitude}"),
          ),
        ],
      ),
    );
  }
}
