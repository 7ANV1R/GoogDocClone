import 'dart:convert';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.token,
    required this.uid,
  });
  final String name;
  final String email;
  final String profilePic;
  final String token;
  final String uid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'token': token,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      token: map['token'] as String,
      uid: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? token,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }
}
