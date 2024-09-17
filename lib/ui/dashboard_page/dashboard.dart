import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget{
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(
            // color: Color.fromARGB(250, 31, 33, 39),
            ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
                height: 1000), // Adding extra space to demonstrate scrolling
          ],
        ),
      ),
    );
  }
}
