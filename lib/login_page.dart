import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _saveUsername() async {
    // Inisialisasi Shared Preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Simpan username ke local storage.
    await prefs.setString('username', _usernameController.text);
  }

  Widget _showInput(
      TextEditingController namaController,
      String placeholder,
      bool isPassword,
      ) {
    return TextField(
      controller: namaController,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }

  Future<void> _showDialog(String pesan, Widget alamat) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Tutup dialog terlebih dahulu.
                Navigator.of(dialogContext).pop();

                // Pindah ke halaman tujuan.
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (context) => alamat,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showInput(
              _usernameController,
              'Masukkan Username',
              false,
            ),
            _showInput(
              _passwordController,
              'Masukkan Password',
              true,
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                if (_usernameController.text == 'admin' &&
                    _passwordController.text == 'admin') {
                  // Simpan username sebelum membuka halaman Home.
                  await _saveUsername();
                  if (!mounted) return;

                  // Tampilkan pesan berhasil login.
                  await _showDialog(
                    'Anda Berhasil Login',
                    const HomePage(),
                  );
                } else {
                  // Tampilkan pesan jika username atau password salah.
                  await _showDialog(
                    'Username dan Password Salah',
                    const LoginPage(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}