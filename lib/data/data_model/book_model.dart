import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'book_model.g.dart';

@HiveType(typeId: 3)
class BookModel {
  @HiveField(0)
  String? documentId;

  @HiveField(1)
  String? bookName;

  @HiveField(2)
  String? authorName;

  @HiveField(3)
  String? category;

  @HiveField(4)
  String? quantity;

  @HiveField(5)
  String? description;

  @HiveField(6)
  DateTime? lastModified;


  BookModel({
    this.documentId,
    this.bookName,
    this.authorName,
    this.category,
    this.quantity,
    this.description,

    this.lastModified,
    
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String documentId) {
    return BookModel(
      documentId: documentId,
      bookName: (json['bookName'] is String) ? json['bookName'] : '',
      authorName: (json['authorName'] is String) ? json['authorName'] : '',
      category: (json['category'] is String) ? json['category'] : '',
      quantity: (json['quantity'] is String) ? json['quantity'] : '',
      description: (json['description'] is String)
          ? json['description']
          : '',
      lastModified: (json['lastModified'] is Timestamp)
          ? json['lastModified'].toDate()
          : DateTime.utc(1990),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'bookName': bookName,
      'authorName': authorName,
      'category': category,
      'quantity': quantity,
      'description': description,
  
      'lastModified':
          lastModified != null ? Timestamp.fromDate(lastModified!) : null,
   
    };
  }
}
