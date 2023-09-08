import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldensmoker/auth/weather.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
      getPages: [
        GetPage(name: "/", page: () => HomePage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthModel auth = Get.put(AuthModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Text(auth.errorMassege),
        const SizedBox(height: 5),
        const Text('Username'),
        const SizedBox(height: 5),
        TextField(controller: auth.loginControl.value),
        const SizedBox(height: 20),
        const Text('Password'),
        const SizedBox(height: 5),
        TextField(controller: auth.passwordControl.value, obscureText: true),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(onPressed: auth.canStartAuth == true ? () => auth.auth(context) : null, child: auth.canStartAuth == true ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Login')),
            const SizedBox(width: 5),
            ElevatedButton(onPressed: (){}, child: const Text('Rest password')),
            const SizedBox(width: 5),
            ElevatedButton(onPressed: (){}, child: const Text('Register')),
        ],)

      ],)),
    );
  }
}
