import 'package:bobo_tea/widgets/custom_app_bar.dart';
import 'package:bobo_tea/widgets/social_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late bool _locationPermissionGranted;

  final LatLng _boboTeaLocation = const LatLng(44.143890, 12.251130);

  @override
  void initState() {
    super.initState();
    _locationPermissionGranted = false;
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    final permissionStatus = await Permission.location.status;

    if (permissionStatus.isGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
    } else if (permissionStatus.isDenied ||
        permissionStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
              'This page requires location access. Please grant permission to continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(titleText: 'Information'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromARGB(255, 238, 232, 242),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Bobo Tea',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 15),
                      Text(
                        '05731 255 6785',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Icon(Icons.event_available),
                      SizedBox(width: 15),
                      Text(
                        '7.00 am - 22.00 pm',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 15),
                      Text(
                        'Corso c.b. Cavour, 165, 47521 Cesena FC',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SocialMediaButtons(
                    links: [
                      SocialMediaLink(
                        url: 'https://www.instagram.com/bobo_tea2022/',
                        icon: FontAwesomeIcons.instagram,
                      ),
                      SocialMediaLink(
                        url: 'https://www.instagram.com/bobo_tea2022/',
                        icon: FontAwesomeIcons.meta,
                      ),
                      SocialMediaLink(
                        url: 'https://www.instagram.com/bobo_tea2022/',
                        icon: FontAwesomeIcons.whatsapp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Come and find us',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _boboTeaLocation,
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('bobo_tea_marker'),
                    position: _boboTeaLocation,
                    infoWindow: const InfoWindow(
                      title: 'Bobo Tea',
                      snippet: 'Cesena, Italia',
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                },
                myLocationButtonEnabled: _locationPermissionGranted,
                myLocationEnabled: _locationPermissionGranted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
