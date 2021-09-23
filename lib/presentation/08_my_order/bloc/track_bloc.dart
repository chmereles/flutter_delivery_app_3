import 'dart:async';

import 'package:app_delivery_3/domain/entities/track.dart';
import 'package:app_delivery_3/domain/repositories/track_repository.dart';
import 'package:app_delivery_3/presentation/08_my_order/bloc/ticker.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackBloc({
    required Ticker ticker,
    required this.repository,
  })  : _ticker = ticker,
        super(TrackInitial()) {
    on<TrackStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
  }

  final Ticker _ticker;
  static int _count = 0;

  StreamSubscription<int>? _tickerSubscription;

  final TrackRepository repository;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(TrackStarted event, Emitter<TrackState> emit) async {
    final track = await repository.getInitialTrack();

    TrackBloc._count = 0;
    emit(TrackRunInProgress(track: track, count: TrackBloc._count));

    await _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: 60).listen((duration) => add(const TimerTicked()));
  }

  void _onTicked(TimerTicked event, Emitter<TrackState> emit) {
    TrackBloc._count = TrackBloc._count + 1;

    if (!_isFinished()) {
      final track = state.track.copyWith(
        currentPoint: state.track.polyPoints[TrackBloc._count],
      );

      print('tick: ${TrackBloc._count}');
      emit(TrackRunInProgress(track: track, count: TrackBloc._count));
    } else {
      _tickerSubscription?.cancel();
      emit(TrackRunComplete(track: state.track));
    }
  }

  bool _isFinished() {
    // const distance = Distance();
    // final puntoUno = state.track.endPoint;
    // final puntoDos = state.track.currentPoint;
    // final distanceMetros = distance(puntoUno, puntoDos);
    // print(distanceMetros);

    return TrackBloc._count > state.track.polyPoints.length;
  }

  /*
  Future<void> getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    final network = NetworkHelper(
      startLat: track.startPoint.latitude,
      startLng: track.startPoint.longitude,
      endLat: track.endPoint.latitude,
      endLng: track.endPoint.longitude,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // We can reach to our desired JSON data manually as following
      final ls = LineString(
        data['features'][0]['geometry']['coordinates'] as List<dynamic>,
      );

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(
          ls.lineString[i][1] as double,
          ls.lineString[i][0] as double,
        ));
      }

      if (polyPoints.length == ls.lineString.length) {
        print(ls);
        //print(polyPoints);
      }
    } catch (e) {
      print(e);
      //print(polyPoints);
    }
  }
  */

}
