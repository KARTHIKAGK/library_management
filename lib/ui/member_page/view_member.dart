// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/member_model.dart';

import '../../logic/locator.dart';

class ViewMember extends StatefulWidget {
  final MemberModel member;

  const ViewMember({Key? key, required this.member}) : super(key: key);

  @override
  ViewMemberState createState() => ViewMemberState();
}

class ViewMemberState extends State<ViewMember> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  

  final _formKey = GlobalKey<FormState>();
  String _selectedGender = ''; // Selected gender
  bool _showGenderError = false;
  @override
  void initState() {
    super.initState();
  userNameController.text = widget.member.memberName ?? '';
    phoneNumberController.text = widget.member.phoneNumber ?? '';
    addressController.text = widget.member.address ?? '';
    passwordController.text = widget.member.emailAddress ?? '';
    emailAddressController.text = widget.member.emailAddress ?? '';
    _selectedGender = widget.member.gender ?? ''; 
  
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      MemberModel updatedMember = MemberModel(
        documentId: widget.member.documentId,
        memberName: userNameController.text,
        emailAddress: emailAddressController.text,
        gender: _selectedGender, // Update with selected gender
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        lastModified: DateTime.now(),
        
      );

      await Locator.memberManagementService
          .updateMember(widget.member.documentId!, updatedMember);
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
                'MEMBER DETAILS',
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
              'PERSONAL INFORMATION',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
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
                    decoration: InputDecoration(
                      labelText: 'Member Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailAddressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                        value: _selectedGender.isEmpty ? null : _selectedGender,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        dropdownColor: Color.fromARGB(255, 244, 191, 88),
                        items: <String>['Male', 'Female', 'Others']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Gender',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _showGenderError = true;
                            });
                            return 'Please select a gender';
                          }
                          setState(() {
                            _showGenderError = false;
                          });
                          return null;
                        },
                      ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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