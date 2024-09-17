import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference userColRef =
      FirebaseFirestore.instance.collection('users');
  CollectionReference memberColRef =
      FirebaseFirestore.instance.collection('members');
  CollectionReference bookColRef =
      FirebaseFirestore.instance.collection('books');
// CollectionReference trashColRef =
//       FirebaseFirestore.instance.collection('trash');
  init() async {}
}
