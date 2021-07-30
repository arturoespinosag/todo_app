class Task {
  int id;
  DateTime date;
  String title;
  bool isDone;
  String description;

  Task({
    required this.id,
    required this.date,
    required this.title,
    required this.isDone,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "date": date.toString(),
        "title": title,
        "isDone": isDone ? 1 : 0,
        "description": description
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        title: json["title"],
        isDone: (json["isDone"]) == 1 ? true : false,
        description: json["description"],
      );
}
