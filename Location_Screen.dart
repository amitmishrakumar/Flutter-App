class LocationScreen extends StatelessWidget {
  final int memberId;

  LocationScreen({required this.memberId});

  @override
  Widget build(BuildContext context) {
    final data = travelData[memberId] ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text("Location Timeline")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: data.isNotEmpty
                    ? data[0]['location']
                    : const LatLng(0, 0),
                zoom: 14,
              ),
              markers: data
                  .map((entry) => Marker(
                        markerId: MarkerId(entry['time']),
                        position: entry['location'],
                        infoWindow: InfoWindow(title: entry['time']),
                      ))
                  .toSet(),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final entry = data[index];
                return ListTile(
                  title: Text("Visited at ${entry['time']}"),
                  subtitle: Text(
                      "Lat: ${entry['location'].latitude}, Lng: ${entry['location'].longitude}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
