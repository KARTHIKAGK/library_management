import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/book_model.dart';
import 'package:uuid/uuid.dart';



import '../locator.dart';

class BookManagementService {
  var bookQuery = ValueNotifier<String>("");
  var bookFilter = ValueNotifier<List<String>>([]);
  var bookList = ValueNotifier<List<BookModel>>([]);
  var booksToDisplay = ValueNotifier<List<BookModel>>([]);

  @override
  init() {
    streamBooks();
    bookQuery.addListener(setBookToDisplay);
    bookList.addListener(setBookToDisplay);
  }

  close() {}

void setBookToDisplay() {
    if (bookQuery.value.isNotEmpty) {
      var filteredList = bookList.value
          .where((element) => element.bookName!
              .toLowerCase()
              .contains(bookQuery.value.toLowerCase()))
          .toList();

      filteredList.sort(((a, b) =>
          a.bookName?.toLowerCase()!.compareTo(b.bookName!.toLowerCase()) ?? 0));

      booksToDisplay.value = filteredList;
    } else {
      bookList.value.sort(((a, b) => a.bookName!
          .toLowerCase()
          .compareTo(b.bookName!.toLowerCase())));
      booksToDisplay.value = bookList.value;
    }
  
  }

  Future<void> createBook(BookModel book) async {
    var uuid = const Uuid();
    book.documentId = uuid.v4();

    
    Locator.bookDatabaseService.createLocal(book);
    await Locator.bookDatabaseService.createRemote(book.documentId!, book);
  }

   void deleteBook(BookModel book) async {
    Locator.firestoreService.bookColRef.doc(book.documentId).delete();

    print('book deleted successfully');
    await Locator.bookDatabaseService.deleteLocal(book.documentId!);
  }

Future<void> updateBook(String documentId, BookModel book) async {
    try {
      DocumentSnapshot snapshot =
          await Locator.firestoreService.bookColRef.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> bookMap = book.toJson();

        await Locator.firestoreService.bookColRef
            .doc(documentId)
            .update(bookMap);

        print('Book details updated successfully');
      } else {
        print('No book found with the provided document ID.');
      }
    } catch (e) {
      print('Failed to update book details: $e');
    }
  }
  streamBooks() {
    bookList.value = Locator.hiveService.bookBox!.values.toList();
    var bookStream = Locator.hiveService.bookBox!.watch();
    bookStream.listen((event) {
      bookList.value = Locator.hiveService.bookBox!.values.toList();
    });
    booksToDisplay.value = bookList.value;
  }
}
