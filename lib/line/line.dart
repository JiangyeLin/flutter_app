import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/line_status_entity.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/model/lineinfo_entity.dart';

///线路详情
class Line extends StatefulWidget {
  LineModelRtndt bean;

  Line(LineModelRtndt bean) {
    this.bean = bean;
  }

  @override
  _LineState createState() {
    return _LineState(bean);
  }
}

///状态管理
class _LineState extends State<Line> {
  final LineModelRtndt bean;
  Timer timer;
  bool direction = false; //营运方向 true上行  false下行

  LineinfoEntity lineinfoEntity;
  List<Bus> buses = [];

  _LineState(this.bean);

  @override
  void initState() {
    queryLine(bean.lineid);

    timer = new Timer.periodic(Duration(seconds: 10), callback);
    super.initState();
  }

  void callback(Timer timer) {
    queryStatus(bean.lineno1);
  }

  @override
  void dispose() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (lineinfoEntity == null) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("线路查询"),
      ),
      body: Column(
        children: <Widget>[
          ///线路信息部分
          Container(
            child: Column(
              children: <Widget>[
                Text(bean.linename),
                Text(direction
                    ? bean.upstart + "  ——>  " + bean.upend
                    : bean.downstart + "  ——>  " + bean.downend),
                Text(direction
                    ? "营运时间：${bean.uptime1}——${bean.uptime2}"
                    : "营运时间：${bean.downtime1}——${bean.downtime2}"),
              ],
            ),
          ),

          ///线路图部分
          Expanded(
              child:
                  StationsList(lineinfoEntity.rtnstationdt, direction, buses)),
          Row(
            children: <Widget>[
              SizedBox(
                width: 24,
              ),
              Image.asset("images/bus.png"),
              Text(" 开往"),
              SizedBox(
                width: 40,
              ),
              Image.asset("images/busin.png"),
              Text(" 到站"),
              SizedBox(
                width: 40,
              ),
              RaisedButton(
                child: Text("换向"),
                onPressed: () {
                  setState(() {
                    direction = !direction;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  ///查询线路站点信息
  Future queryLine(int lineId) async {
    print("开始查询$lineId");
    Dio dio = new Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志
    await dio.post(base_url, queryParameters: {
      "action": "getline",
      "module": "jywebbean",
      "t": "usFictaHWuU=",
      "lineid": lineId
    }).then((response) {
      Map map = json.decode(response.data);
      var result = LineinfoEntity.fromJson(map);

      setState(() {
        lineinfoEntity = result;
      });
    });
  }

  ///查询停站信息
  Future queryStatus(var lineno) async {
    Dio dio = new Dio();
    dio.post(base_url, queryParameters: {
      "action": "showStatus",
      "module": "jywebbean",
      "t": "usFictaHWuU=",
      "l": lineno
    }).then((response) {
      Map map = json.decode(response.data);
      var result = LineStatusModel.fromJson(map);

      setState(() {
        buses = result.buses;
      });
    });
  }
}

///线路列表
class StationsList extends StatelessWidget {
  List<LineinfoRtnstationdt> stations;
  bool direction;
  List<Bus> buses;

  StationsList(
      List<LineinfoRtnstationdt> list, bool direction, List<Bus> buses) {
    if (list == null) {
      return;
    }
    //根据上下行方向筛选列表
    stations = list.where((item) => direction == (item.updown == 0)).toList();
    this.buses = buses;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
            color: index % 2 == 0 ? Colors.white : Colors.black12,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("提示"),
                        content: Text.rich(TextSpan(children: [
                          TextSpan(text: "请问你是否要跳转至 "),
                          TextSpan(
                            text: stations[index].stationname,
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(text: " 站")
                        ])),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("确定"),
                            onPressed: () {
                              print("站点跳转");
                            },
                          )
                        ],
                      );
                    });
              },
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 16)),
                  NumberText(index, index == stations.length - 1),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    stations[index].stationname,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Container(
                        alignment: Alignment.center,
                        child: StopStatusWidget(
                            stations[index].updown, stations[index].sno, buses),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
      itemCount: stations == null ? 0 : stations.length,
    );
  }
}

///车辆信息
class StopStatusWidget extends StatelessWidget {
  int fx;
  int sno;
  List<Bus> buses;

  StopStatusWidget(this.fx, this.sno, this.buses);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    buses.forEach((element) {
      if (element.fx == this.fx.toString()) {
        if (element.zd == sno.toString()) {
          widgets.add(Container(
            width: 25,
            height: 25,
            child: Image.asset("images/bus.png"),
          ));
        }
      }
    });
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets,
      ),
    );
  }
}

///站点序号 widget
class NumberText extends StatelessWidget {
  final int _index;
  final bool _isLast;

  const NumberText(this._index, this._isLast);

  @override
  Widget build(BuildContext context) {
    String label;
    if (0 == _index) {
      label = "起";
    } else if (_isLast) {
      label = "终";
    } else {
      label = _index.toString();
    }

    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      margin: EdgeInsets.all(8),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
