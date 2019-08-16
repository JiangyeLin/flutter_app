import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'lineList.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';

class SearchView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchViewState();
  }
}

class SearchViewState extends State<SearchView> {
  List<LineModelRtndt> list;

  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 200,
              child: TextField(),
            ),
            RaisedButton(
              onPressed: null,
              child: Text("点击"),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(child: LineListView((list)))
      ],
    );
  }

  ///查询线路
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
        list = result.rtndt;
      });
    });
  }
}
