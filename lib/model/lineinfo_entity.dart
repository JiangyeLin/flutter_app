class LineinfoEntity {
  List<LineinfoRtndt> rtndt;
  List<LineinfoRtnstationdt> rtnstationdt;
  String rtnmsg;

  LineinfoEntity({this.rtndt, this.rtnstationdt, this.rtnmsg});

  LineinfoEntity.fromJson(Map<String, dynamic> json) {
    if (json['rtndt'] != null) {
      rtndt = new List<LineinfoRtndt>();
      (json['rtndt'] as List).forEach((v) {
        rtndt.add(new LineinfoRtndt.fromJson(v));
      });
    }
    if (json['rtnstationdt'] != null) {
      rtnstationdt = new List<LineinfoRtnstationdt>();
      (json['rtnstationdt'] as List).forEach((v) {
        rtnstationdt.add(new LineinfoRtnstationdt.fromJson(v));
      });
    }
    rtnmsg = json['rtnmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rtndt != null) {
      data['rtndt'] = this.rtndt.map((v) => v.toJson()).toList();
    }
    if (this.rtnstationdt != null) {
      data['rtnstationdt'] = this.rtnstationdt.map((v) => v.toJson()).toList();
    }
    data['rtnmsg'] = this.rtnmsg;
    return data;
  }
}

class LineinfoRtndt {
  String downend;
  String uptime2;
  String uptime1;
  String downstart;
  String linever;
  String upstart;
  String upend;
  String lineno1;
  int lineid;
  String linename;
  String downtime1;
  String downtime2;

  LineinfoRtndt(
      {this.downend,
      this.uptime2,
      this.uptime1,
      this.downstart,
      this.linever,
      this.upstart,
      this.upend,
      this.lineno1,
      this.lineid,
      this.linename,
      this.downtime1,
      this.downtime2});

  LineinfoRtndt.fromJson(Map<String, dynamic> json) {
    downend = json['downend'];
    uptime2 = json['uptime2'];
    uptime1 = json['uptime1'];
    downstart = json['downstart'];
    linever = json['linever'];
    upstart = json['upstart'];
    upend = json['upend'];
    lineno1 = json['lineno1'];
    lineid = json['lineid'];
    linename = json['linename'];
    downtime1 = json['downtime1'];
    downtime2 = json['downtime2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['downend'] = this.downend;
    data['uptime2'] = this.uptime2;
    data['uptime1'] = this.uptime1;
    data['downstart'] = this.downstart;
    data['linever'] = this.linever;
    data['upstart'] = this.upstart;
    data['upend'] = this.upend;
    data['lineno1'] = this.lineno1;
    data['lineid'] = this.lineid;
    data['linename'] = this.linename;
    data['downtime1'] = this.downtime1;
    data['downtime2'] = this.downtime2;
    return data;
  }
}

class LineinfoRtnstationdt {
  int sno;
  String stationname;
  int updown;

  LineinfoRtnstationdt({this.sno, this.stationname, this.updown});

  LineinfoRtnstationdt.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    stationname = json['stationname'];
    updown = json['updown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['stationname'] = this.stationname;
    data['updown'] = this.updown;
    return data;
  }
}
