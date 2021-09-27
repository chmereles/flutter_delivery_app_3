import 'package:app_delivery_3/config/app_constants.dart';
import 'package:latlong2/latlong.dart';

class Track {
  const Track({
    required this.startPoint,
    required this.endPoint,
    required this.currentPoint,
    required this.distance,
    required this.time,
    this.isComplete = false,
    this.polyPoints = const [],
  });

  final LatLng startPoint;
  final LatLng endPoint;
  final LatLng currentPoint;
  final List<LatLng> polyPoints;
  final bool isComplete;
  final num distance;
  final num time;

  Track copyWith(
          {LatLng? startPoint,
          LatLng? endPoint,
          LatLng? currentPoint,
          LatLng? centerPoint,
          num? distance,
          num? time,
          List<LatLng>? polyPoints}) =>
      Track(
        startPoint: startPoint ?? this.startPoint,
        endPoint: endPoint ?? this.endPoint,
        currentPoint: currentPoint ?? this.currentPoint,
        distance: distance ?? this.distance,
        time: time ?? this.time,
        polyPoints: polyPoints ?? this.polyPoints,
      );

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'complete: $isComplete start: $startPoint - end: $endPoint - curr: $currentPoint - points: $polyPoints';
  }

  String get formatedTime {
    // incrementar el tiempo informado, para equiparar con el tiempo
    // que informa google maps
    final ajustedTime = time * AppConstants.googleMapCorrectionFactor;

    if (ajustedTime < 3600) {
      final min = ajustedTime / 60;
      return '${min.truncate()} min';
    } else {
      final hour = ajustedTime / 3600;
      final min = ajustedTime / 3600;
      return '$hour:$min';
    }
  }

  String get formatedDistance {
    final dis = distance / 1000;
    return '${dis.toStringAsFixed(1)} km';
  }
}
