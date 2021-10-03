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
          sunData(
            await fetchData(
                client: http.Client(), startDate: start, endDate: end),
          );
        }
      },
      icon: Icon(
        Icons.calendar_today,
        color: Colors.blueAccent,
      ),
    );
  }
}
