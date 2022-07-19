import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:trigon_application/Services/stats_services.dart';

import '../Constants/constants.dart';
import '../Constants/lat_lng.dart.dart';

import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:permission_handler/permission_handler.dart' as myPermission;

import '../Constants/utilities.dart';
import '../Services/api_urls.dart';
import 'EVSDetail_screen.dart';

class RouteOption extends StatefulWidget {
  @override
  _RouteOptionState createState() => _RouteOptionState();
}

class _RouteOptionState extends State<RouteOption> {
  GoogleMapController? _controller;

  List<Marker> allMarkers = [];

  late PageController _pageController;

  int? prevPage;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  EVSStations evsStations = EVSStations();
  int _markerIdCounter = 1;
  myPermission.PermissionStatus? permissionStatus;
  var location = Location();
  late BitmapDescriptor _markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coffeeShops.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.gps_lat.toString()),
          draggable: false,
          infoWindow: InfoWindow(
              title: element.station_name, snippet: element.meter_no),
          position: element.gps_lat));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  // _coffeeShopList(index) {
  //   return AnimatedBuilder(
  //     animation: _pageController,
  //     builder: (context, widget) {
  //       double value = 1;
  //       if (_pageController.position.haveDimensions) {
  //         // value = (_pageController.page - index)!;
  //         value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
  //       }
  //       return Center(
  //         child: SizedBox(
  //           height: Curves.easeInOut.transform(value) * 125.0,
  //           width: Curves.easeInOut.transform(value) * 350.0,
  //           child: widget,
  //         ),
  //       );
  //     },
  //     child: InkWell(
  //         onTap: () {
  //           // moveCamera();
  //         },
  //         child: Stack(children: [
  //           Center(
  //               child: Container(
  //                   margin: EdgeInsets.symmetric(
  //                     horizontal: 10.0,
  //                     vertical: 20.0,
  //                   ),
  //                   height: 125.0,
  //                   width: 275.0,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black54,
  //                           offset: Offset(0.0, 4.0),
  //                           blurRadius: 10.0,
  //                         ),
  //                       ]),
  //                   child: Container(
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10.0),
  //                           color: Colors.white),
  //                       child: Row(children: [
  //                         Container(
  //                             height: 90.0,
  //                             width: 90.0,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.only(
  //                                     bottomLeft: Radius.circular(10.0),
  //                                     topLeft: Radius.circular(10.0)),
  //                                 image: DecorationImage(
  //                                     image: NetworkImage(
  //                                         coffeeShops[index].image),
  //                                     fit: BoxFit.cover))),
  //                         SizedBox(width: 5.0),
  //                         Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 coffeeShops[index].station_name,
  //                                 style: TextStyle(
  //                                     fontSize: 12.5,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                               Text(
  //                                 coffeeShops[index].meter_no,
  //                                 style: TextStyle(
  //                                     fontSize: 12.0,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               Container(
  //                                 width: 170.0,
  //                                 child: Text(
  //                                   coffeeShops[index].meter_no,
  //                                   style: TextStyle(
  //                                       fontSize: 11.0,
  //                                       fontWeight: FontWeight.w300),
  //                                 ),
  //                               )
  //                             ])
  //                       ]))))
  //         ])),
  //   );
  // }

  fetchEvsRecord() async {
    final res = await http.get(Uri.parse(AppUrl.baseUrl), headers: {
      'evApiKey': 'C3oXF1fT6GLW7Jasm9eIbHVDgMS2pq4EkPlyRr0uQzhUtx8Ocd',
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var resData = data["data"];
      if (resData.length > 0) {
        createMarker(resData);
      } else {}

      print("allRecords ${resData.length}");
    } else {
      throw Exception('Failed');
    }
    // return throw Exception('Failed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(13.7563, 100.5018), zoom: 8.0),
                // markers: Set.from(allMarkers),
                markers: Set<Marker>.of(markers.values),
                onMapCreated: mapCreated,
              ),
              // FutureBuilder(
              //   future: evsStations.fetchEvsRecord(),
              //   // initialData: InitialData,
              //   builder: (context, AsyncSnapshot<Abcd> snapshot) {
              //     if (snapshot.hasError) {
              //       return Center(
              //         child: Text(snapshot.error.toString()),
              //       );
              //     } else if (!snapshot.hasData) {
              //       return Center(child: Text('NO data'));
              //     } else {
              //       return GoogleMap(
              //         initialCameraPosition: CameraPosition(
              //             target: LatLng(40.7128, -74.0060), zoom: 12.0),
              //         // markers: Set.from(allMarkers),
              //         markers: Set<Marker>.of(markers.values),
              //         onMapCreated: mapCreated,
              //       );
              //     }
              //   },
              // ),
            ),
          ],
        ));
  }

  void mapCreated(controller) async {
    setState(() {
      _controller = controller;
      fetchEvsRecord();
    });
    await myPermission.Permission.location.request();
    permissionStatus = await myPermission.Permission.location.status;
    if (permissionStatus!.isGranted) {
      final post = await location.getLocation();
      print("this is my location $post");
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(13.736717, 100.523186),
            zoom: 5,
          ),
        ),
      );
      // saveCurrentLocation(post.latitude, post.longitude);
      _createMarker(post.latitude!, post.longitude!);
    } else {
      permissionDeniedMethod(
        context,
        "Location",
      );
      // await myPermission.openAppSettings();
    }
  }

  moveCamera() {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController.page!.toInt()].gps_lat,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  createMarker(lstZones) async {
    // String markerPath = "assets/images/person.jpg";
    if (lstZones != null && lstZones.length > 0) {
      for (int x = 0; x < lstZones.length; x++) {
        print("result $x : ${lstZones[x]["lat"]}");
        if (lstZones[x] != null &&
            lstZones[x]["lat"] != null &&
            lstZones[x]["lng"] != null) {
          // var iconUrl = lstZones[x].chargerPhoto;
          // print("this is the iconurl $iconUrl");

          //get image data from network
          var dataBytes;
          // var request = await http.get(Uri.parse(iconUrl));
          // var bytes = request.bodyBytes;

          // setState(() {
          //   dataBytes = bytes;
          // });

          final Uint8List markerIcon =
              await getBytesFromAsset('assets/images/evs.png', 100);

          //save image data in temp file
          // String dir = (await getApplicationDocumentsDirectory()).path;
          // File file = new File('$dir/$_markerIdCounter.png');
          // // await file.writeAsBytes(bytes);
          // print("imageiCon : ${file.path}");

          _markerIdCounter++;
          final MarkerId markerId = MarkerId(_markerIdCounter.toString());

          double lat, long;
          lat = double.parse(lstZones[x]["lat"]);
          long = double.parse(lstZones[x]["lng"]);

          // creating a new MARKER
          final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(lat, long),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
                title: lstZones[x]["chargerID"],
                onTap: () {
                  // print("this is all data $lstZones[x]");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EVSDetailScreen(
                                photo: lstZones[x]["chargerPhoto"],
                                type: lstZones[x]["location"]["textEN"],
                                number: lstZones[x]["number"],
                                status: lstZones[x]["chargerStatus"]["textEN"],
                                description1: lstZones[x]["description"]
                                    ["textEN"],
                                description2: lstZones[x]["description"]
                                    ["textTH"],
                                connector: lstZones[x]["connector"],
                                lat: lstZones[x]["lat"],
                                lng: lstZones[x]["lng"],
                                // ,
                              )));
                }),
            // onTap: () {

            // }
            // animateToLocation(lat, long);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => RequestChatScreen(lstZones[x])));
            // _customInfoWindowController.addInfoWindow(
            //   GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   RequestChatScreen(lstZones[x])));
            //     },
            //     child: Container(
            //       height: 20.0,
            //       width: 60.0,
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //       child: Center(
            //         child: Text(
            //           "${lstZones[x].name.capitalize()}",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 16.0,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //   ),
            //   LatLng(lat, long),
            // );

            // lstZones[x].latitude == null && lstZones[x].longitude == null
            //     ? showToast("Something went wrong", context)
            //     : showGeneralDialog(
            //         context: context,
            //         pageBuilder: (
            //           dialogContext,
            //           animation,
            //           secondaryAnimation,
            //         ) =>
            //             myDialogDeletedialogContext(
            //           dialogContext,
            //           animation,
            //           secondaryAnimation,
            //           lstZones[x],
            //         ),
            //         transitionBuilder: (context, anim1, anim2, child) {
            //           return SlideTransition(
            //             position: Tween(
            //               begin: Offset(0, 1),
            //               end: Offset(0, 0),
            //             ).animate(anim1),
            //             child: child,
            //           );
            //         },
            //         transitionDuration: Duration(milliseconds: 500),
            //       );
            // },
          );
          setState(() {
            markers[markerId] = marker;
          });
        }
      }
    } else
      print('no data found');
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()
      ..color = hexToColor(lightBlueColor).withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // // Add tag circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: radius,
    //     ),
    //     tagPaint);

    // // Add tag text
    // TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    // textPainter.text = TextSpan(
    //   text: '1',
    //   style: TextStyle(fontSize: 20.0, color: Colors.white),
    // );

    // textPainter.layout();
    // textPainter.paint(
    //     canvas,
    //     Offset(size.width - tagWidth / 2 - textPainter.width / 2,
    //         tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(
        imagePath); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
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

  _createMarker(double latitude, double longitude) async {
    String markerPath = "assets/images/findevs.png";
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
}
