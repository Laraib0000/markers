import 'package:json_annotation/json_annotation.dart';

part 'EvsModel.g.dart';

@JsonSerializable()
class EvsModel {
  String chargerID, number, textEN, textTH, lat, lng, chargerPhoto;

  EvsModel(this.chargerID, this.number, this.textEN, this.textTH, this.lat,
      this.lng, this.chargerPhoto);

  factory EvsModel.fromJson(Map<String, dynamic> json) =>
      _$EvsModelFromJson(json);
  Map<String, dynamic> toJson() => _$EvsModelToJson(this);
}
