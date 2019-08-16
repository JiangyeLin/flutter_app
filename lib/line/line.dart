import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/model/lineinfo_entity.dart';

class Line extends StatefulWidget {
  LineModelRtndt bean;

  Line(LineModelRtndt bean) {
    this.bean = bean;
    print("线路查询 ${bean.linename}");
  }

  @override
  _LineState createState() {
    return _LineState(bean.lineid);
  }
}

class _LineState extends State<Line> {
  final int lineId;

  List<LineinfoRtnstationdt> list = [];

  LineinfoEntity lineinfoEntity;

  _LineState(this.lineId);

  @override
  void initState() {
    queryLine(lineId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线路查询"),
      ),
      body: Column(
        children: <Widget>[
          ///线路信息部分
          Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text(lineinfoEntity.rtndt[0].linename),
                Text(lineinfoEntity.rtndt[0].upstart +
                    " 开往 " +
                    lineinfoEntity.rtndt[0].upend),
                Text(
                    "始发：${lineinfoEntity.rtndt[0].uptime1}——${lineinfoEntity.rtndt[0].downtime1}"),
                Text(
                    "末班：${lineinfoEntity.rtndt[0].uptime2}——${lineinfoEntity.rtndt[0].downtime2}")
              ],
            ),
          ),

          ///线路图部分
          Container()
        ],
      ),
    );
  }

  ///查询线路信息
  Future queryLine(int lineId) async {
    Dio dio = new Dio();
    await dio
        .post(
            "http://gj.wzsjy.com/ajax/app_ajax.aspx?action=getline&module=jywebbean&t=usFictaHWuU%3D&lineid=" +
                lineId.toString())
        .then((response) {
      print(response.data);
      Map map = json.decode(response.data);
      var result = LineinfoEntity.fromJson(map);

      setState(() {
        lineinfoEntity = result;
        list = result.rtnstationdt;
      });
    });

    /*await dio.post(base_url, data: {
    "action": "getline",
    "module": "jywebbean",
    "t": "usFictaHWuU%3D",
    "lineid": 219,
  }).then((response) {
    print("response " + response.toString());
    Map map = json.decode(response.data);
    var result = LineinfoEntity.fromJson(map);
  });*/
  }
}
