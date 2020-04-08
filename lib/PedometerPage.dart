import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_fit/Graph.dart';
import 'package:get_fit/PieChart.dart';

class PedometerPage extends StatefulWidget {
  final Map<DateTime,int> stepCountMap;
  final String goal;
  PedometerPage({Key key, this.stepCountMap, this.goal}): super(key: key);

  static final routeName = '/ped';
  @override
  _PedometerPageState createState() => _PedometerPageState();
}

class _PedometerPageState extends State<PedometerPage> {
  @override
  void initState() {
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      resizeToAvoidBottomPadding: false,
      // backgroundColor: Colors.white,
      // backgroundColor: const Color(0xFF4C4C4C),
      backgroundColor: const Color(0xFF343434),
      body: Column(
        children: <Widget>[
          widget.stepCountMap.isNotEmpty ? 
          Graph(stepCountMap: widget.stepCountMap): Container(
            child: Text('Wait a day for stats to show up'),
            padding: EdgeInsets.only(top: 10),
            ),
          widget.stepCountMap.isNotEmpty ? 
          PieChart(stepCountMap: widget.stepCountMap, goal: widget.goal) : Container()
        ],),

    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF262626),
      centerTitle: true,
      title: Text('G E T   F I T',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
    );
  }
}