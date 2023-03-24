import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/screens/screens.dart';
import 'package:rokave_productos/services/services.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: authService.readToken(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) return const Text('Espere');
                  if (snapshot.data == '') return LoginScreen();
                  return HomeScreen();
                })));
  }
}
