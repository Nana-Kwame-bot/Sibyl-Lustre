class Labels {
  Labels({
    required this.units,
    required this.longName,
  });

  late final String units;
  late final String longName;

  Labels.fromJson(Map<String, dynamic> json) {
    units = json['units'];
    longName = json['longname'];
  }
}
