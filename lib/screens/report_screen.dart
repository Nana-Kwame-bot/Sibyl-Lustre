import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:async/async.dart';
import 'package:sibly_lustre/screens/sunshine_data.dart';
import 'package:sibly_lustre/services/geolocation.dart';

late Position positionData;

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  AsyncMemoizer<Position> asyncMemoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<Position>(future: asyncMemoizer.runOnce(() {
      return userLocation.getGeoLocationPosition();
    }), builder: (
      context,
      AsyncSnapshot<Position> snapshot,
    ) {
      if (snapshot.hasError) {
        return const Center(
          child: Text('An error has occurred!'),
        );
      } else if (snapshot.hasData) {
        positionData = snapshot.data!;
        return SunshineData(
          positionData: positionData,
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
