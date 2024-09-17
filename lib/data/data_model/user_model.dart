import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? uid;
  @HiveField(3)
  String? userType;
  @HiveField(4)
  String? name;




  UserModel({
    this.email,
    this.phoneNumber,
    this.uid,
    this.userType,
    this.name,
    });

  factory UserModel.fromJson({required Map<String, dynamic> data, required User user}) {
    try{
      return UserModel(
        email: user.email,
        phoneNumber: user.phoneNumber,
        uid: user.uid,
        userType: (data["userType"] is String) ? data["userType"] : "",
        name: (data["name"] is String) ? data["name"] : "",
     
      );
    }catch(error){
      if (kDebugMode) {
        print(error);
      }
      throw FormatException('Invalid JSON: $data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'name': name,
      'phoneNumbers': phoneNumber,
     };
  }
}