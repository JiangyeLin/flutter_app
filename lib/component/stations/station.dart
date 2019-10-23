import 'package:flutter/material.dart';
import 'package:flutter_app/http/httputil.dart';

///站点查询页面
class Station extends StatefulWidget {
  String stationName;

  Station(String stationName, {Key key}) : super(key: key) {
    this.stationName = stationName;
  }

  _StationState createState() => _StationState(stationName);
}

class _StationState extends State<Station> {
  String _stationName;
  _StationState(this._stationName);

  @override
  void initState() {
    super.initState();
    var bean = HttpUtil.queryLineByStation(_stationName);
    print(bean.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("站点查询"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Column(
            children: <Widget>[
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: _stationName,
                    style: TextStyle(color: Colors.blue, fontSize: 18)),
                TextSpan(text: " 站经停线路：")
              ])),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ));
  }
}
