// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart' as myPermission;

// class DirectionScreen extends StatefulWidget {
//   final String Dlat, Dlng;
//   DirectionScreen({required this.Dlat, required this.Dlng});
//   @override
//   _DirectionScreenState createState() => _DirectionScreenState();
// }

// class _DirectionScreenState extends State<DirectionScreen> {
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyAJ6pz3IkaaSuapZIgBDgEYA_t2qweG6Fo";

//   Set<Marker> markers = Set(); //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   LatLng startLocation = LatLng(13.7563, 100.5018);
//   LatLng endLocation = LatLng(13.247961, 100.934508);
//   myPermission.PermissionStatus? permissionStatus;
//   // var location = Location();

//   _onMapCreated(GoogleMapController _cntlr) async {
//     Location _location = Location();
//     GoogleMapController? _controller;

//     final post = await _location.getLocation();
//     print("this is the lat and long $post");
//     _controller!.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(post.latitude!, post.longitude!),
//           zoom: 20,
//         ),
//       ),
//     );
//   }

// LocationData? currentLocation;
// getCurrentLocation() {
//   Location location = Location();
//   location.getLocation().then((location) {
//     currentLocation = location;
//     print("current Location from ${currentLocation!.latitude}");
//   });
// }

//   @override
//   void initState() {
//     getCurrentLocation();
//     // print(
//     //     "lat and lng from direction screen is: ${widget.lat} & ${widget.lng}");
//     markers.add(Marker(
//       //add start location marker
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     getDirections(); //fetch direction polylines from Google API
//     // getCurrentLocation();

//     super.initState();
//   }

//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//       PointLatLng(double.parse(widget.Dlat), double.parse(widget.Dlng)),
//       travelMode: TravelMode.driving,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Route Driection in Google Map"),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//       body: GoogleMap(
//         //Map widget from google_maps_flutter package
//         zoomGesturesEnabled: true, //enable Zoom in, out on map
//         initialCameraPosition: CameraPosition(
//           //innital position in map
//           target: startLocation, //initial position
//           zoom: 8.0, //initial zoom level
//         ),
//         markers: markers, //markers to show on map
//         polylines: Set<Polyline>.of(polylines.values), //polylines
//         onMapCreated: (GoogleMapController controller) async {
//           _onMapCreated(controller);
//           setState(() {
//             mapController = controller;
//           });
//         },
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DirectionScreen extends StatefulWidget {
  DirectionScreen({Key? key}) : super(key: key);

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  final String googleApiKey = "AIzaSyAJ6pz3IkaaSuapZIgBDgEYA_t2qweG6Fo";

  List<LatLng> polylineCoordinate = [];
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinate.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    } else {
      print('empty result');
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(
              child: Text('Loading'),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 12),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinate,
                    color: Colors.blue,
                    width: 6)
              },
              markers: {
                Marker(
                    markerId: const MarkerId("current Location"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!)),
                Marker(markerId: MarkerId("destination"), position: destination)
              },
            ),
    );
  }
}
