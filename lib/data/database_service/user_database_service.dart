import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_management/data/data_model/user_model.dart';
import 'package:library_management/logic/locator.dart';


class UserDatabaseService {

  Future<void> getUserData(User user) async {
    UserModel userData = await readUserFromRemote(user);
    await createUserInLocal(userData);
  }



  Future<UserModel> readUserFromRemote(User user) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    UserModel userModel = UserModel.fromJson(data: data, user: user);
    return userModel;
  }

  Future<void> createUserInLocal(UserModel userModel) async {
    if (Locator.hiveService.userBox!.isNotEmpty) {
      await deleteUserFromLocal();
    }
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  Future<UserModel?> readUserFromLocal() async {
    var user = Locator.hiveService.userBox?.getAt(0);
    return user;
  }

  Future<void> updateUserInLocal(UserModel userModel) async {
    await Locator.hiveService.userBox?.put(userModel.uid, userModel);
  }

  deleteUserFromLocal() async {
    await Locator.hiveService.userBox?.clear();
  }
}
