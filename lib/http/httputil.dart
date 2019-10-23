import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/model/line_status_entity.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';
import 'package:flutter_app/model/lineinfo_entity.dart';

//服务器地址
const base_url = "http://gj.wzsjy.com/ajax/app_ajax.aspx";

//接口通用参数
const teamStr = "usFictaHWuU=";
const module = "jywebbean";

class HttpUtil {
  ///查询所有线路列表
  static queryAllLines() async {
    Dio dio = new Dio();
    Response response = await dio.post(base_url, queryParameters: {
      "action": "getallline",
      "module": module,
      "t": teamStr
    });

    print("response$response");
    Map userMap = json.decode(response.data);
    return LineModelEntity.fromJson(userMap).rtndt;
  }

  /// 线路查询
  static queryLine(int lineId) async {
    print("开始查询$lineId");
    Dio dio = new Dio();
    Response response = await dio.post(base_url, queryParameters: {
      "action": "getline",
      "module": module,
      "t": teamStr,
      "lineid": lineId
    });
    //
    print("response$response");
    Map map = json.decode(response.data);
    return LineinfoEntity.fromJson(map);
  }

  /// 线路停站状态查询
  static queryLineStatus(var lineno) async {
    Dio dio = new Dio();
    Response response = await dio.post(base_url, queryParameters: {
      "action": "showStatus",
      "module": module,
      "t": teamStr,
      "l": lineno
    });
    print("停站信息$response");
    Map map = json.decode(response.data);
    var result = LineStatusModel.fromJson(map);
    return result.buses;
  }

  /// 根据站点名称查询经停线路
  static queryLineByStation(String stationName) async {
    Dio dio = new Dio();
    dio.get(base_url, queryParameters: {
      "action": "getlinebystation",
      "module": module,
      "t": teamStr,
      "stname": stationName
    }).then((onValue) {
      print("站点查询$onValue");
      Map map = json.decode(onValue.data);
      return LineModelEntity.fromJson(map).rtndt;
    });
  }
}
