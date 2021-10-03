import 'package:flutter/material.dart';
import 'package:sibly_lustre/data/LightIntensity.dart';

class IntensityData extends ChangeNotifier {
  List<LightIntensity> lightIntensities = [];

  void addToList({required String date, required double intensity}) {
    lightIntensities.add(LightIntensity(date: date, intensity: intensity));
    notifyListeners();
  }
}
