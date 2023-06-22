import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:workout/datetime/date_time.dart';


class MyHeatMap extends StatelessWidget {

  final Map<DateTime,int>? datasets;
  final String startDataYYYMMDD;
  const MyHeatMap({super.key,
    required this.datasets,
    required this.startDataYYYMMDD,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: HeatMap(
        startDate: createDateTimeObject(startDataYYYMMDD),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable:true ,
        size: 30,
        colorsets: {
          1: Colors.white,
        },

      ),
    );
  }
}
