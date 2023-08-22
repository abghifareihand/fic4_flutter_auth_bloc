import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
// 	"name": "Abghi",
// 	"email": "abghi@gmail.com",
// 	"password": "abghi123",
//     "avatar": "https://api.lorem.space/image/face?w=640&h=480"
// }


class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String avatar;
  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = 'https://img.freepik.com/vector-gratis/avatar-personaje-empresario-aislado_24877-60111.jpg?w=2000',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory RegisterModel.fromJson(String source) => RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
