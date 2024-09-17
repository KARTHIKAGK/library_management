import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/user_model.dart';
import 'package:library_management/logic/locator.dart';


class UserManagementService {
  final userData = ValueNotifier<UserModel?>(null);

  final invalidUser = ValueNotifier<bool>(false);
  final isLibrarian = ValueNotifier<bool>(true);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    Locator.hiveService.userBox?.watch().listen((event) {
      userData.value = event.value;
      if (event.deleted) {
        userData.value = null;
      }
    });
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
//         DocumentSnapshot doc = await FirebaseFirestore.instance
//    .collection('users')
//    .doc(user.uid)
//    .get();
// print("Received document data: ${doc.data()}"); // Log the entire document data
        try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
         .collection('users')
         .doc(user?.uid ?? 'default_uid')
         .get();
      print("Received document data: ${doc.data()}");
    

Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
print("User type: ${data['userType']}"); // Log just the userType
if (data != null && data.containsKey('userType')) {
    String userType = data['userType'];
if (data['userType']!= "Librarian") {
  user = null;
  isLibrarian.value = false;
} else {
  isLibrarian.value = true;
}}
else {
    print("User data is missing or incomplete");
    // Handle the case where user data is not available
  }
} 
catch (e) {
      print("Failed to get document: $e");
    }
      }
      Locator.navigationService.isLoadingNotifier.value = true;
      if (user != null) {
        if (userData.value != null) {
          if (user.uid != userData.value!.uid) {
            await Locator.userDatabaseService.deleteUserFromLocal();
            
          }
        }
        if (Locator.hiveService.userBox!.isEmpty) {
          await Locator.userDatabaseService.getUserData(user);
          
          await Locator.startupService.setupApplicationData();
        }
      } else {
        
        signOut();
        
      }
      Locator.navigationService.isLoadingNotifier.value = false;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      Locator.navigationService.isLoadingNotifier.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      invalidUser.value = !invalidUser.value;
      Locator.navigationService.isLoadingNotifier.value = false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await Locator.hiveService.clearAllBox();
  }
}
