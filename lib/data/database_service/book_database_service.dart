import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/data/data_model/book_model.dart';


import '../../logic/locator.dart';



class BookDatabaseService {
  init() {}

  DateTime? getLocalDbLastModified() {
    if (Locator.hiveService.bookBox!.isEmpty) {
      return DateTime(2020);
    } else {
      print("checkpoint");
      List<BookModel> bookList =
          Locator.hiveService.bookBox!.values.toList();
      bookList.sort(((a, b) => a.lastModified!.compareTo(b.lastModified!)));
       print("Most recent book's lastModified: ${bookList.last.lastModified}");

      return bookList.last.lastModified;
    }
  }

  Future<DateTime> getRemoteDbLastModified() async {
    var querySnapshot = await Locator.firestoreService.bookColRef!
        .orderBy('lastModified', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('lastModified').toDate();
    } else {
      // throw Exception('No documents found in collection');
      return DateTime(2020);
    }
  }

  Future<void> fetchBooks(DateTime localLastModified) async {
    var querySnapshot = await Locator.firestoreService.bookColRef!
        .where('lastModified', isGreaterThan: localLastModified)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
     BookModel book = BookModel.fromJson( data, doc.id);
     
      await Locator.bookDatabaseService.createLocal(book);
    }
  }

 

   void streamRemoteToLocal(DateTime localLastModified) {
  var remoteStreamBook = Locator.firestoreService.bookColRef!
      .where('lastModified', isGreaterThan: localLastModified)
      .snapshots();
  remoteStreamBook.listen((snapshot) async {
    print("Received snapshot with ${snapshot.docChanges.length} changes.");
    for (var documentChange in snapshot.docChanges) {
      try {
        if (documentChange.type == DocumentChangeType.removed) {
          deleteLocal(documentChange.doc.id);
          // Handle the deletion here
        } else {
          Map<String, dynamic>? data = documentChange.doc.data() as Map<String, dynamic>?;
          if (data != null) {
            try {
              BookModel book = BookModel.fromJson(data, documentChange.doc.id);
              createLocal(book);
            } catch (e) {
              print("Error creating BookModel from document data: $e");
            }
          } else {
            print("Warning: Document data is null for document ID: ${documentChange.doc.id}");
          }
        }
      } catch (e) {
        print("Unhandled exception in streamRemoteToLocal: $e");
      }
    }
  });
}

  Future<void> updateRemote(BookModel bookModel) async {}

  Future<void> createRemote(String documentId, BookModel book) async {
  try {
    
    Map<String, dynamic> bookData = book.toJson();
    bookData['documentId'] = documentId; 
    book.lastModified = DateTime.now();

    await FirebaseFirestore.instance.collection('books').doc(documentId).set(bookData);
  } catch (e) {
    print("Error creating books remotely: $e");
    throw Exception("Failed to create remote book: $e"); // Rethrow with more context
  }
}


  createLocal(BookModel bookModel){
    Locator.hiveService.bookBox!.put(bookModel.documentId, bookModel);
    // return orderModel;
  }

  Future<List<BookModel>?> readBookFromLocal() async {
   var bookList = Locator.hiveService.bookBox?.values.toList();
    bookList?.forEach((element) {
      print(element.toJson());
    });
    return bookList;
  }

 

  

  deleteLocal(String documentId) {
    Locator.hiveService.bookBox!.delete(documentId);
  }

  Future<void> deletebook(BookModel book) async {
    try {
     
      await FirebaseFirestore.instance.collection('books').doc(book.documentId).delete();
      print('book deleted successfully from Firestore');
    } catch (error) {
      print('Error deleting book from Firestore: $error');
    }
  }
}