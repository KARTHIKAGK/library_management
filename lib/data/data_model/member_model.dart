import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'member_model.g.dart';

@HiveType(typeId: 1)
class MemberModel {
  @HiveField(0)
  String? documentId;

  @HiveField(1)
  String? memberName;


  @HiveField(2)
  String? emailAddress;


  @HiveField(3)
  String? phoneNumber;

  @HiveField(4)
  String? address;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  DateTime? lastModified;

 

  MemberModel({
    this.documentId,
    this.memberName,
    this.emailAddress,
    this.phoneNumber,
    this.address,
    this.gender,
    this.lastModified,

  });

  factory MemberModel.fromJson(
      {required Map<String, dynamic> json, required String documentId}) {
    return MemberModel(
     documentId:documentId,
      memberName: (json['memberName'] is String) ? json['memberName'] : '',
      emailAddress:
          (json['emailAddress'] is String) ? json['emailAddress'] : '',
      phoneNumber: (json['phoneNumber'] is String) ? json['phoneNumber'] : '',
      address: (json['address'] is String) ? json['address'] : '',
      gender: (json['gender'] is String) ? json['gender'] : '',
      lastModified: (json['lastModified'] is Timestamp)
          ? json['lastModified'].toDate()
          : DateTime.now(),
   
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'memberName': memberName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
      'lastModified':
          lastModified != null ? Timestamp.fromDate(lastModified!) : null,
      };
  }

  factory MemberModel.fromOrderJson({required Map<String, dynamic> json}) {
    return MemberModel(
      documentId: (json["documentID"] is String) ? json["documentID"] : "",
      memberName: (json['memberName'] is String) ? json['memberName'] : '',
      emailAddress:
          (json['emailAddress'] is String) ? json['emailAddress'] : '',
      phoneNumber: (json['phoneNumber'] is String) ? json['phoneNumber'] : '',
      address: (json['address'] is String) ? json['address'] : '',
      gender: (json['gender'] is String) ? json['gender'] : '',
    );
  }

  Map<String, dynamic> toOrderJson() {
    return {
      'documentId': documentId,
      'memberName': memberName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'address': address,
      'gender': gender,
    };
   }
}
