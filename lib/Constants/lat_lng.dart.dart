// import 'package:google_maps_flutter/google_maps_flutter.dart';

// final List<dynamic> contacts = [
//   {
//     "name": "Elex by EGAT Max สาขา PT บางพระ",
//     "position": const LatLng(13.247961, 100.934508),
//     "marker": 'assets/images/evs.png',
//     "meter_no": '6300585535',
//   },
//   {
//     "name": "Samantha",
//     "position": const LatLng(37.42484642575639, -122.08309359848501),
//     "marker": 'assets/images/route.png',
//   },
//   {
//     "name": "Malte",
//     "position": const LatLng(37.42381625902441, -122.0928531512618),
//     "marker": 'assets/images/splash.png',
//   },
//   {
//     "name": "Julia",
//     "position": const LatLng(37.41994095849639, -122.08159055560827),
//     "marker": 'assets/images/splash.png',
//   },
//   {
//     "name": "Tim",
//     "position": const LatLng(37.413175077529935, -122.10101041942836),
//     "marker": 'assets/images/findevs.png',
//   },
//   {
//     "name": "Sara",
//     "position": const LatLng(37.419013242401576, -122.11134664714336),
//     "marker": 'assets/images/findevs.png',
//   },
//   {
//     "name": "Ronaldo",
//     "position": const LatLng(37.40260962243491, -122.0976958796382),
//     "marker": 'assets/images/findevs.png',
//   },
// ];

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coffee {
  LatLng gps_lat;
  String station_name;
  String meter_no;
  String image;

  Coffee({
    required this.gps_lat,
    required this.station_name,
    required this.meter_no,
    required this.image,
  });
}

final List<Coffee> coffeeShops = [
  Coffee(
      gps_lat: LatLng(13.247961, 100.934508),
      station_name: 'Elex by EGAT Max สาขา PT บางพระ',
      meter_no: '6300585535',
      image: "assets/images/evs.png"),
  Coffee(
    gps_lat: LatLng(15.397303, 100.147794),
    station_name: 'Elex by EGAT Max สาขา PT พยุหะคีรี 2',
    meter_no: '6300571872',
    image: 'assets/images/evs.png',
  ),
  Coffee(
    gps_lat: LatLng(13.314691, 99.827081),
    station_name: 'Elex by EGAT Max สาขา PT พยุหะคีรี 2',
    meter_no: '6300571555',
    image: 'assets/images/evs.png',
  ),
  Coffee(
    gps_lat: LatLng(14.016689, 99.534364),
    station_name: 'Elex by EGAT Max สาขา PT พยุหะคีรี 2',
    meter_no: '6300573178',
    image: 'assets/images/evs.png',
  ),
  Coffee(
    gps_lat: LatLng(14.113372, 100.569608),
    station_name: 'Elex by EGAT Max สาขา PT พยุหะคีรี 2',
    meter_no: '6300406236',
    image: 'assets/images/evs.png',
  )
];
