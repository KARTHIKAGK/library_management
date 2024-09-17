import 'package:flutter/material.dart';
import 'package:library_management/ui/book_page/book_page.dart';
import 'package:library_management/ui/member_page/member_page%20.dart';
import 'package:library_management/ui/dashboard_page/dashboard.dart';

import 'package:watch_it/watch_it.dart';

import '../../logic/app_management_service/navigation_service.dart';
import '../../logic/locator.dart';


class HomePage extends StatelessWidget with WatchItMixin {
  HomePage({super.key});

  static final PageController _pageController = PageController(
      initialPage: Locator.navigationService.currentPageIndex.value);

  void _onPageChanged(int index) {
    Locator.navigationService.setCurrentPageIndex(index);
  }

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int currentPageIndex =
        watchValue((NavigationService x) => x.currentPageIndex);

    Color selectedTextColor = Theme.of(context).colorScheme.onPrimaryContainer;
    Color dividerColor = Theme.of(context).colorScheme.onSecondaryContainer;

    Color bgColor = Theme.of(context).colorScheme.primary;
    Color textColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      
      body: Row(
        children: [
          Container(
              
            width: 250, // Adjust the width as needed
            decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 11, 11),
            ),
            child: ListView(
            
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 140),
                  child: Text('AdminTools',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        // color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.dashboard,
                      color: currentPageIndex == 0
                          ? selectedTextColor
                          : textColor),
                  title: Text(
                    'Members',
                    style: TextStyle(
                        fontSize: currentPageIndex == 0 ? 18 : 15,
                        fontWeight: currentPageIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: currentPageIndex == 0
                            ? selectedTextColor
                            : textColor),
                  ),
                  selected: currentPageIndex == 0,
                  onTap: () {
                    _pageController.jumpToPage(0);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.man_3_rounded,
                      color: currentPageIndex == 1
                          ? selectedTextColor
                          : textColor),
                  title: Text(
                    'Books',
                    style: TextStyle(
                        fontSize: currentPageIndex == 1 ? 18 : 15,
                        fontWeight: currentPageIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: currentPageIndex == 1
                            ? selectedTextColor
                            : textColor),
                  ),
                  selected: currentPageIndex == 1,
                  onTap: () {
                    _pageController.jumpToPage(1);
                  },
                ),
                

                ListTile(
                  leading: Icon(Icons.logout,
                      color: currentPageIndex == 2
                          ? selectedTextColor
                          : textColor),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: currentPageIndex == 2 ? 18 : 15,
                        fontWeight: currentPageIndex == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: currentPageIndex == 6
                            ? selectedTextColor
                            : textColor),
                  ),
                  selected: currentPageIndex == 6,
                  onTap: () {
                    Locator.userManagementService.signOut();
                  },
                ),
                // Add more Home bar items here
              ],
            ),
          ),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                MemberPage(),
                BookPage(),
                // FabricPage(),
                // OrderPage(),
                // SettingsPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
