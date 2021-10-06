import 'dart:convert';

import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/network_helper.dart';

abstract class AddressDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map<String, dynamic>> getAddress({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  });
}

class AddressDataSourceImpl implements AddressDataSource {
  @override
  Future<Map<String, dynamic>> getAddress({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) async {
    //
    //https:// api.openrouteservice.org /v2/directions/
    //  foot-walking?
    //  api_key = 5b3ce3597851110001cf62486d5cfc78392446fba599f60bfeffe0dd&
    //  start = -65.79810936176467, -28.471106738728093&
    //  end = -65.79795936176467, -28.471106738728093

    const profile = 'foot-walking';
    final start = '$startLon,$startLat';
    final end = '$endLon,$endLat';

    final url =
        Uri.parse('${AppConstants.orsBaseUrl}${AppConstants.orsDirections}'
            '$profile?'
            'api_key=${AppConstants.orsApiKey}&'
            'start=$start&'
            'end=$end');

    final network = NetworkHelper(url: url);
    try {
      final data = await network.getData();
      return data;
    } on NetWorkException catch (e) {
      throw NetWorkException(e.cause);
    }
  }
}

class MemoryAddressDataSourceImp implements AddressDataSource {
  @override
  Future<Map<String, dynamic>> getAddress(
      {required double startLat,
      required double startLon,
      required double endLat,
      required double endLon}) async {
    final data = jsonDecode(myDirection) as Map<String, dynamic>;
    return data;
  }
}

final myDirection = '''
{
   "type":"FeatureCollection",
   "features":[
      {
         "bbox":[
            -65.798106,
            -28.471142,
            -65.797947,
            -28.471106
         ],
         "type":"Feature",
         "properties":{
            "segments":[
               {
                  "distance":18.6,
                  "duration":13.4,
                  "steps":[
                     {
                        "distance":16,
                        "duration":11.5,
                        "type":11,
                        "instruction":"Head east on Pasaje Navarro",
                        "name":"Pasaje Navarro",
                        "way_points":[
                           0,
                           1
                        ]
                     },
                     {
                        "distance":2.6,
                        "duration":1.9,
                        "type":0,
                        "instruction":"Turn left onto Avenida Ahumada y Barros",
                        "name":"Avenida Ahumada y Barros",
                        "way_points":[
                           1,
                           2
                        ]
                     },
                     {
                        "distance":0,
                        "duration":0,
                        "type":10,
                        "instruction":"Arrive at Avenida Ahumada y Barros, on the left",
                        "name":"-",
                        "way_points":[
                           2,
                           2
                        ]
                     }
                  ]
               }
            ],
            "summary":{
               "distance":18.6,
               "duration":13.4
            },
            "way_points":[
               0,
               2
            ]
         },
         "geometry":{
            "coordinates":[
               [
                  -65.798106,
                  -28.471142
               ],
               [
                  -65.797947,
                  -28.471129
               ],
               [
                  -65.797949,
                  -28.471106
               ]
            ],
            "type":"LineString"
         }
      }
   ],
   "bbox":[
      -65.798106,
      -28.471142,
      -65.797947,
      -28.471106
   ],
   "metadata":{
      "attribution":"openrouteservice.org | OpenStreetMap contributors",
      "service":"routing",
      "timestamp":1632711777495,
      "query":{
         "coordinates":[
            [
               -65.79810936176467,
               -28.471106738728093
            ],
            [
               -65.79795936176467,
               -28.471106738728093
            ]
         ],
         "profile":"foot-walking",
         "format":"json"
      },
      "engine":{
         "version":"6.6.1",
         "build_date":"2021-07-05T10:57:48Z",
         "graph_date":"2021-09-14T02:22:03Z"
      }
   }
}
''';
