// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/book_model.dart';
import 'package:library_management/data/data_model/member_model.dart';

import '../../logic/locator.dart';

class ViewBook extends StatefulWidget {
  final BookModel book;

  const ViewBook({Key? key, required this.book}) : super(key: key);

  @override
  ViewBookState createState() => ViewBookState();
}

class ViewBookState extends State<ViewBook> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
 
  
  

  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = ''; // Selected gender
  bool _showGenderError = false;
  @override
  void initState() {
    super.initState();
  bookNameController.text = widget.book.bookName ?? '';
    authorNameController.text = widget.book.authorName ?? '';
    quantityController.text = widget.book.quantity ?? '';
    descriptionController.text = widget.book.description ?? '';
    _selectedCategory = widget.book.category ?? ''; 
  
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      BookModel updatedBook = BookModel(
        documentId: widget.book.documentId,
        bookName: bookNameController.text,
        authorName: authorNameController.text,
        category: _selectedCategory, // Update with selected gender
        quantity: quantityController.text,
        description: descriptionController.text,
        lastModified: DateTime.now(),
        
      );

      await Locator.bookManagementService
          .updateBook(widget.book.documentId!, updatedBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        content: SingleChildScrollView(
            child: SizedBox(
          width: 900,
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'BOOK DETAILS',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
            const SizedBox(height: 20),
            const Text(
              'BOOK INFORMATION',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: bookNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'BOOK Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: authorNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Author Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                        value: _selectedCategory.isEmpty ? null : _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                        dropdownColor: Color.fromARGB(255, 244, 191, 88),
                        items: <String>['Scientific', 'Fictional', 'Adventures','Self growth','Others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _showGenderError = true;
                            });
                            return 'select a category';
                          }
                          setState(() {
                            _showGenderError = false;
                          });
                          return null;
                        },
                      ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: quantityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Descriptionr',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  
                  
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _submitForm();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Updated Successfully'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Update',
                            style: const TextStyle(
                                color: Color(
                                    0xFFF4BF58))), // This is the child of the ElevatedButton
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ]),
        )));
  }
}