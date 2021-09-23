import 'dart:convert';

import 'package:app_delivery_3/domain/entities/track.dart';
// import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

// part 'track_model.g.dart';

// @JsonSerializable()
class TrackModel extends Track {
  TrackModel({
    required this.startPoint,
    required this.endPoint,
    required this.currentPoint,
    this.polyPoints = const [],
    required this.isComplete,
    required this.distance,
    required this.time,
  }) : super(
          startPoint: startPoint,
          endPoint: endPoint,
          currentPoint: currentPoint,
          polyPoints: polyPoints,
          isComplete: isComplete,
          distance: distance,
          time: time,
        );

  factory TrackModel.fromRawJson(String str) => TrackModel.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      isComplete: json['is_complete'] as bool,
      endPoint: MyLatLng.fromJson(json['end_point'] as List<num>),
      startPoint: MyLatLng.fromJson(json['start_point'] as List<num>),
      currentPoint: MyLatLng.fromJson(json['current_point'] as List<num>),
      distance: json['distance'] as num,
      time: json['time'] as num,
      polyPoints: (json['coordinates'] as List<dynamic>)
          .map((dynamic e) => MyLatLng.fromJson(e as List<dynamic>))
          .toList(),
    );
  }

  // ignore: annotate_overrides, overridden_fields
  final bool isComplete;
  // ignore: annotate_overrides, overridden_fields
  final LatLng startPoint;
  // ignore: annotate_overrides, overridden_fields
  final LatLng endPoint;
  // ignore: annotate_overrides, overridden_fields
  final LatLng currentPoint;
  // ignore: annotate_overrides, overridden_fields
  final List<LatLng> polyPoints;
  // ignore: annotate_overrides, overridden_fields
  final num distance;
  // ignore: annotate_overrides, overridden_fields
  final num time;
}

class MyLatLng extends LatLng {
  MyLatLng(
    double latitude,
    double longitude,
  ) : super(
          latitude,
          longitude,
        );

  factory MyLatLng.fromJson(List<dynamic> json) {
    return MyLatLng(
      json[1] as double,
      json[0] as double,
    );
  }
}
