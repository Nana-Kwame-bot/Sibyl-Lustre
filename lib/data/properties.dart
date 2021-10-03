import 'package:sibly_lustre/data/parameter.dart';

class Properties {
  Properties({
    required this.parameter,
  });
  late final Parameter parameter;

  Properties.fromJson(Map<String, dynamic> json) {
    parameter = Parameter.fromJson(json['parameter']);
  }
}
