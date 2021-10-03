import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sibly_lustre/data/LightIntensity.dart';
import 'package:sibly_lustre/utils/intensityData.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<IntensityData>(
        builder: (BuildContext context, intensityData, Widget? child) {
          return SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
              text: 'All Sky Surface Shortwave Downward Irradiance (Daily)',
            ),
            // Enable legend
            // Enable tooltip
            series: <LineSeries<LightIntensity, String>>[
              LineSeries<LightIntensity, String>(
                dataSource: intensityData.lightIntensities,
                xValueMapper: (LightIntensity intensities, _) =>
                    intensities.date,
                yValueMapper: (LightIntensity intensities, _) =>
                    intensities.intensity,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          );
        },
      ),
    );
  }
}
