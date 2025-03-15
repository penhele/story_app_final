import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app_final/screen/upload/show_image_widget.dart';

import '../../data/common/common.dart';
import '../../provider/story_list_provider.dart';
import '../../data/model/story/add_story_request.dart';
import '../../provider/add_story_provider.dart';
import '../../provider/home_provider.dart';
import 'placemark_widget.dart';

class AddStoryScreen extends StatefulWidget {
  final Function() toHomeScreen;

  const AddStoryScreen({super.key, required this.toHomeScreen});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController descriptionController = TextEditingController();

  final monasLocation = const LatLng(-6.175244642313942, 106.82718057185411);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  geo.Placemark? placemark;

  LatLng? seletedLocation;

  @override
  void initState() {
    super.initState();
    seletedLocation = monasLocation;
  }

  @override
  Widget build(BuildContext context) {
    final addStoryProvider = context.watch<AddStoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addStoryAppBar),
        centerTitle: true,
      ),

      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 18,
                target: LatLng(monasLocation.latitude - 0.0005, monasLocation.longitude),
              ),
              markers: markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) async {
                final info = await geo.placemarkFromCoordinates(
                  monasLocation.latitude,
                  monasLocation.longitude,
                );

                final place = info[0];
                final street = place.street!;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                if (mounted) {
                  setState(() {
                    placemark = place;
                    mapController = controller;
                  });
                }

                defineMarker(monasLocation, street, address);
              },
              onLongPress: (LatLng latLng) {
                setState(() {
                  seletedLocation = latLng;
                });

                onLongPressGoogleMap(latLng);
              },
              myLocationEnabled: true,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(Icons.my_location),
                onPressed: () {
                  onMyLocationButtonPress();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (placemark == null)
                        const SizedBox()
                      else
                        Expanded(child: PlacemarkWidget(placemark: placemark!)),

                      const SizedBox(width: 16.0),

                      Column(
                        children: [
                          FloatingActionButton.small(
                            heroTag: "show-image",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ShowImageWidget(),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.image),
                          ),
                          FloatingActionButton.small(
                            heroTag: "zoom-in",
                            onPressed: () {
                              mapController.animateCamera(
                                CameraUpdate.zoomIn(),
                              );
                            },
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton.small(
                            heroTag: "zoom-out",
                            onPressed: () {
                              mapController.animateCamera(
                                CameraUpdate.zoomOut(),
                              );
                            },
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.descriptionHint,
                      labelText: AppLocalizations.of(context)!.descriptionLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 3,
                  ),

                  const SizedBox(height: 16.0),

                  addStoryProvider.isAddStoryLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async => await _uploadStory(context),
                          icon: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.uploadLabel,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4F959D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
      seletedLocation = latLng;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  Future<void> _uploadStory(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final homeProvider = context.read<HomeProvider>();
    final addStoryProvider = context.read<AddStoryProvider>();

    final XFile? imageFile = homeProvider.imageFile;
    if (imageFile == null) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorSelectImage,
          Colors.red,
        ),
      );
      return;
    }

    if (!kIsWeb) {
      File file = File(imageFile.path);
      int fileSize = await file.length();
      if (fileSize > 1024 * 1024) {
        scaffoldMessenger.showSnackBar(
          _buildSnackBar(
            AppLocalizations.of(context)!.errorFileTooLarge,
            Colors.orange,
          ),
        );
        return;
      }
    }

    if (descriptionController.text.trim().isEmpty) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorEmptyDescription,
          Colors.red,
        ),
      );
      return;
    }

    final AddStoryRequest addStory = AddStoryRequest(
      description: descriptionController.text,
      photo: imageFile,
      lat: seletedLocation!.latitude,
      lon: seletedLocation!.longitude,
    );

    try {
      final result = await addStoryProvider.addStory(addStory);
      if (result) {
        context.read<StoryListProvider>().refreshStoryList();
        widget.toHomeScreen();
      } else {
        scaffoldMessenger.showSnackBar(
          _buildSnackBar(
            AppLocalizations.of(context)!.errorUploadFailed,
            Colors.red,
          ),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        _buildSnackBar(
          AppLocalizations.of(context)!.errorUnexpected("{err}"),
          Colors.red,
        ),
      );
    }
  }

  SnackBar _buildSnackBar(String message, Color color) {
    return SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
