class LineModelEntity {
	List<LineModelRtndt> rtndt;
	String rtnmsg;

	LineModelEntity({this.rtndt, this.rtnmsg});

	LineModelEntity.fromJson(Map<String, dynamic> json) {
		if (json['rtndt'] != null) {
			rtndt = new List<LineModelRtndt>();(json['rtndt'] as List).forEach((v) { rtndt.add(new LineModelRtndt.fromJson(v)); });
		}
		rtnmsg = json['rtnmsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.rtndt != null) {
      data['rtndt'] =  this.rtndt.map((v) => v.toJson()).toList();
    }
		data['rtnmsg'] = this.rtnmsg;
		return data;
	}
}

class LineModelRtndt {
	String downend;
	String uptime2;
	String uptime1;
	String downstart;
	String linever;
	String upstart;
	String upend;
	int lineid;
	String downtime1;
	String downtime2;
	String lineno1;
	String linename;
	String lineremark;

	LineModelRtndt({this.downend, this.uptime2, this.uptime1, this.downstart, this.linever, this.upstart, this.upend, this.lineid, this.downtime1, this.downtime2, this.lineno1, this.linename, this.lineremark});

	LineModelRtndt.fromJson(Map<String, dynamic> json) {
		downend = json['downend'];
		uptime2 = json['uptime2'];
		uptime1 = json['uptime1'];
		downstart = json['downstart'];
		linever = json['linever'];
		upstart = json['upstart'];
		upend = json['upend'];
		lineid = json['lineid'];
		downtime1 = json['downtime1'];
		downtime2 = json['downtime2'];
		lineno1 = json['lineno1'];
		linename = json['linename'];
		lineremark = json['lineremark'];
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
		data['lineid'] = this.lineid;
		data['downtime1'] = this.downtime1;
		data['downtime2'] = this.downtime2;
		data['lineno1'] = this.lineno1;
		data['linename'] = this.linename;
		data['lineremark'] = this.lineremark;
		return data;
	}
}
