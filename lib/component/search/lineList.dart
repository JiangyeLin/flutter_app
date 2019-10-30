import 'package:flutter/material.dart';
import 'package:flutter_app/component/line/line.dart';
import 'package:flutter_app/model/lineall_model_entity.dart';

///线路列表 Widget
class LineListWidget extends StatelessWidget {
  List<LineModelRtndt> _list;

  LineListWidget(this._list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildItem(_list[index], context);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
        itemCount: _list == null ? 0 : _list.length);
  }

  ///list item
  Widget _buildItem(LineModelRtndt bean, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Line(bean);
        }));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            //线路名
            Text(
              bean.linename,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            //线路始末站
            Positioned(
                child: Container(
              margin: EdgeInsets.only(left: 150),
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
            ))
          ],
        ),
      ),
    );
  }
}
