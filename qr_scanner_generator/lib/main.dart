import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/pages/generator_page.dart';
import 'package:qr_scanner_generator/pages/scanner_page.dart';

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
      ),
      home: const LayoutNavigationBar(),
    );
  }
}

class LayoutNavigationBar extends StatefulWidget {
  const LayoutNavigationBar({super.key});

  @override
  State<LayoutNavigationBar> createState() => _LayoutNavigationBarState();
}

class _LayoutNavigationBarState extends State<LayoutNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [const ScannerPage(), const GeneratorPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner & Generator')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generator',
          ),
        ],
      ),
    );
  }
}
