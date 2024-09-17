import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/data_model/member_model.dart';
import '../locator.dart';
import 'package:uuid/uuid.dart';

class MemberManagementService {
  var memberQuery = ValueNotifier<String>("");
  var memberFilter = ValueNotifier<List<String>>([]);
  var memberList = ValueNotifier<List<MemberModel>>([]);
  var membersToDisplay = ValueNotifier<List<MemberModel>>([]);

  init() {
    streamMembers();
    memberQuery.addListener(setMemberToDisplay);
    memberList.addListener(setMemberToDisplay);
  }

  close() {}

  void setMemberToDisplay() {
    if (memberQuery.value.isNotEmpty) {
      var filteredList = memberList.value
          .where((element) => element.memberName!
              .toLowerCase()
              .contains(memberQuery.value.toLowerCase()))
          .toList();

      filteredList.sort(((a, b) =>
          a.memberName?.toLowerCase()!.compareTo(b.memberName!.toLowerCase()) ?? 0));

      membersToDisplay.value = filteredList;
    } else {
      memberList.value.sort(((a, b) => a.memberName!
          .toLowerCase()
          .compareTo(b.memberName!.toLowerCase())));
      membersToDisplay.value = memberList.value;
    }
  }

  Future<void> createMember(MemberModel member) async {
    var uuid = const Uuid();
    member.documentId = uuid.v4();

    Locator.memberDatabaseService.createLocal(member);

    await Locator.memberDatabaseService
        .createRemote(member.documentId!, member);
  }

  void deleteMember(MemberModel member) async {
    Locator.firestoreService.memberColRef.doc(member.documentId).delete();
    Locator.memberDatabaseService.deleteRemote(member,member.documentId);

    print('Member deleted successfully');
    await Locator.memberDatabaseService.deleteLocal(member.documentId!);
  }

  Future<void> updateMember(String documentId, MemberModel member) async {
    try {
      DocumentSnapshot snapshot =
          await Locator.firestoreService.memberColRef.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> memberMap = member.toJson();

        await Locator.firestoreService.memberColRef
            .doc(documentId)
            .update(memberMap);

        print('Member details updated successfully');
      } else {
        print('No member found with the provided document ID.');
      }
    } catch (e) {
      print('Failed to update member details: $e');
    }
  }

  streamMembers() {
    memberList.value = Locator.hiveService.memberBox!.values.toList();
    var memberStream = Locator.hiveService.memberBox!.watch();
    memberStream.listen((event) {
      memberList.value = Locator.hiveService.memberBox!.values.toList();
    });
    membersToDisplay.value = memberList.value;

    // setBrandList();
  }
}
