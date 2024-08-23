import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? name;
  String? email;
  bool? emailVerified;
  String? phoneNumber;
  String? userType;
  String? address;

  UserModel({
    this.name,
    this.email,
    this.emailVerified,
    this.phoneNumber,
    this.userType,
    this.address,
  });

  factory UserModel.fromJson({required Map<String, dynamic> data, required User user})
  {
    return UserModel(
      name: user.displayName,
      email:user.email,
      emailVerified: user.emailVerified,
      phoneNumber: user.phoneNumber,
      userType: (data["userType"] is String) ? data["userType"] :"",
      address: (data["address"] is String) ? data["address"] :"" );
  }

  Map<String, dynamic> toJson(){
    return {
      'fullName':name,
      'email':email,
      'phoneNumber' :phoneNumber,
      'address' :address,
    };
  }
}