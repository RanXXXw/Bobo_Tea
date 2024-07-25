import 'package:bobo_tea/resources/resources.dart';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(AppStrings.permissionTitle),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: const Text(AppStrings.permissionContent),
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text(AppStrings.permissionOptionSettings),
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
      appBar: const ReusableAppBar(titleText: AppStrings.infoNav),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingMarginSM),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: AppDimens.heightL,
              padding: const EdgeInsets.all(AppDimens.paddingMarginXS),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusML),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDimens.paddingMarginSM),
                    child: Text(
                      AppStrings.titleApp,
                      style: AppTextStyles.largeBold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: AppDimens.widthSM),
                      Text(
                        AppStrings.contact,
                        style: TextStyle(fontSize: AppDimens.textS),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.heightXS),
                  const Row(
                    children: [
                      Icon(Icons.event_available),
                      SizedBox(width: AppDimens.widthSM),
                      Text(
                        AppStrings.workingHours,
                        style: TextStyle(fontSize: AppDimens.textS),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.heightXS),
                  const Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: AppDimens.widthSM),
                      Text(
                        AppStrings.address,
                        style: TextStyle(fontSize: AppDimens.textS),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.heightXXXS),
                  SocialMediaButtons(
                    links: [
                      SocialMediaLink(
                        url: AppStrings.urlIns,
                        icon: FontAwesomeIcons.instagram,
                      ),
                      SocialMediaLink(
                        url: AppStrings.urlMeta,
                        icon: FontAwesomeIcons.meta,
                      ),
                      SocialMediaLink(
                        url: AppStrings.urlWhatsapp,
                        icon: FontAwesomeIcons.whatsapp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.heightXS),
            Text(
              AppStrings.titleMapContainer,
              style: AppTextStyles.largeBold,
            ),
            const SizedBox(height: AppDimens.heightXXS),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _boboTeaLocation,
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId(AppStrings.markerMap),
                    position: _boboTeaLocation,
                    infoWindow: const InfoWindow(
                      title: AppStrings.titleMap,
                      snippet: AppStrings.snippetMap,
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
