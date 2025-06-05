import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicacionMapaWidget extends StatelessWidget {
  final LatLng ubicacionUsuario;
  final LatLng ubicacionSeleccionada;
  final Function(LatLng) onDragEnd;
  final Function(GoogleMapController) onMapCreated;

  const UbicacionMapaWidget({
    super.key,
    required this.ubicacionUsuario,
    required this.ubicacionSeleccionada,
    required this.onDragEnd,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    final marcador = Marker(
      markerId: MarkerId('marcador_${ubicacionSeleccionada.latitude}_${ubicacionSeleccionada.longitude}'),
      position: ubicacionSeleccionada,
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onDragEnd: onDragEnd,
    );

    final circle = Circle(
      circleId: const CircleId('radio_50m'),
      center: ubicacionUsuario,
      radius: 50,
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blueAccent.withOpacity(0.5),
      strokeWidth: 2,
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: ubicacionUsuario,
        zoom: 17,
      ),
      onMapCreated: onMapCreated,
      markers: {marcador},
      circles: {circle},
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
    );
  }
}