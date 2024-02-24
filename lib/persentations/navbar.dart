import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  DateTime preBackpress = DateTime.now();
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyFileScreen(),
    AccountScreen(),
    SettingScreen(),
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
    const Text(
      '⚙ Pengaturan',
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
    return PopScope(
      onPopInvoked: (value) async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          Fluttertoast.showToast(msg: 'Tekan tombol kembali lagi untuk keluar');
          return;
        }
      },
      child: Scaffold(
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
                icon: const Icon(Icons.help_outline, color: bSecondary))
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 75,
          // padding: const EdgeInsets.symmetric(vertical: 10),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            iconSize: 28,
            // unselectedLabelStyle: TextStyle(color: Colors.black),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Icon(Icons.dashboard_outlined),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Icon(Icons.schedule),
                ),
                label: 'File Saya',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Icon(Icons.contact_page_outlined),
                ),
                label: 'Akun',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Icon(Icons.settings_outlined),
                ),
                label: 'Pengaturan',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: bInfo,
            unselectedItemColor: Colors.grey.shade900,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
