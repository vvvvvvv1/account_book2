class ApiModel {
  final String title, thumb, id;

  ApiModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
