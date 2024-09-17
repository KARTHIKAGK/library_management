import 'package:flutter/material.dart';
import 'package:library_management/ui/member_page/create_member.dart';
import 'package:library_management/ui/member_page/member_display.dart';

import 'package:watch_it/watch_it.dart';

import '../../logic/locator.dart';

class MemberPage extends StatelessWidget with WatchItMixin {
  const MemberPage({super.key});
  static TextEditingController searchController = TextEditingController();

  void _showPopup(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CreateMember();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/cozy-bookstore.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton(
                    onPressed: () {
                      _showPopup(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 230, 11, 11),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Create Member',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        Locator.memberManagementService.memberQuery.value =
                            value;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                            Locator.memberManagementService.memberQuery.value =
                                "";
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Search',
                        labelStyle: const TextStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(flex: 4, child: MemberDisplay()),
          ],
        ),
      ),
    );
  }
}
