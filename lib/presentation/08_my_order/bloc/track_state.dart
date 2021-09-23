part of 'track_bloc.dart';

final pointZero = LatLng(0, 0);

final Track trackZero = Track(
  startPoint: LatLng(0, 0),
  endPoint: LatLng(0, 0),
  currentPoint: LatLng(0, 0),
  distance: 1,
  time: 0,
);

abstract class TrackState extends Equatable {
  const TrackState({
    required this.track,
    this.tmpCount = 0,
  });
  final Track track;
  final int tmpCount;

  @override
  List<Object> get props => [track];
}

class TrackInitial extends TrackState {
  TrackInitial() : super(track: trackZero);
}

class TrackRunInProgress extends TrackState {
  const TrackRunInProgress({
    required Track track,
    required int count,
  }) : super(
          track: track,
          tmpCount: count,
        );

  @override
  String toString() => 'TrackRunInProgress { track: $track }';
}

class TrackRunComplete extends TrackState {
  const TrackRunComplete({required Track track}) : super(track: track);
}

class TrackLoaded extends TrackState {
  const TrackLoaded({required Track track}) : super(track: track);
}

class TrackError extends TrackState {
  const TrackError({required Track track}) : super(track: track);
}
