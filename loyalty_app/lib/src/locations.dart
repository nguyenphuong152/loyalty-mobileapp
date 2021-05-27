import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Office {
  String address;
  String id;
  double lat;
  double lng;
  String name;
  double distance;

  Office(office) {
    address = office["address"];
    id = office["id"];
    lat = office["lat"];
    lng = office["lng"];
    name = office["name"];
  }
}

@JsonSerializable()
class Locations {
  final size = 5;
  List<Office> offices = [];

  Locations.fromJson(Map<String, dynamic> parsedJson) {
    List<Office> temp = [];

    for (int i = 0; i < size; i++) {
      Office office = Office(parsedJson["offices"][i]);
      double distance = (Geolocator.distanceBetween(office.lat, office.lng,
              currentPosition.latitude, currentPosition.longitude) /
          1000);
      office.distance = double.parse(distance.toStringAsFixed(2));
      temp.add(office);
    }
    offices = temp;

    //sort theo thu tu gan den xa
    Comparator<Office> sortByDistance =
        (a, b) => a.distance.compareTo(b.distance);
    offices.sort(sortByDistance);
  }
}

Position currentPosition;

void setCurrentPosition(Position cur) {
  currentPosition = cur;
}

Future<Locations> getStores() async {
  String data = await rootBundle.loadString("assets/json/locations.json");
  Locations stores = Locations.fromJson(json.decode(data));
  return stores;
}
