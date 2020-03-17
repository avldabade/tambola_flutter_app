class HomeCellVO {
  int id;
  String title;
  String icon;

  HomeCellVO({this.id, this.title, this.icon});

  factory HomeCellVO.fromJson(Map<String, dynamic> json) {
    return HomeCellVO(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: json['icon'] as String,
    );
  }
}