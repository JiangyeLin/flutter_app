import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';

const base_url = "http://gj.wzsjy.com/ajax/app_ajax.aspx";

//接口通用参数
const teamStr = "usFictaHWuU=";
const module = "jywebbean";

///查询所有线路列表
Future queryAllLines() async {
  Dio dio = new Dio();
  dio.post(base_url, queryParameters: {
    "action": "getallline",
    "module": module,
    "t": teamStr
  }).then((response) {
    print("response$response");
    Map userMap = json.decode(response.data);
    var result = LineModelEntity.fromJson(userMap);

    return result;
  });
}

/// 线路查询
Future queryLine(var lineId) async {
  Dio dio = new Dio();
  dio.post(base_url, data: {
    "action": "getline",
    "module": module,
    "t": teamStr,
    "lineid": lineId
  }).then((onValue) {
    print("线路查询$lineId: $onValue");
  });
}

/// 线路停站状态查询
Future queryLineStatus() async {}

/// 根据站点名称查询经停线路
Future queryLineByStation(String stationName) async {
  Dio dio = new Dio();
  dio.get(base_url, queryParameters: {
    "action": "getlinebystation",
    "module": module,
    "t": teamStr,
    "stname": stationName
  }).then((onValue) {
    print("response$onValue");
  });
}
