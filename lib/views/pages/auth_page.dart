import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import '../../utilities/enums.dart';
import '../widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;

    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Error!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            e.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(builder: (_, model, __) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 32.0,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 64.0),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      onChanged: model.updateEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter your email' : null,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter your password' : null,
                      obscureText: true,
                      onChanged: model.updatePassword,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    if (model.authFormType == AuthFormType.login)
                      const Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          child: Text(
                            'Forget your password ?',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    MainButton(
                      text: model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submit(model);
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text(model.authFormType == AuthFormType.login
                            ? 'Don\'t have an account ? Register'
                            : 'Have an account login'),
                        onTap: () {
                          _formKey.currentState!.reset();
                          model.toggleFormType();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.authFormType == AuthFormType.login
                              ? 'or login with '
                              : 'or Register with',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 89,
                          width: 89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.mail),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          height: 89,
                          width: 89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.facebook),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
