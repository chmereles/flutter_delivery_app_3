import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class TrackDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map<String, dynamic>> getTrack();

  Future<Map<String, dynamic>> getDirections();
}

class TrackDataSourceImpl implements TrackDataSource {
  @override
  Future<Map<String, dynamic>> getTrack() async {
    final mapTrack = {
      'is_complete': false,
      'end_point': [-65.6969, -28.3893],
      'start_point': [-65.7009, -28.3877],
      'current_point': [-65.7009, -28.3877],
    };
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return mapTrack;
  }

  @override
  Future<Map<String, dynamic>> getDirections() async {
    /*
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    dynamic data;
    final polyPoints = <String>[];
    // final polyPoints = <Map<String, dynamic>>[];

    final network = NetworkHelper(
      startLat: 0,
      startLng: 0,
      endLat: 0,
      endLng: 0,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // We can reach to our desired JSON data manually as following
      final ls = LineString(
        data['features'][0]['geometry']['coordinates'] as List<dynamic>,
      );

      for (var i = 0; i < ls.lineString.length; i++) {
        // polyPoints.add(LatLng(
        //   ls.lineString[i][1] as double,
        //   ls.lineString[i][0] as double,
        // ));
        // var details = {'Usrname':'tom','Password':'pass@123'};
        // polyPoints.add(details);
      }

      return polyPoints;

      // if (polyPoints.length == ls.lineString.length) {
      //   print(ls);
      //   //print(polyPoints);
      // }
    } catch (e) {
      print(e);
      return [];
      //print(polyPoints);
    }
    */

    // ['features'][0]['properties']['summary']['distance'] as double
    // ['features'][0]['properties']['summary']['duration'] as double
    // ['features'][0]['geometry']['coordinates'] as List<dynamic>
    final dataDecoded =
        jsonDecode(myDirectionResponse)['features'][0] as Map<String, dynamic>;

    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return dataDecoded;
  }
}

class NetworkHelper {
  NetworkHelper({
    required this.startLng,
    required this.startLat,
    required this.endLng,
    required this.endLat,
  });

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf62486d5cfc78392446fba599f60bfeffe0dd';
  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future<dynamic> getData() async {
    http.Response response = await http.get(
      Uri.parse(
          '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'),
    );
    print(
        "$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

//Create a new class to hold the Co-ordinates we've received from the response data

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

const myDirectionResponse = '''
{"type":"FeatureCollection","features":[{"bbox":[-65.700948,-28.389268,-65.696888,-28.387751],"type":"Feature","properties":{"segments":[{"distance":547.9,"duration":131.5,"steps":[{"distance":88.1,"duration":21.1,"type":11,"instruction":"Head west","name":"-","way_points":[0,2]},{"distance":78,"duration":18.7,"type":1,"instruction":"Turn right","name":"-","way_points":[2,3]},{"distance":290.8,"duration":69.8,"type":0,"instruction":"Turn left","name":"-","way_points":[3,9]},{"distance":75,"duration":18,"type":1,"instruction":"Turn right","name":"-","way_points":[9,10]},{"distance":16,"duration":3.8,"type":0,"instruction":"Turn left","name":"-","way_points":[10,11]},{"distance":0,"duration":0,"type":10,"instruction":"Arrive at your destination, on the right","name":"-","way_points":[11,11]}]}],"summary":{"distance":547.9,"duration":131.5},"way_points":[0,11]},"geometry":{"coordinates":[[-65.696888,-28.389254],[-65.696949,-28.389242],[-65.697786,-28.389268],[-65.697819,-28.388567],[-65.69869,-28.388579],[-65.698783,-28.388544],[-65.698875,-28.388513],[-65.699192,-28.388495],[-65.699781,-28.388508],[-65.700776,-28.388517],[-65.700824,-28.387843],[-65.700948,-28.387751]],"type":"LineString"}}],"bbox":[-65.700948,-28.389268,-65.696888,-28.387751],"metadata":{"attribution":"openrouteservice.org | OpenStreetMap contributors","service":"routing","timestamp":1632349456056,"query":{"coordinates":[[-65.6969,-28.3893],[-65.7009,-28.3877]],"profile":"driving-car","format":"json"},"engine":{"version":"6.6.1","build_date":"2021-07-05T10:57:48Z","graph_date":"2021-09-12T10:05:32Z"}}}
''';
