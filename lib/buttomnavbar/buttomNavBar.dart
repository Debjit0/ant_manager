
import 'package:flutter/material.dart';

import '../demopages/page2.dart';
import '../demopages/page3.dart';
import '../homepage/homepage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const [
          HomePage(),
          Page2(),
          Page3(),
        ][selectedPageIndex],
        bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.list_alt),
              icon: Icon(Icons.list_alt_outlined),
              label: 'Influencers',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.list),
              icon: Icon(Icons.list_outlined),
              label: 'More',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: 'Account',
            ),
          ],
        ),
      
    );
  }
}