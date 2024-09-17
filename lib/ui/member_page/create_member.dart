import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_management/data/data_model/member_model.dart';

import '../../logic/locator.dart';

class CreateMember extends StatefulWidget {
  const CreateMember({super.key});

  @override
  State<CreateMember> createState() => _CreateMemberState();
}

class _CreateMemberState extends State<CreateMember> {
   final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedGender;
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

  void addOrder() {
    final userName = userNameController.text;
    final emailAddress = emailAddressController.text;
    final phoneNumber = phoneNumberController.text;
    //  final password = passwordController.text;
    final address = addressController.text;
    final gender = genderController.text;

 

    MemberModel order = MemberModel(
      documentId: '',
      memberName: userName,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      // password: password,
      address: address,
      gender: gender,
      lastModified: DateTime.now(),
    );

    // Placeholder for adding the customer to a service or database
    Locator.memberManagementService.createMember(order);
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
                'Member INFORMATION',
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
                    controller: userNameController,
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
                      labelText: 'Member Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailAddressController,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          (!value.contains('@') || !value.contains('.'))) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'emailAddress',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressController,
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
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          labelText: 'Select Gender',
                          border: const OutlineInputBorder(),
                          errorText: _showGenderError
                              ? 'Please select a gender'
                              : null,
                        ),
                        dropdownColor: Color.fromARGB(255, 244, 88, 88),
                        items: ['Male', 'Female', 'Others'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue;
                            genderController.text = newValue ?? '';
                            _showGenderError = false;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      } else if (value.length != 10) {
                        return 'Please enter exactly 10 digits';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          10), // Limit the input length to 10 digits
                    ],
                    keyboardType: TextInputType
                        .phone, // This sets the keyboard type to phone
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addOrder();
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
