class Notes {
  final String id;
  final String title;
  final String content;

  Notes({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content};
  }
}
