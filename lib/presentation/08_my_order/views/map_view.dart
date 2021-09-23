import 'package:app_delivery_3/domain/entities/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapView extends StatelessWidget {
  const MapView({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    print('::build map::');

    const urlTemplate = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    const subdomains = ['a', 'b', 'c'];

    return FlutterMap(
      //
      options: MapOptions(
          // center: track.startPoint,
          bounds: LatLngBounds(track.startPoint, track.endPoint),
          boundsOptions: const FitBoundsOptions(
            padding: EdgeInsets.fromLTRB(80, 0, 80, 100),
          )
          // zoom: 17,
          ),

      //
      layers: [
        //
        TileLayerOptions(
          urlTemplate: urlTemplate,
          subdomains: subdomains,
        ),

        MarkerLayerOptions(
          markers: [
            // start
            Marker(
              height: 50,
              width: 50,
              point: track.startPoint,
              builder: (context) {
                return Transform.translate(
                  offset: const Offset(0, -25),
                  child: GestureDetector(
                    onTap: () {
                      print('print en pin');
                    },
                    child: Image.asset(
                      'assets/images/map_marker.png',
                    ),
                  ),
                );
              },
            ),
            // end
            Marker(
              height: 50,
              width: 50,
              point: track.endPoint,
              builder: (context) {
                return Transform.translate(
                  offset: const Offset(0, -25),
                  child: Image.asset(
                    'assets/images/map_marker.png',
                  ),
                );
              },
            ),

            Marker(
              height: 50,
              width: 100,
              point: track.currentPoint,
              builder: (context) {
                // return Image.asset(
                //   'assets/images/red_marker.png',
                // );
                return Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            // height: 50,
                            child: Text(track.time.toString()),
                          ),
                          Container(
                            child: Text(track.distance.toString()),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),

        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: track.polyPoints,
              strokeWidth: 4,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
