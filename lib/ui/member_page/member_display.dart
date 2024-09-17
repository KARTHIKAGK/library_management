import 'package:flutter/material.dart';
import 'package:library_management/logic/database_management_service/member_management_service.dart';
import 'package:library_management/ui/member_page/member_tile.dart';
import 'package:watch_it/watch_it.dart';



class MemberDisplay extends StatelessWidget with WatchItMixin {
  const MemberDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var memberListToDisplay =
        watchValue((MemberManagementService x) => x.membersToDisplay);
    return SizedBox(
        width: screenWidth,
        child: ListView.builder(
          
          itemCount: memberListToDisplay.length,
          itemBuilder: (context, index) => MemberTile(
            member: memberListToDisplay[index],
          ),
        ));
  }
}