import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management/data/data_model/member_model.dart';
import 'package:library_management/logic/locator.dart';


class MemberDatabaseService {
  init() {}

  DateTime? getLocalDbLastModified() {
    if (Locator.hiveService.memberBox!.isEmpty) {
      return DateTime(2020);
    } else {
      List<MemberModel> memberList =
          Locator.hiveService.memberBox!.values.toList();
      memberList.sort(((a, b) => a.lastModified!.compareTo(b.lastModified!)));
      return memberList.last.lastModified;
    }
  }

  Future<DateTime> getRemoteDbLastModified() async {
    var querySnapshot = await Locator.firestoreService.memberColRef!
        .orderBy('lastModified', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('lastModified').toDate();
    } else {
      // throw Exception('No documents found in collection');
      return DateTime(2020);
    }
  }

  Future<void> fetchMembers(DateTime localLastModified) async {
    var querySnapshot = await Locator.firestoreService.memberColRef!
        .where('lastModified', isGreaterThan: localLastModified)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      MemberModel member =
          MemberModel.fromJson(json: data, documentId: doc.id);

      await Locator.memberDatabaseService.createLocal(member);
    }
  }

  void streamRemoteToLocal(DateTime localLastModified) {
    var remoteStreamMember = Locator.firestoreService.memberColRef!
        .where('lastModified', isGreaterThan: localLastModified)
        .snapshots();
    remoteStreamMember.listen((snapshot) async {
      print("Received snapshot with ${snapshot.docChanges.length} changes.");
      for (var documentChange in snapshot.docChanges) {
        try {
          if (documentChange.type == DocumentChangeType.removed) {
            deleteLocal(documentChange.doc.id);
            // Handle the deletion here
          } else {
            Map<String, dynamic>? data =
                documentChange.doc.data() as Map<String, dynamic>?;
            if (data != null) {
              try {
                MemberModel member = MemberModel.fromJson(
                  json: data,
                  documentId: documentChange.doc.id,
                );
                createLocal(member);
              } catch (e) {
                print("Error creating memberModel from document data: $e");
              }
            } else {
              print(
                  "Warning: Document data is null for document ID: ${documentChange.doc.id}");
            }
          }
        } catch (e) {
          print("Unhandled exception in streamRemoteToLocal: $e");
        }
      }
    });
  }

  Future<void> createRemote(String documentId, MemberModel member) async {
    try {
      Map<String, dynamic> memberData = member.toJson();
      await FirebaseFirestore.instance
          .collection('members')
          .doc(documentId)
          .set(memberData);
    } catch (e) {
      print("Error creating member remotely: $e");
      throw Exception(
          "Failed to create remote member: $e"); // Rethrow with more context
    }
  }

  Future<List<MemberModel>> readAllRemote() async {
    return [];
  }

  Future<void> updateRemote(MemberModel memberModel) async {}
  Future<void> deleteRemote(MemberModel memberModel,String? documentId) async {
 try {
      Map<String, dynamic> memberData = memberModel.toJson();
      await FirebaseFirestore.instance
          .collection('trash')
          .doc(documentId)
          .set(memberData);
    } catch (e) {
      print("Error: $e");
      throw Exception(
          "Failed : $e"); // Rethrow with more context
    }

  }

  createLocal(MemberModel memberModel) {
    Locator.hiveService.memberBox!
        .put(memberModel.documentId, memberModel);
        
  }

  Future<List<MemberModel>> readAllLocal() async {
    return [];
  }

  Future<void> updateMemberInLocal(MemberModel member) async {
    var memberBox = Locator.hiveService.memberBox;
    if (memberBox != null && memberBox.length > 0) {
      await memberBox.putAt(0, member);
    }
  }

  deleteLocal(String documentId) {
    Locator.hiveService.memberBox!.delete(documentId);
  }
}
