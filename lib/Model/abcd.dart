/// gps_lat : "13.247961"
/// gps_long : "100.934508"
/// meter_no : "6300585535"

class Abcd {
  Abcd({
    String? gpsLat,
    String? gpsLong,
    String? meterNo,
  }) {
    _gpsLat = gpsLat;
    _gpsLong = gpsLong;
    _meterNo = meterNo;
  }

  Abcd.fromJson(dynamic json) {
    _gpsLat = json['gps_lat'];
    _gpsLong = json['gps_long'];
    _meterNo = json['meter_no'];
  }
  String? _gpsLat;
  String? _gpsLong;
  String? _meterNo;
  Abcd copyWith({
    String? gpsLat,
    String? gpsLong,
    String? meterNo,
  }) =>
      Abcd(
        gpsLat: gpsLat ?? _gpsLat,
        gpsLong: gpsLong ?? _gpsLong,
        meterNo: meterNo ?? _meterNo,
      );
  String? get gpsLat => _gpsLat;
  String? get gpsLong => _gpsLong;
  String? get meterNo => _meterNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gps_lat'] = _gpsLat;
    map['gps_long'] = _gpsLong;
    map['meter_no'] = _meterNo;
    return map;
  }
}
