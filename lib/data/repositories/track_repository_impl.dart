import 'package:app_delivery_3/data/datasources/track_data_source.dart';
import 'package:app_delivery_3/data/models/track_model.dart';
import 'package:app_delivery_3/domain/entities/track.dart';
import 'package:app_delivery_3/domain/repositories/track_repository.dart';

class TrackRepositoryImpl implements TrackRepository {
  TrackRepositoryImpl(this.dataSource);

  final TrackDataSource dataSource;

  @override
  Future<Track> getCurrentTrack() async {
    // final coordList = await dataSource.getDirections();
    final mapTrack = await dataSource.getTrack();

    final mapJson = <String, dynamic>{
      'is_complete': mapTrack['is_complete'],
      'end_point': mapTrack['end_point'],
      'start_point': mapTrack['start_point'],
      'current_point': mapTrack['current_point'],
      // 'coordinates': coordList,
    };

    return TrackModel.fromJson(mapJson);
  }

  @override
  Future<Track> getInitialTrack() async {
    final coordList = await dataSource.getDirections();
    final mapTrack = await dataSource.getTrack();

    // ['features'][0]['properties']['summary']['distance'] as double
    // ['features'][0]['properties']['summary']['duration'] as double
    // ['features'][0]['geometry']['coordinates'] as List<dynamic>

    final geometry = coordList['geometry'] as Map<String, dynamic>;
    final properties = (coordList['properties']
        as Map<String, dynamic>)['summary'] as Map<String, dynamic>;

    final coordinates = geometry['coordinates'] as List<dynamic>;
    final distance = properties['distance'] as double;
    final time = properties['duration'] as double;

    final mapJson = <String, dynamic>{
      'is_complete': mapTrack['is_complete'],
      'end_point': mapTrack['end_point'],
      'start_point': mapTrack['start_point'],
      'current_point': mapTrack['current_point'],
      'coordinates': coordinates,
      'distance': distance,
      'time': time,
    };

    return TrackModel.fromJson(mapJson);
  }
}
