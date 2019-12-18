import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class StepPage extends StatefulWidget {
  _StepPageState createState() => new _StepPageState();
}

//final List<TimelineModel>
//list = [
//  TimelineModel(
//      position: TimelinePosition.Center,
//      id: "1",
//      description: "Test 1",
//      title: "Test 1"),
//  TimelineModel(
//      id: "2",
//      description: "Test 2",
//      title: "Test 2")
//];


class _StepPageState extends State<StepPage> {
  //Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 22.0, bottom: 8.0),
            child: new Text("Administrative",
                style: new TextStyle(
                    color: new Color.fromARGB(255, 117, 117, 117),
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold)),
          ),
          new Divider(
            color: Colors.red,
          ),
          new Text("text")
        ],
      ),
    );
//    return new TimelineComponent(
//      timelineList: list,
////       lineColor: Colors.red[200], // Defaults to accent color if not provided
////       backgroundColor: Colors.black87, // Defaults to white if not provided
////       headingColor: Colors.black, // Defaults to black if not provided
////       descriptionColor: Colors.grey, // Defaults to grey if not provided
//    );
  }
}