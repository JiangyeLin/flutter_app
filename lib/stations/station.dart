import 'package:flutter/material.dart';
import 'package:flutter_app/http/httputil.dart';

class Station extends StatefulWidget {
  String stationName;
  Station(String stationName, {Key key}) : super(key: key);

  _StationState createState() => _StationState(stationName);
}

class _StationState extends State<Station> {
  String _stationName;
  _StationState(this._stationName);

  @override
  void initState() {
    super.initState();
    HttpUtil.queryLineByStation(_stationName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("站点查询"),),
      body: Container(
        child: Text("站点查询"),
      ),
    );
  }
}
