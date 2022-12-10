import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/persentations/account/screens/account_screen.dart';
import 'package:terator/persentations/home/screens/home_screen.dart';
import 'package:terator/persentations/my_files/screens/my_file_screen.dart';
import 'package:terator/persentations/settings/screens/setting_screen.dart';

class Navbar extends StatefulWidget {
  final int? selectedIndex;
  const Navbar({super.key, this.selectedIndex});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyFileScreen(),
    AccountScreen(),
  ];

  final List<Widget> _titleOptions = <Widget>[
    // const Text(
    //   '🏡 Terator',
    //   style: TextStyle(color: bDark),
    // ),
    Image.asset(
      'assets/img/terator_logo.png',
      height: 45,
    ),
    const Text(
      '📂 File Saya',
      style: TextStyle(color: bDark),
    ),
    const Text(
      '👦 Akun Surat',
      style: TextStyle(color: bDark),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _titleOptions.elementAt(_selectedIndex),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return const SettingScreen();
                }));
              },
              icon: const Icon(Icons.settings, color: bSecondary))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.other_houses_outlined),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.schedule),
            ),
            label: 'File Saya',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.contact_page_outlined),
            ),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: bInfo,
        onTap: _onItemTapped,
      ),
    );
  }
}
