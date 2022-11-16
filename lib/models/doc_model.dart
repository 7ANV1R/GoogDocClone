import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DocModel {
  final String id;
  final String uid;
  final String title;
  final List content;
  final DateTime createdAt;
  DocModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(
      id: map['_id'] as String,
      uid: map['uid'] as String,
      title: map['title'] as String,
      content: List.from((map['content'] as List)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocModel.fromJson(String source) => DocModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
