import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatefulWidget {
  final Map<DateTime,int> stepCountMap;
  final String goal;

  PieChart({Key key, this.stepCountMap, this.goal}): super(key: key);
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  Map<String, int> data;
  int achieved = 0;
  int notAchieved = 0;
  List<Color> colorList = [
    Color(0xFF93F4FE),
    Colors.black
  ];
  List<charts.Series<PieElement,String>> series;


  @override
  void initState() {
    super.initState();
    List<PieElement> data = new List<PieElement>();
    if(widget.stepCountMap.length<=7){
      widget.stepCountMap.forEach((k,v) {
        if(v>=int.parse(widget.goal)){
          setState(() {
            achieved += 1;
          });
        }
        else{
          setState(() {
            notAchieved += 1;
          });
        }
      });
    }
    else{
      DateTime now = DateTime.now();
      widget.stepCountMap.forEach((k,v) {
        print(now.difference(k).inDays);
        if(now.difference(k).inDays<=6){
          if(v>=int.parse(widget.goal)){
            setState(() {
              achieved += 1;
            });
          }
          else{
            setState(() {
              notAchieved += 1;
            });
          }
        }
      });
    }
    data.add(new PieElement("Achieved", achieved, charts.ColorUtil.fromDartColor(Color(0xFF93F4FE))));
    data.add(new PieElement("Not Achieved", notAchieved, charts.ColorUtil.fromDartColor(Color(0xFF343434))));

    series = [new charts.Series(
      id: 'graph',
      domainFn: (PieElement data, _) => data.legend,
      measureFn: (PieElement data, _) => data.count,
      colorFn: (PieElement data, _) => data.color,
      data: data,
      labelAccessorFn: (PieElement data, _) => '${data.count} days',
    )];
  }

  @override
  Widget build(BuildContext context) {

    var chart = new charts.PieChart(
      series, 
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside,
            outsideLabelStyleSpec: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.white
          ),
          )
        ]
      ),
    );

    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 10.0,
        color: const Color(0xFF4C4C4C),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Weekly Goal Achievement',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 12
              ),
            ),
            // Row(
            //   children: <Widget>[
            // Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 15.0,
                      minWidth: 15.0,
                      maxHeight: 15.0,
                      maxWidth: 15.0,
                    ),
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(color: Theme.of(context).accentColor),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10),),
                  Text('-   Achieved',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10),),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 15.0,
                      minWidth: 15.0,
                      maxHeight: 15.0,
                      maxWidth: 15.0,
                    ),
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(color: Color(0xFF343434))
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10),),
                  Text('-   Not Achieved',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10, bottom: 10),),
                ],
              ),
              
            // ],),
                Expanded(child: chart,),
                
              // ],
            // )
          ],
        ),
        )
      ),
    );
  }
}

class PieElement{
  final String legend;
  final int count;
  final charts.Color color;

  PieElement(this.legend, this.count, this.color);
}