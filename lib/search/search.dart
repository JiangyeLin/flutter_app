import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/line/line.dart';
import 'lineList.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';
import 'package:flutter_app/http/httputil.dart';

class SearchView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchViewState();
  }
}

class SearchViewState extends State<SearchView> {
  List<LineModelRtndt> list; //线路列表
  FocusNode _focusNode = new FocusNode();
  OverlayEntry overlayEntry;

  String linename = ""; //线路名
  bool hasLine = false; //检索结果 线路是否存在

  final _controller = TextEditingController();
  @override
  void initState() {
    _query();

    _controller.addListener(() {
      String text = _controller.text;
      if (text == null || text.isEmpty) {
        return;
      }
      RegExp exp = RegExp(r"^([bB1-9][0-9]*)$");
      bool matched = exp.hasMatch(text);
      if (!matched) {
        _controller.value = _controller.value.copyWith(
            text: text.substring(0, text.length - 1),
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream, offset: text.length - 1)));
      }
    });
    //textfield监听
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        //失去焦点时remove
        if (overlayEntry != null) {
          overlayEntry.remove();
          overlayEntry = null;
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 200,
              child: TextField(
                focusNode: _focusNode,
                onChanged: (string) {
                  linename = string;
                  if (string.isEmpty) {
                    hasLine = false;
                    return;
                  }
                  List<LineModelRtndt> array = list
                      .where((item) => item.linename.startsWith(string))
                      .toList();
                  if (array == null || array.length == 0) {
                    hasLine = false;
                    return;
                  }
                  if (overlayEntry != null) {
                    overlayEntry.remove();
                  }
                  overlayEntry = createOverlayEntry(array);
                  Overlay.of(context).insert(overlayEntry);
                },
                controller: _controller,
              ),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("查询"),
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: AllLinesView(list),
        ),
      ],
    );
  }

  ///查询全部线路
  _query() async {
    LineModelEntity result = await HttpUtil.queryAllLines();
    print("查询全部线路${result}");
    setState(() {
      list = result.rtndt;
    });
  }
}

OverlayEntry createOverlayEntry(List<LineModelRtndt> array) {
  return OverlayEntry(builder: (BuildContext context) {
    return Positioned(
      width: 200,
      height: 160,
      top: 200,
      left: 60,
      child: Container(
        alignment: Alignment.topLeft,
        color: Colors.grey[300],
        child: ListView.separated(
          padding: const EdgeInsets.all(0), //去掉默认padding
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Line(array[index]);
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  array[index].linename,
                  style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
          itemCount: array.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
            );
          },
        ),
      ),
    );
  });
}
