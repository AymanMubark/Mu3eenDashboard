class SocailEventsReport {
  int? total;
  List<TypesCount>? typesCount;

  SocailEventsReport({this.total, this.typesCount});

  SocailEventsReport.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['typesCount'] != null) {
      typesCount = <TypesCount>[];
      json['typesCount'].forEach((v) {
        typesCount!.add(TypesCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    if (typesCount != null) {
      data['typesCount'] = typesCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypesCount {
  String? name;
  int? count;

  TypesCount({this.name, this.count});

  TypesCount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}
