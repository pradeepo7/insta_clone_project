import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/search_page.dart';
import 'pages/feed_page.dart';
import 'utilities/circle_container_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff3732b0),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _title = "feed";
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    Text(
      'Community',
      style: optionStyle,
    ),
    Text(
      'Videos',
      style: optionStyle,
    ),
    Text(
      'Notification',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Feed';
          }
          break;
        case 1:
          {
            _title = 'Community';
          }
          break;
        case 2:
          {
            _title = 'Videos';
          }
          break;
        case 3:
          {
            _title = 'Notification';
          }
          break;
        case 4:
          {
            _title = 'Profile';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Color(0xff3732b0),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.perspective), label: '',),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_3), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.videocam), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text(_title,
                style: TextStyle(
                color: Color(0xff3732b0),
                fontSize: 28,
                fontWeight: FontWeight.bold)),

        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        actions: [
          circle_container_icon(
            Icon(
              CupertinoIcons.search,
              color: Colors.black87,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
          ),
          SizedBox(width: 10),
          circle_container_icon(Icon(
                 CupertinoIcons.mail_solid,
                 color: Colors.black87,)),
          SizedBox(width: 10)
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
