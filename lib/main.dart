import 'package:buscalo/horarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bús-calo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Bús-calo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? position;
  String? currentLocation;
  GeoPoint? myPosition;

  void _getCurrentLocation() async {
    myPosition = await mapcontroller.myLocation();
  }

  void createMarker() async {
    await mapcontroller.addMarker(
        GeoPoint(latitude: 21.144551345566825, longitude: -88.1517652944766),
        markerIcon: MarkerIcon(
          iconWidget: InkWell(
            onTap: (() => print(("object"))),
            child: const Icon(
              Icons.bus_alert,
              size: 70,
            ),
          ),
        ));
  }

  late MapController mapcontroller = MapController(
    initMapWithUserPosition: true,
  );

  void drawRoad() async {
    myPosition = await mapcontroller.myLocation();
    RoadInfo roadInfo = await mapcontroller.drawRoad(
      myPosition!,
      GeoPoint(latitude: 21.144551345566825, longitude: -88.1517652944766),
      intersectPoint: [
        GeoPoint(latitude: 21.1461248, longitude: -88.1553325),
        GeoPoint(latitude: 21.1455532, longitude: -88.1555472),
      ],
      roadType: RoadType.car,
      roadOption: const RoadOption(
        roadWidth: 15,
        roadColor: Color(0xFF0D47A1),
        showMarkerOfPOI: true,
        zoomInto: true,
      ),
    );
    createMarker();
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[900],
      ),
      body: OSMFlutter(
        controller: mapcontroller,
        trackMyPosition: true,
        initZoom: 12,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
              icon: Icon(
            Icons.person_pin_circle,
            size: 80,
            color: Colors.red,
          )),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: RoadConfiguration(
          startIcon: const MarkerIcon(
            icon: Icon(
              Icons.person,
              size: 64,
              color: Colors.brown,
            ),
          ),
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
          icon: Icon(
            Icons.add,
            color: Colors.blue,
            size: 70,
          ),
        )),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue[900],
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.route), label: 'Ruta', onTap: drawRoad),
          SpeedDialChild(
              child: const Icon(Icons.list_alt),
              label: 'Horarios',
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HorariosPage(),
                  ),
                );
              }),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
