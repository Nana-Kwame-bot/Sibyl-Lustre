import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sibly_lustre/data/address.dart';
import 'package:sibly_lustre/data/sunshine.dart';
import 'package:sibly_lustre/services/geolocation.dart';
import 'package:sibly_lustre/services/power_service.dart';
import 'package:sibly_lustre/utils/intensityData.dart';

import 'date_range_picker.dart';

class SunshineData extends StatefulWidget {
  final Position positionData;

  const SunshineData({Key? key, required this.positionData}) : super(key: key);

  @override
  _SunshineDataState createState() => _SunshineDataState();
}

class _SunshineDataState extends State<SunshineData> {
  ScrollController _scrollController = ScrollController();
  late Sunshine data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _generateSolarEnergy({required Sunshine sunshineData}) {
    for (final entry
        in sunshineData.properties.parameter.lightIntensities.entries) {
      Provider.of<IntensityData>(context, listen: false).addToList(
        date: _formatDate(date: entry.key),
        intensity: entry.value < 0 ? 0 : entry.value,
      );
    }
  }

  void getData() async {
    data = await fetchData(client: http.Client());
    _generateSolarEnergy(sunshineData: data);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDate({required String date}) {
    DateTime _date = DateTime.parse(date);
    return "${_date.day}-${_date.month}-${_date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: FutureBuilder<Address>(
            initialData: Address(
              country: '',
              locality: '',
              subLocality: '',
              postalCode: '',
              street: '',
            ),
            future: userLocation.getAddressFromLatLong(widget.positionData),
            builder: (BuildContext context, AsyncSnapshot<Address> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.locality,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                );
              }
              return SizedBox(
                height: 20.0,
              );
            },
          ),
        ),
        ListTile(
          dense: true,
          leading: Text(
            "Solar Energy Report",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          trailing: DateRangePicker(
            sunData: (Sunshine value) {
              setState(() {
                _generateSolarEnergy(sunshineData: value);
              });
            },
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date"),
              Text("KW-hr/m^2/day"),
            ],
          ),
        ),
        Expanded(
          child: Consumer<IntensityData>(
            builder: (BuildContext context, intensityData, Widget? child) {
              return Scrollbar(
                controller: _scrollController,
                isAlwaysShown: false,
                showTrackOnHover: true,
                thickness: 20.0,
                interactive: true,
                radius: Radius.circular(15.0),
                notificationPredicate: (notification) {
                  // print(notification.metrics);
                  return true;
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            intensityData.lightIntensities[index].date,
                          ),
                          Text(
                            intensityData.lightIntensities[index].intensity
                                .toString(),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2.0,
                    );
                  },
                  itemCount: intensityData.lightIntensities.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
