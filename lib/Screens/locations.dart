// // import 'dart:convert';
// // import 'dart:io';
// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import "locations.dart" as locations;

// class Locations {
//   List<Offices> offices;
//   List<Regions> regions;

//   Locations({this.offices, this.regions});

//   Locations.fromJson(Map<String, dynamic> json) {
//     if (json['offices'] != null) {
//       offices = new List<Offices>();
//       json['offices'].forEach((v) {
//         offices.add(new Offices.fromJson(v));
//       });
//     }
//     if (json['regions'] != null) {
//       regions = new List<Regions>();
//       json['regions'].forEach((v) {
//         regions.add(new Regions.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.offices != null) {
//       data['offices'] = this.offices.map((v) => v.toJson()).toList();
//     }
//     if (this.regions != null) {
//       data['regions'] = this.regions.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }


// }
// Future<Locations> getGoogleOffices() async {
//   const googleLocationsURL = 'https://about.google/static/data/locations.json';
//   // Retrieve the locations of Google offices
//   final response = await http.get(googleLocationsURL);
//   if (response.statusCode == 200) {
//    return Locations.fromJson(json.decode(response.body));
//   } else {
//     throw HttpException(
//         'Unexpected status code ${response.statusCode}:'
//         ' ${response.reasonPhrase}',
//         uri: Uri.parse(googleLocationsURL));
//   }
// }