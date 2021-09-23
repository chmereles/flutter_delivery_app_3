part of 'track_bloc.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class TrackStarted extends TrackEvent {}

class TrackGetted extends TrackEvent {}

class TrackCurrentRequested extends TrackEvent {}

class TimerTicked extends TrackEvent {
  const TimerTicked();
  // final int duration;

  // @override
  // List<Object> get props => [duration];
}
