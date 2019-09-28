import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/theme.dart' as style;
import 'package:location/location.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class lihat_kantor_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pageLihatKantor();
  }
}

class pageLihatKantor extends State<lihat_kantor_page> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();

  Map<MarkerId, Marker> markers =
  <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  Map<CircleId, Circle> circles = <CircleId, Circle>{};
  bool state = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.175004, 106.793088),
    zoom: 14.4746,
  );

  Future _add(String id, String latitude, String longitude, String witel,
      String address, String radius) async {
    final MarkerId markerId = MarkerId(id);

    final Uint8List markerIcon =
    await getBytesFromAsset(string.Images.uri_ic_lokasi_kantor, 150);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: LatLng(double.parse(latitude), double.parse(longitude)),
      infoWindow: InfoWindow(title: witel, snippet: address),
    );

    CircleId ci = CircleId(id);
    final Circle circle = Circle(
        circleId: ci,
        radius: double.parse(radius),
        center: LatLng(double.parse(latitude), double.parse(longitude)),
        fillColor: style.Colors.colorCircle,
        strokeColor: style.Colors.colorCircle);

    // adding a new marker to map

    setState(() {
      markers[markerId] = marker;
      circles[ci] = circle;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Scaffold(
      appBar: AppBar(
        backgroundColor: theme.Colors.backgroundHumanCapital,
        title: Text(string.Text.page_lihat_kantor, style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        circles: Set<Circle>.of(circles.values),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToUser,
        label: Text(string.Text.lbl_zoom_in),
        icon: Icon(Icons.supervised_user_circle),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    getNik();
    _loadUser();
  }

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
    });
  }

  Future<void> _goToUser() async {
    final GoogleMapController controller = await _controller.future;

    CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _makeGetRequest() async {
    var latitude = lat.toString();
    var longitude = long.toString();

    final uri = api.Api.lihat_kantor + "$latitude/$longitude";
    print(uri);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);

    var data = jsonDecode(response.body);
    var data_absensi = (data["data"] as List)
        .map((data) => new dataLokasi.fromJson(data))
        .toList();

    foreachHasil(data_absensi);
  }

  void foreachHasil(List<dataLokasi> data_lokasi) {
    for (var ini = 0; ini < data_lokasi.length; ini++) {
      //TODO setstate
      _add(
          ini.toString(),
          data_lokasi[ini].latitude,
          data_lokasi[ini].longitude,
          data_lokasi[ini].witel,
          data_lokasi[ini].alamat,
          data_lokasi[ini].radius);
    }
      //setState(() {
    // });

  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  var lat = 0.0;
  var long = 0.0;
  var nik = "";


  void _loadUser() {
    location.onLocationChanged().listen((value) {
      lat = value["latitude"];
      long = value["longitude"];
      _makeGetRequest();
      setState(() async {
        print("latitude:" + lat.toString());
        final MarkerId markerId = MarkerId(nik);

        final Uint8List markerIcon =
        await getBytesFromAsset(string.Images.uri_ic_naker, 150);

        // creating a new MARKER
        final Marker marker = Marker(
          markerId: markerId,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(lat, long),
        );

        // adding a new marker to map
        markers[markerId] = marker;
      });
    });
  }
}

class dataLokasi {
  String alamat;
  String longitude;
  String latitude;
  String id;
  String witel;
  String radius;

  dataLokasi(
      {this.alamat,
        this.latitude,
        this.longitude,
        this.id,
        this.witel,
        this.radius});

  factory dataLokasi.fromJson(Map<String, dynamic> parsedJson) {
    return dataLokasi(
      alamat: parsedJson['alamat'].toString(),
      latitude: parsedJson['latitude'].toString(),
      longitude: parsedJson['longitude'].toString(),
      id: parsedJson['no'].toString(),
      witel: parsedJson['witel'].toString(),
      radius: parsedJson['akurasi'].toString(),
    );
  }
}
