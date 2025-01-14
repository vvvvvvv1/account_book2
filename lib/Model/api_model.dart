class ApiModel {
  //final String title;

  //ApiModel.fromJson(Map<String, dynamic> json) : title = json['title'];

  final int id;
  final String date;
  final String dayOfWeek;
  final String category;
  final String description;
  final String time;
  final String bank;
  final int income;
  final int expense;
  final String fulldate;

  ApiModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        dayOfWeek = json['dayOfWeek'],
        category = json['category'],
        description = json['description'],
        time = json['time'],
        bank = json['bank'],
        income = json['income'],
        expense = json['expense'],
        fulldate = json['fulldate'];
}
