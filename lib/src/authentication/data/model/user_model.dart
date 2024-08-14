import 'dart:convert';

import 'package:novel/core/utils/typedef.dart';
import 'package:novel/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.createdAt,
      required super.avatar});
  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
        );
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel copyWith(
      {String? id, String? name, String? avatar, String? createdAt}) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        avatar: avatar ?? this.avatar);
  }

  DataMap toMap()=>{
    "id":id,
    "name":name,
    "avatar":avatar,
    "createdAt":createdAt
  };

  String toJson()=>jsonEncode(toMap());

  const UserModel.empty():this(avatar: "avatar",name: "name",createdAt: "createdAt",id: "1");
}
