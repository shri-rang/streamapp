class ActiveSubscription {
  String status;
  String packageTitle;
  String expireData;

  ActiveSubscription(
      {required this.status,
      required this.packageTitle,
      required this.expireData});

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) {
    return ActiveSubscription(
        status: json['status'],
        packageTitle: json['package_title'],
        expireData: json['expire_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['package_title'] = this.packageTitle;
    data['expire_date'] = this.packageTitle;
    return data;
  }
}
