class Task {
  int? id;
  String? name;
  String? description;
  DateTime? date;
  String? priority;
  int? status;

  Task({this.name, this.description, this.date, this.priority, this.status});

  Task.withId(
      {this.id,
      this.name,
      this.date,
      this.description,
      this.priority,
      this.status});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    map['date'] = date!.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;

    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      priority: map['priority'],
      status: map['status'],
    );
  }
}
