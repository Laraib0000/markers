import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

import 'package:permission_handler/permission_handler.dart' as myPermission;
import 'package:trigon_application/Constants/colors.dart';
import 'dart:ui' as ui;

import '../Constants/utilities.dart';
import 'google_polyline_screen.dart';

class FindEVS extends StatefulWidget {
  FindEVS({Key? key}) : super(key: key);

  @override
  State<FindEVS> createState() => _FindEVSState();
}

class _FindEVSState extends State<FindEVS> {
  LatLng _initialcameraposition = LatLng(24.8974834, 67.0775689);
  myPermission.PermissionStatus? permissionStatus;
  Location _location = Location();
  GoogleMapController? _controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int _markerIdCounter = 1;
  late BitmapDescriptor _markerIcon;

  BitmapDescriptor? icon;

  static final Marker _FirstEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(13.247961, 100.934508),
  );
  static final Marker _SecondEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(15.397303, 100.147794),
  );
  static final Marker _ThirdEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(13.314691, 99.827081),
  );
  static final Marker _ForthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(14.016689, 99.534364),
  );
  static final Marker _FifthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(14.113372, 100.569608),
  );
  static final Marker _SixthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(17.382271, 102.753265),
  );
  static final Marker _SeventhEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(16.096594, 102.732040),
  );
  static final Marker _EighthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(12.953918, 100.905937),
  );
  static final Marker _NinthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(13.996672, 100.582095),
  );
  static final Marker _TenthEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(12.558122, 99.960228),
  );
  static final Marker _EleventhEVS = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(11.083353, 99.369781),
  );

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    // print('Find evs Screen');
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          // polygons: {_kPolygon},
          initialCameraPosition: CameraPosition(target: _initialcameraposition),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) async {
            _onMapCreated(controller);
          },
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          // markers: Set<Marker>.of(markers.values),
          markers: {
            _FirstEVS,
            _SecondEVS,
            _ThirdEVS,
            _ForthEVS,
            _FifthEVS,
            _SixthEVS,
            _SeventhEVS,
            _EighthEVS,
            _NinthEVS,
            _TenthEVS,
            _EleventhEVS
          },
          onTap: (position) {},
          onCameraMove: (position) {},
        ),
        Positioned(
          bottom: 10,
          left: 20,
          child: Column(
            children: [
              PhysicalModel(
                color: Colors.white,
                elevation: 8,
                shadowColor: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GooglePolylineScreen(
                                latitude: 37.4219983, longitude: -122.084)));
                  },
                  child: Container(
                    height: _height * 0.05,
                    width: _width * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: whiteC),
                    child: Center(
                        child: Text(
                      'Near Me',
                      style: TextStyle(color: blackC, fontSize: 19),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    // _controller!.setMapStyle(_mapStyle);

    await myPermission.Permission.location.request();
    permissionStatus = await myPermission.Permission.location.status;
    print("this is status of permission $permissionStatus");

    if (permissionStatus!.isGranted) {
      final post = await _location.getLocation();
      print("this is the lat and long $post");
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(post.latitude!, post.longitude!),
            zoom: 20,
          ),
        ),
      );
      createMarker(post.latitude!, post.longitude!);
    } else {
      permissionDeniedMethod(
        context,
        "Location",
      );
    }
  }

  createMarker(double latitude, double longitude) async {
    String markerPath = "assets/images/driver_pin.png";
    final Uint8List markerIcon = await getBytesFromAsset(markerPath, 130);

    _markerIcon = BitmapDescriptor.fromBytes(markerIcon);

    _markerIdCounter++;
    final MarkerId markerId = MarkerId(_markerIdCounter.toString());

    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(latitude, longitude),
        icon: _markerIcon,
        onTap: () {});

    print("hello");
    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Marker marker = Marker(
  //   markerId: MarkerId("Current"),
  //   position: LatLng(17.4435, 78.3772),
  // );
}
