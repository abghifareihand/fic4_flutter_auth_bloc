import 'dart:convert';

class ProfileResponeModel {
    int? id;
    String? email;
    String? password;
    String? name;
    String? role;
    String? avatar;
    DateTime? creationAt;
    DateTime? updatedAt;

    ProfileResponeModel({
        this.id,
        this.email,
        this.password,
        this.name,
        this.role,
        this.avatar,
        this.creationAt,
        this.updatedAt,
    });

    factory ProfileResponeModel.fromJson(String str) => ProfileResponeModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProfileResponeModel.fromMap(Map<String, dynamic> json) => ProfileResponeModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}