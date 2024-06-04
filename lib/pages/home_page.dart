import 'package:cte_admin/pages/login_page.dart';
import 'package:cte_admin/pages/nav_pages/account_settings_page.dart';
import 'package:cte_admin/pages/nav_pages/booking_page.dart';
import 'package:cte_admin/pages/nav_pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();

  // nav
  int _selectedIndex = 0;
  // nav function
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //
  // pages to display
  final List<Widget> _pages = [
    // home
    const HomenavPage(),

    // booking page
    const BookingPage(),
    // account settings
    const AccountSettingsPage(),
  ];

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cooth The Explorer"),
        content: const Text("Are you sure you want to Logout?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("No"),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _auth.signout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "CTE ADMIN",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          CupertinoIcons.person_circle,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: showDialogBox,
            icon: const Icon(
              CupertinoIcons.clear_circled_solid,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade500,
          elevation: 0,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: (index) {
            // Respond to item press.
            navigateBottomBar(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_list),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Account',
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
