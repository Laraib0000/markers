import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:trigon_application/Constants/colors.dart';
import 'package:trigon_application/Constants/constants.dart';

import 'direction_screen.dart';
import 'package:permission_handler/permission_handler.dart' as myPermission;

class EVSDetailScreen extends StatefulWidget {
  final String photo,
      type,
      number,
      status,
      description1,
      description2,
      lat,
      lng;
  List<dynamic> connector = [];
  EVSDetailScreen(
      {required this.photo,
      required this.type,
      required this.number,
      required this.status,
      required this.description1,
      required this.description2,
      required this.connector,
      required this.lat,
      required this.lng});

  @override
  State<EVSDetailScreen> createState() => _EVSDetailScreenState();
}

class _EVSDetailScreenState extends State<EVSDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.connector;
    print("this is data ${widget.connector}");
    for (var i = 0; i < widget.connector.length; i++) {
      print("record is $i");
      print(" lat is ${widget.lat}");
    }
  }

  myPermission.PermissionStatus? permissionStatus;
  var location = Location();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: whiteC, size: 33),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height / 3.6,
              width: width,
              color: redC,
              child: Image(
                image: NetworkImage(
                  widget.photo,
                ),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.type, style: boldText),
            ),
            divider,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Charger Number:', style: normalText),
                      Text(
                        widget.number,
                        style: normalText,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Charger Status:', style: normalText),
                      Text(
                        widget.status,
                        style: normalText,
                      )
                    ],
                  ),
                ],
              ),
            ),
            divider,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Connector Status:', style: normalText),
                  Container(
                      height: 80,
                      width: 130,
                      // color: lightBC,
                      // child: Text(widget.connector.length.toString()),
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.connector.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("this is index $index");
                            return Image(
                                height: 50,
                                width: 40,
                                image: NetworkImage(widget.connector[index]
                                    ["connectorStatusImage"]));
                          },
                        ),
                      )),
                  // Image(
                  // image: NetworkImage(widget.connectorImage1),
                  // ),
                ],
              ),
            ),
            divider,
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(widget.description1, style: smallText),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Text(widget.description2, style: smallText),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    // getCurrentLocation() async {
                    //   await myPermission.Permission.location.request();
                    //   permissionStatus =
                    //       await myPermission.Permission.location.status;
                    //   if (permissionStatus!.isGranted) {
                    //     final post = await location.getLocation();
                    //     print(
                    //         "location from direction screen ${post.latitude}");
                    //     var Slat = post.latitude;
                    //     print("only lat is $Slat");
                    //   }
                    // }

                    print(
                        "sending lat and lng to direction screen is: ${widget.lat} & ${widget.lng}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DirectionScreen(
                                // Dlat: widget.lat,
                                // Dlng: widget.lng,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                        height: height * 0.05,
                        width: width / 2,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff000000), Color(0xffe31c73)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Get Direction',
                            style: TextStyle(
                                color: whiteC,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
