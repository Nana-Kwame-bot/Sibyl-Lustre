class Parameter {
  Parameter({
    required this.lightIntensities,
  });
  late final Map<String, dynamic> lightIntensities;

  Parameter.fromJson(Map<String, dynamic> json) {
    lightIntensities = json['ALLSKY_SFC_SW_DWN'];
  }
}
