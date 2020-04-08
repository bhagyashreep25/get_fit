import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Graph extends StatefulWidget {
  final Map<DateTime,int> stepCountMap;

  Graph({Key key, this.stepCountMap}): super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<charts.Series<GraphClass,String>> series;
  @override
  initState() {
    super.initState();
    List<GraphClass> data = new List<GraphClass>();
    if(widget.stepCountMap.length>7){
      DateTime now = DateTime.now();
      widget.stepCountMap.forEach((k,v) {
        print(now.difference(k).inDays);
      if(now.difference(k).inDays<=6){
        data.add(new GraphClass(
          DateFormat('E').format(k).toString(), 
          // k.weekday.toString(),
          v, 
        // charts.ColorUtil.fromDartColor(Colors.cyan)
        charts.ColorUtil.fromDartColor(Color(0xFF93F4FE)) //accent color
        ));
      }
    });
    }
    else{
      widget.stepCountMap.forEach((k,v) => data.add(new GraphClass(DateFormat('E').format(k).toString(), v, 
      // charts.ColorUtil.fromDartColor(Colors.cyan)
      charts.ColorUtil.fromDartColor(Color(0xFF93F4FE)) //accent color
      )));
    }
    
    series = [new charts.Series(
      id: 'graph',
      domainFn: (GraphClass data, _) => data.date,
      measureFn: (GraphClass data, _) => data.count,
      colorFn: (GraphClass data, _) => data.color,
      data: data,
    )];
  }

  // _addPref(List<GraphClass> data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
    
  //   data.add(new GraphClass(DateFormat('hh:mm').format(DateTime.now()).toString(), prefs.getInt('today'), charts.ColorUtil.fromDartColor(Colors.cyan)));
  // }

  @override
  Widget build(BuildContext context) {
    var chart = new charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          labelStyle: new charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.white
          ),
          lineStyle: new charts.LineStyleSpec(
            color: charts.MaterialPalette.white
          )
        )
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.white
          ),
          lineStyle: charts.LineStyleSpec(
            thickness: 0,
            color: charts.MaterialPalette.white
          )
        )
      ),
      // primaryMeasureAxis: 
      // primaryMeasureAxis: new charts.NumericAxisSpec(
      //   renderSpec: new charts.GridlineRendererSpec(
      //     labelStyle: new charts.TextStyleSpec(
      //       fontSize: 13,
      //       color: charts.MaterialPalette.white
      //     ),
      //     lineStyle: new charts.LineStyleSpec(
      //       color: charts.MaterialPalette.white
      //     )
      //   )
      // ),
    );

    return Container(
      height: 400,
      padding: EdgeInsets.all(5),
      child: Card(
        // color: Colors.grey,
        // color: const Color(0xFF343434),
        color: const Color(0xFF4C4C4C),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          child: Column(
            children: <Widget>[
              Text(
                "Weekly Steps Overview",
                // style: Theme.of(context).textTheme.body1,
                style: TextStyle(
                  color: Theme.of(context).accentColor, 
                  fontSize: 12
                ),
              ),
              Expanded(
                child: chart,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GraphClass {
  final String date;
  final int count;
  final charts.Color color;

  GraphClass(this.date, this.count, this.color);
}