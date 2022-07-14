// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EvsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EvsModel _$EvsModelFromJson(Map<String, dynamic> json) => EvsModel(
      json['chargerID'] as String,
      json['number'] as String,
      json['textEN'] as String,
      json['textTH'] as String,
      json['lat'] as String,
      json['lng'] as String,
      json['chargerPhoto'] as String,
    );

Map<String, dynamic> _$EvsModelToJson(EvsModel instance) => <String, dynamic>{
      'chargerID': instance.chargerID,
      'number': instance.number,
      'textEN': instance.textEN,
      'textTH': instance.textTH,
      'lat': instance.lat,
      'lng': instance.lng,
      'chargerPhoto': instance.chargerPhoto,
    };
