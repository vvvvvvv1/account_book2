class ApiModel {
  final String title;

  ApiModel.fromJson(Map<String, dynamic> json) : title = json['title'];
}
