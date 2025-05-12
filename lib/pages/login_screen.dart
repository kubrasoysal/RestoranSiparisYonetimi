import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Giriş Hatası"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giriş Yap"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "E-posta")),
            const SizedBox(height: 16),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Şifre")),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: login, child: const Text("Giriş Yap")),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
              child: const Text("Hesabınız yok mu? Kayıt olun", style: TextStyle(color: Colors.orange)),
            )
          ],
        ),
      ),
    );
  }
}
