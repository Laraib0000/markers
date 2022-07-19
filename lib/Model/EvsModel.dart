import 'package:json_annotation/json_annotation.dart';

part 'EvsModel.g.dart';

@JsonSerializable()
class EvsModel {
  String lat, lng;

  EvsModel(this.lat, this.lng);

  factory EvsModel.fromJson(Map<String, dynamic> json) =>
      _$EvsModelFromJson(json);
  Map<String, dynamic> toJson() => _$EvsModelToJson(this);
}
