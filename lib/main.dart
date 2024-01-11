import 'package:flutter/material.dart';
import 'package:sister/matkul/matkul.dart';
import 'package:sister/mhs/mahasiswa.dart';
import 'package:sister/nilai/nilai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person),
  ];

  final screen = [const MahasiswaList(), const MatkulList(), const NilaiList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Mahasiswa "),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.my_library_books,
              ),
              label: "Matkul "),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_numbered_outlined,
              ),
              label: "Nilai "),
        ],
      ),
    );
  }
}
