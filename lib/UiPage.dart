import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'list_view.dart';

class UiPage extends StatefulWidget {
  UiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UiPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 55, vertical: 30),
          child: Center(
            child: Column(
              children: [
                Container(
                    child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 200,
                      labelOffset: 30,
                      axisLineStyle: AxisLineStyle(
                          thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                      majorTickStyle: MajorTickStyle(
                          length: 6, thickness: 4, color: Colors.orange),
                      minorTickStyle: MinorTickStyle(
                          length: 3, thickness: 3, color: Colors.red),
                      axisLabelStyle: GaugeTextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))
                ])),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowUserList()));
                  },
                  child: Row(
                    children: [
                      Text(
                        "UserList",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffe35f21),
                        ),
                      ),
                      Icon(Icons.add, size: 15, color: Color(0xffe35f21))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
