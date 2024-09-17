// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:library_management/data/data_model/member_model.dart';
import 'package:library_management/ui/member_page/view_member.dart';

import '../../logic/locator.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({Key? key, required this.member}) : super(key: key);
  final MemberModel member;

  void _showPopup(BuildContext context, member) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ViewMember(member: member);
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
              tileColor:Color.fromARGB(255, 180, 51, 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        member.memberName ?? 'Name: Unknown',
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
                          member.phoneNumber ?? 'PhoneNo: Unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${member.address ?? 'Address: Unknown'}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      _showPopup(context, member);
                    },
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      bool? confirmDelete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Member'),
                            content: const Text(
                                'Are you sure you want to delete this member? This action cannot be undone.'),
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
                        Locator.memberManagementService
                            .deleteMember(member);
                        // TrashModel trashModel =
                        //     TrashModel(deletedDocumentID: zomer.documentId);
                        // Locator.trashManagemenrService.createTrash(trashModel);
                        print('member');

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
