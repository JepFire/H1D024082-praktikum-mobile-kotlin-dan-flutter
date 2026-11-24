import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sidemenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? namauser;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    // Inisialisasi Shared Preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil username yang sudah tersimpan.
    final String? username = prefs.getString('username');

    // Set username pada UI.
    if (!mounted) return;
    setState(() {
      namauser = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Ini adalah halaman User ${namauser ?? ''}'),
      ),
      drawer: const Sidemenu(),
    );
  }
}