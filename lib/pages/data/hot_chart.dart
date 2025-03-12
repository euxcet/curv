import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HotChart extends StatefulWidget {
  const HotChart({Key? key}) : super(key: key);

  @override
  _HotChartState createState() => _HotChartState();
}

class FlSpot {
  final double? x;
  final double? y;
  FlSpot(
    this.x,
    this.y,
  );
}

class _HotChartState extends State<HotChart> {
  ///see AutomaticKeepAliveClientMixin
  List<FlSpot> spots1 = [];

  @override
  void initState() {
    super.initState();
    spots1 = [
      FlSpot(1, 0),
      FlSpot(2, 2),
      FlSpot(3, 0),
      FlSpot(4, 3),
      FlSpot(5, 1),
      FlSpot(6, 2),
      FlSpot(7, 10),
    ];
  }

  void registerHandler() {}

  late bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(isVisible: false),
          // primaryYAxis: CategoryAxis(isVisible: true),
          // Chart title
          title: ChartTitle(text: ''),
          // Enable legend
          legend: Legend(isVisible: false),
          // Enable tooltip

          series: <ColumnSeries<FlSpot, String>>[
            ColumnSeries<FlSpot, String>(
                dataSource: spots1,
                color: Color(0xffffaa00),
                xValueMapper: (FlSpot sales, _) => sales.x.toString(),
                yValueMapper: (FlSpot sales, _) => sales.y,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: false))
          ]),
    );
  }
}
