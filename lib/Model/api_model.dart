class ApiModel {
  //final String title;

  //ApiModel.fromJson(Map<String, dynamic> json) : title = json['title'];

  final String date;
  final String dayOfWeek;
  final String category;
  final String description;
  final String time;
  final String bank;
  final int income;
  final int expense;

  ApiModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        dayOfWeek = json['dayOfWeek'],
        category = json['category'],
        description = json['description'],
        time = json['time'],
        bank = json['bank'],
        income = json['income'],
        expense = json['expense'];
}
