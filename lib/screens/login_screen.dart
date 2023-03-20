import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/providers/login_form_provider.dart';
import 'package:rokave_productos/widgets/widgets.dart';
import 'package:rokave_productos/ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 200),
        CardContainer(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Text('login', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 30),
            ChangeNotifierProvider(
                create: (_) => LoginFormProvider(), child: _LoginForm())
          ],
        )),
        const SizedBox(height: 50),
        const Text('Crear una nueva cuenta'),
        const SizedBox(height: 50),
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => loginForm.email = value,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'edwinhenriquezh@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icons.alternate_email_sharp),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El email no es correcto';
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                onChanged: (value) => loginForm.password = value,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock_clock_sharp),
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'la contraseña debe ser de al menos 6 carácteres';
                },
              ),
              const SizedBox(height: 20),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          await Future.delayed(const Duration(seconds: 3));
                          loginForm.isLoading = false;
                          Navigator.pushReplacementNamed(context, 'home');
                        },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: Text(
                          loginForm.isLoading ? 'Esperar....' : 'Ingresar',
                          style: const TextStyle(color: Colors.white))))
            ],
          )),
    );
  }
}
