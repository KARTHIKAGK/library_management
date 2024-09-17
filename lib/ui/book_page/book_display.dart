
import 'package:flutter/material.dart';
import 'package:library_management/logic/database_management_service/book_management_service.dart';
import 'package:library_management/ui/book_page/book_tile.dart';
import 'package:watch_it/watch_it.dart';




class BookDisplay extends StatelessWidget with WatchItMixin {
  const BookDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var bookListToDisplay =
        watchValue((BookManagementService x) => x.booksToDisplay);
    return SizedBox(
        width: screenWidth,
        child: ListView.builder(
          
          itemCount: bookListToDisplay.length,
          itemBuilder: (context, index) => BookTile(
            book: bookListToDisplay[index],
          ),
        ));
  }
}