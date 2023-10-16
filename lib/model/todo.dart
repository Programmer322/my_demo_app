class Todo {
  final int id;
  final int userId;
  String content;
  final DateTime pubTime;
  String status='pending';
  setStatus(String val){
    status=val;
  }
  Todo({
    required this.userId,
    required this.content,
    required this.pubTime,
     required this.id,
    this.status='pending'
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'content': content,
      'pub_time': pubTime.toString(),
      'status':status
    };
  }

  // Factory method to create Diary object from a map
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      userId: map['user_id'],
      content: map['content'],
      pubTime: DateTime.parse(map['pub_time']),
      status: map['status']
    );
  }

}
