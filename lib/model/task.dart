class Task {
  static const String collectionName = 'tasks';
  String? title;
  String? description;
  String? id;
  DateTime? taskDate;
  bool? isDone;

  Task({
    required this.title,
    required this.description,
    this.id = '',
    required this.taskDate,
    this.isDone = false,
  });
  // to json
  Map<String, dynamic> toFireStore() {
    return {
      'title': title,
      'description': description,
      'id': id,
      'taskDate': taskDate?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

  //from json
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String?,
          title: data['title'] as String?,
          description: data['description'] as String?,
          taskDate: DateTime.fromMillisecondsSinceEpoch(data['taskDate']),
          isDone: data['isDone'] as bool?,
        );
}
