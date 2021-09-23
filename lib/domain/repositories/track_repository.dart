import 'package:app_delivery_3/domain/entities/track.dart';

abstract class TrackRepository {
  Future<Track> getInitialTrack();
  Future<Track> getCurrentTrack();
}
