class Diary {
  final int id;
  final int userId;
  final String title;
  final String content;
  final DateTime pubTime;
  final String? imagePath;
  final String? videoPath;

  Diary(  {
    required this.userId,
    required this.title,
    required this.content,
    required this.pubTime,
    this.imagePath,
    this.videoPath, required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'content': content,
      'pub_time': pubTime.toString(),
      'image_path': imagePath,
      'video_path': videoPath,
    };
  }

  // Factory method to create Diary object from a map
  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      pubTime: DateTime.parse(map['pub_time']),
      imagePath: map['image_path'],
      videoPath: map['video_path'],
    );
  }

}
