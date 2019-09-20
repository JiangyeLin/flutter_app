class LineStatusModel {
  List<Bus> buses;
  String rtnmsg;

  LineStatusModel({this.buses, this.rtnmsg});
  //解析 json
  LineStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['rtndt'] != null) {
      buses = new List<Bus>();

      var list = json["rtndt"][0];
      (list["bus"] as List).forEach((f) {
        buses.add(new Bus.fromJson(f));
      });
    }

    rtnmsg = json['rtnmsg'];
  }
}

class Bus {
  String fx; //运行方向
  String zd; //当前站点
  String zt; //是否正在停站
  String dist; //大概是距离???

  Bus({this.fx, this.zd, this.zt, this.dist});

  Bus.fromJson(Map<String, dynamic> json) {
    fx = json["fx"];
    zd = json["zd"];
    zt = json["zt"];
    dist = json["dist"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fx'] = this.fx;
    data['zd'] = this.zd;
    data['zt'] = this.zt;
    data['dist'] = this.dist;
    return data;
  }
}
