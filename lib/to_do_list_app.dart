import 'package:flutter/material.dart';
import 'package:to_do_list/features/to_do_list_page/view/to_do_list_page_screen.dart';
import 'package:to_do_list/features/weather_page/view/weather_page_screen.dart';
import 'package:to_do_list/router/router.dart';
import 'package:to_do_list/theme/theme.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  static final List<Widget> _pages = <Widget>[
    const ToDoListPageScreen(),
    WeatherPageScreen(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To Do List',
        theme: theme,
        routes: routes,
        home: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: 'Weather',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 31, 31, 31),
            onTap: _onItemTapped,
          ),
        ));
  }
}
