// /// gps_lat : "13.247961"
// /// gps_long : "100.934508"
// /// station_name : "Elex by EGAT Max สาขา PT บางพระ"
// /// meter_no : "6300585535"

// class LatLngModel {
//   LatLngModel({
//       String? gpsLat, 
//       String? gpsLong, 
//       String? stationName, 
//       String? meterNo,}){
//     _gpsLat = gpsLat;
//     _gpsLong = gpsLong;
//     _stationName = stationName;
//     _meterNo = meterNo;
// }

//   LatLngModel.fromJson(dynamic json) {
//     _gpsLat = json['gps_lat'];
//     _gpsLong = json['gps_long'];
//     _stationName = json['station_name'];
//     _meterNo = json['meter_no'];
//   }
//   String? _gpsLat;
//   String? _gpsLong;
//   String? _stationName;
//   String? _meterNo;
// LatLngModel copyWith({  String? gpsLat,
//   String? gpsLong,
//   String? stationName,
//   String? meterNo,
// }) => LatLngModel(  gpsLat: gpsLat ?? _gpsLat,
//   gpsLong: gpsLong ?? _gpsLong,
//   stationName: stationName ?? _stationName,
//   meterNo: meterNo ?? _meterNo,
// );
//   String? get gpsLat => _gpsLat;
//   String? get gpsLong => _gpsLong;
//   String? get stationName => _stationName;
//   String? get meterNo => _meterNo;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['gps_lat'] = _gpsLat;
//     map['gps_long'] = _gpsLong;
//     map['station_name'] = _stationName;
//     map['meter_no'] = _meterNo;
//     return map;
//   }

// }