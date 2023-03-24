// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/screens/home_screen.dart';
import 'package:rokave_productos/screens/login_screen.dart';
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
                  
                  if (!snapshot.hasData) return const Text('Espere.....');

                  Future.microtask(() {
                    if (snapshot.data == 'no-token' || snapshot.data == null) {
                      //print(snapshot.data);
                      //print('EL BDC');
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => LoginScreen(),
                              transitionDuration: const Duration(seconds: 1)));
                      //Navigator.of(context).pushReplacementNamed('login');
                    } else {
                      //print(snapshot.data);
                      //print('OKI OKI');
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => HomeScreen(),
                              transitionDuration: const Duration(seconds: 1)));
                    }
                  });

                  return Container();
                })));
  }
}
