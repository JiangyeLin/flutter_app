import 'package:flutter/material.dart';
import 'package:flutter_app/model/line_model_entity.dart';

class Line extends StatelessWidget {
  Line(LineModelRtndt bean) {
    print("线路查询 ${bean.linename}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("线路查询")),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
