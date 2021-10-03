import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:sibly_lustre/data/sunshine.dart';
import 'package:sibly_lustre/services/power_service.dart';

class DateRangePicker extends StatelessWidget {
  final ValueChanged<Sunshine> sunData;

  const DateRangePicker({Key? key, required this.sunData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          lastDate: DateTime.now(),
          firstDate: new DateTime(1990),
        );
        if (picked != null) {
          var formatter = new DateFormat('yyyyMMdd');
          var start = formatter.format(picked.start);
          var end = formatter.format(picked.end);
          // print(start + end);
          // setState(() {
          sunData(
            await fetchData(
                client: http.Client(), startDate: start, endDate: end),
          );

//             startDate = picked.start;
//             endDate = picked.end;
// //below have methods that runs once a date range is picked
//             allWaterBillsFuture = _getAllWaterBillsFuture(
//                 picked.start.toIso8601String(),
//                 picked.end
//                     .add(new Duration(hours: 24))
//                     .toIso8601String());
//           });
        }
      },
      icon: Icon(
        Icons.calendar_today,
        color: Colors.blueAccent,
      ),
    );
  }
}
