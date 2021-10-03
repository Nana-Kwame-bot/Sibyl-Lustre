import 'package:sibly_lustre/data/parameters.dart';
import 'package:sibly_lustre/data/properties.dart';

import 'geometry.dart';
import 'header.dart';

class Sunshine {
  Sunshine({
    required this.geometry,
    required this.properties,
    required this.header,
    required this.parameters,
  });

  late final Geometry geometry;
  late final Properties properties;
  late final Header header;
  late final Parameters parameters;

  factory Sunshine.fromJson(Map<String, dynamic> json) {
    return Sunshine(
      geometry: Geometry.fromJson(json['geometry']),
      properties: Properties.fromJson(json['properties']),
      header: Header.fromJson(json['header']),
      parameters: Parameters.fromJson(json['parameters']),
    );
  }
}
