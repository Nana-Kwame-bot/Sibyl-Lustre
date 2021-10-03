import 'labels.dart';

class Parameters {
  Parameters({
    required this.labels,
  });
  late final Labels labels;

  Parameters.fromJson(Map<String, dynamic> json) {
    labels = Labels.fromJson(json['ALLSKY_SFC_SW_DWN']);
  }
}
