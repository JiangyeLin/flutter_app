import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/line/line.dart';
import 'package:flutter_app/model/line_model_entity.dart';

class LineList extends StatefulWidget {
  List<LineModelRtndt> list;

  LineList(List<LineModelRtndt> bean) {
    list = bean;
    if (list != null) {
      print("数量${list.length}");
    } else {
      print("null");
    }
  }

  @override
  _LineListState createState() {
    return _LineListState(list);
  }
}

class _LineListState extends State<LineList> {
  List<LineModelRtndt> _list;

  _LineListState(List<LineModelRtndt> list) {
    this._list = list;
    if (_list != null) {
      print("哈哈哈${_list.length}");
    }
  }

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildItem(_list[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
        itemCount: _list == null ? 0 : _list.length);
  }

  _query() async {
    Dio dio = new Dio();
    Response response = await dio
        .post(
            "http://gj.wzsjy.com/ajax/app_ajax.aspx?action=getallline&module=jywebbean&t=usFictaHWuU%3D")
        // ignore: missing_return
        .then((response) {
      Map userMap = json.decode(response.data);
      var result = LineModelEntity.fromJson(userMap);
      setState(() {
        _list = result.rtndt;
      });
    });
  }

  ///list item
  Widget _buildItem(LineModelRtndt bean) {
    return InkWell(
      onTap: () {
        print("点击事件" + bean.linename);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Line(bean);
        }));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Text(
              bean.linename + bean.lineremark,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("开往"),
                      Text(
                        bean.upstart,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("开往"),
                      Text(
                        bean.upend,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
