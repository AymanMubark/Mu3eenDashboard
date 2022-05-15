class AdminCountsReport {
  int? volunteers;
  int? institutions;
  int? rewards;

  AdminCountsReport({this.volunteers, this.institutions, this.rewards});

  AdminCountsReport.fromJson(Map<String, dynamic> json) {
    volunteers = json['volunteers'];
    institutions = json['institutions'];
    rewards = json['rewards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['volunteers'] = volunteers;
    data['institutions'] = institutions;
    data['rewards'] = rewards;
    return data;
  }
}
