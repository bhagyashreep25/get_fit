import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:get_fit/PedometerPage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cron/cron.dart';

class PedometerCard extends StatefulWidget {
  @override
  _PedometerCardState createState() => new _PedometerCardState();
}

class _PedometerCardState extends State<PedometerCard> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  Map<DateTime,int> _stepCountMap;
  // String _stepCountValue = 'unknown';
  String _stepCountValue = "0";
  String _goal;
  TextEditingController t;
  final _formKey = GlobalKey<FormState>();
  String _calories = "0";
  String _distance = "0";

  double _num;
  double _convert;
  double _kmx;
  double burnedx;

  @override
  void initState() {
    super.initState();
    _goal = "10000";
    _stepCountMap = new Map<DateTime,int>();
    t = TextEditingController();
    t.text = _goal;
    initPlatformState();
    var cron = new Cron();
    cron.schedule(new Schedule.parse('0 0 * * *'), () async {
      _onReset();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void stopListening() {
    _subscription.cancel();
    _pedometer = null;
  }

  void _onData(int stepCountValue) async {
    print(stepCountValue);
    int fin;
    if(_stepCountMap.isEmpty){
      fin = stepCountValue;
    }
    else{
      int val = 0;
      _stepCountMap.forEach((k,v) => val += _stepCountMap[k]);
      fin = stepCountValue - val;
    }
    setState(() {
      _stepCountValue = "$fin";
    });

    // distance part
    var dist = stepCountValue;
    double y = (dist + .0);

    setState(() {
      _num =
          y;
    });

    var long3 = (_num);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_num);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void _onReset() {
    DateTime now = DateTime.now();
      print(_stepCountMap);
      if(_stepCountMap.isEmpty){
        setState(() {
          _stepCountMap[DateTime.now().subtract(new Duration(days: 1))] = int.parse(_stepCountValue);
          _stepCountValue = "0";
          _calories = "0";
          _distance = "0"; 
        });
      }
      else{
        // _stepCountMap.forEach((k,v) {
        //   // if(DateFormat('yyyy-MM-dd').format(k)==DateFormat('yyyy-MM-dd').format(now)){
        //   if(DateFormat('hh:mm').format(k)==DateFormat('hh:mm').format(now)){
        //     setState(() {
        //       _stepCountMap.remove(k);
        //     });
        //   }
        // });
        int val = 0;
        _stepCountMap.forEach((k,v) => val += _stepCountMap[k]);
        int fin = int.parse(_stepCountValue);
        setState(() {
          _stepCountMap[now.subtract(new Duration(days: 1))] = fin;
          _stepCountValue = "0";
          _calories = "0";
          _distance = "0";
        });
      }
      print(_stepCountMap);
      print(_stepCountValue);
    // }
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _num) {
    var distance = ((_num * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _distance = "$distance";
      //print(_distance);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx;
      _calories = "$calories";
      //print(_calories);
    });
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");


  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    //   home: new Scaffold(
    //     appBar: new AppBar(
    //       title: const Text('Pedometer example app'),
    //     ),
    //     body: new Text('Step count: $_stepCountValue')
    //   ),
    // );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new GestureDetector(
      child: Card(
      elevation: 10.0,
      child: Container(
        height: height*0.6,
        width: width,
        color: const Color(0xFF4C4C4C),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: CircularPercentIndicator(
                radius: 200,
                lineWidth: 7,
                animation: true,
                center: Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 60),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.directions_walk,
                            size: 80,
                          ),
                        ]
                        // child: Text(
                        //   "Goal Completion",
                        // ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                percent: (int.parse(_stepCountValue)/int.parse(_goal)>=1.0) ? 1.0 : int.parse(_stepCountValue)/int.parse(_goal),
                // percent: 0.5,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).accentColor,
                backgroundColor: Colors.black,
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 30,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$_stepCountValue/',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(_goal,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                  ),
                  Padding(padding: EdgeInsets.only(left: 2),),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        // Text('Edit',
                        //   style: TextStyle(fontSize: 7,color: Theme.of(context).accentColor,),
                        // ),
                        Icon(
                          Icons.add_circle,
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                        Padding(padding: EdgeInsets.only(top:20),)
                      ],
                    ),
                    onTap: () {
                      showDialog(context: context,
                        builder: (BuildContext context) {
                          return _showAlertDialog();
                        }
                      );
                    },
                  )
                ],)
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Text('steps'),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$_calories',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text('calories',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(right: 20),),
                  Container(color: Theme.of(context).accentColor,
                    height: 50,
                    width: 2,
                  ),
                  Padding(padding: EdgeInsets.only(right: 20),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$_distance',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text('km',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // RaisedButton(child: Text('Reset'),
            //   onPressed: (){
            //     _onReset();
            //   },
            // )
          ],
        ),
      ),
    ),
    onTap: () async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PedometerPage(
        stepCountMap: _stepCountMap,
        goal: _goal,)));
      },
    );
  }

  _showAlertDialog() {
    return AlertDialog(
      title: Text('Edit Goal Steps',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor
        ),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Goal Steps',
          ),
          controller: t,
          keyboardType: TextInputType.number,
          validator: (value){
            if(value.isEmpty) {
              return 'Please enter a number';
            }
            if(int.parse(value)==0){
              return 'Goal steps cannot be 0';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel",
            style: TextStyle(
              color: Colors.grey
            ),
          ),
          onPressed: (){
            // if(_formKey.currentState.validate()){
              setState(() {
                t.text = _goal;
              });
              Navigator.of(context).pop();
            // }
          },),
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            if(_formKey.currentState.validate()){
              setState(() {
                _goal = t.text;
              });
              print(_goal);
              Navigator.of(context).pop();
              }
          },
        )
      ],
    );
  }

}