import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_management/data/data_model/book_model.dart';


import '../../logic/locator.dart';

class CreateBooks extends StatefulWidget {
  const CreateBooks({super.key});

  @override
  State<CreateBooks> createState() => _CreateBooksState();
}

class _CreateBooksState extends State<CreateBooks> {
   final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  bool _showGenderError = false;

  bool isNotNumeric(String? value) {
    if (value == null) {
      return true;
    }
    try {
      double.parse(value);
      return false; // It's a valid number
    } catch (e) {
      return true; // It's not a valid number
    }
  }

  void addBook() {
    final bookName = bookNameController.text;
    final authorName = authorNameController.text;
    final category = categoryController.text;
    //  final password = passwordController.text;
    final quantity = quantityController.text;
    final description = descriptionController.text;

 

    BookModel book = BookModel(
      documentId: '',
      bookName: bookName,
      authorName: authorName,
      category: category,
      // password: password,
      quantity: quantity,
      description: description,
      lastModified: DateTime.now(),
    );

    // Placeholder for adding the customer to a service or database
    Locator.bookManagementService.createBook(book);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        content: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Books Details',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Book Name',
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Author Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: 'Select Category',
                          border: const OutlineInputBorder(),
                          errorText: _showGenderError
                              ? 'Select Category'
                              : null,
                        ),
                        dropdownColor: Color.fromARGB(255, 244, 88, 88),
                        items: ['Scientific', 'Fictional', 'Adventures','Self growth','Others'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                            categoryController.text = newValue ?? '';
                            _showGenderError = false;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select a Category';
                          }
                          return null;
                        },
                      ),
                    ],
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
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    // ],
                    inputFormatters: [
  FilteringTextInputFormatter.allow(RegExp(r'^\d+$')),
],
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Description ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addBook();
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'ADD',
                          style: const TextStyle(color: Color(0xFFF4BF58)),
                        ), // This is the child of the ElevatedButton
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ]),
        )));
  }
}
