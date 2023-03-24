import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/providers/login_form_provider.dart';
import 'package:rokave_productos/services/services.dart';
import 'package:rokave_productos/widgets/widgets.dart';
import 'package:rokave_productos/ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
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
            Text('Crear Cuenta',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 30),
            ChangeNotifierProvider(
                create: (_) => LoginFormProvider(), child: _LoginForm())
          ],
        )),
        const SizedBox(height: 50),
        TextButton(
            style: ButtonStyle(
                shape: const MaterialStatePropertyAll(StadiumBorder()),
                overlayColor:
                    MaterialStatePropertyAll(Colors.indigo.withOpacity(0.3))),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            child: const Text('¿ Ya tienes una cuenta ?',
                style: TextStyle(color: Colors.black87))),
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
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          loginForm.isLoading = true;
                          final String? errorMessage = await authService
                              .createUser(loginForm.email, loginForm.password);
                          //await Future.delayed(const Duration(seconds: 3));

                          if (errorMessage == null) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            // ignore: todo
                            //  TODO Mostrar error en pantalla
                          }
                          loginForm.isLoading = false;
                        },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: Text(loginForm.isLoading ? 'Esperar....' : 'Crear',
                          style: const TextStyle(color: Colors.white))))
            ],
          )),
    );
  }
}
