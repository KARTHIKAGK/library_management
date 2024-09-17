import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/book_model.dart';
import 'package:library_management/ui/book_page/view_book.dart';

import '../../logic/locator.dart';

class BookTile extends StatelessWidget {
  const BookTile({Key? key, required this.book}) : super(key: key);
  final BookModel book;

  void _showPopup(BuildContext context, book) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ViewBook(book: book);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Color.fromARGB(255, 180, 51, 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        book.bookName ?? 'Name: Unknown',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.authorName ?? 'Name: Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.category ?? 'Category: Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.quantity ?? 'quantity: Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons
                  //       .download), // Changed to a visibility icon to indicate view action
                  //   onPressed: () async {
                  //     await PdfGenerator.generatePdf(order);
                  //   },
                  //   color: Color.fromARGB(255, 4, 241,
                  //       4), // Changed color to indicate it's a view action
                  // ),
                  IconButton(
                    icon: const Icon(Icons
                        .visibility), // Changed to a visibility icon to indicate view action
                    onPressed: () {
                      _showPopup(context, book);
                    },
                    color: Colors.blueAccent// Changed color to indicate it's a view action
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      bool? confirmDelete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Book'),
                            content: const Text(
                                'Are you sure you want to delete this bookr? This action cannot be undone.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Cancel deletion
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(true); // Confirm deletion
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmDelete == true) {
                        Locator.bookManagementService.deleteBook(book);
                        // TrashModel trashModel =
                        //     TrashModel(deletedDocumentID: order.documentId);
                        // Locator.trashManagemenrService.createTrash(trashModel);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Deleted Successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    color:  Color.fromARGB(255, 244, 27, 27),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
