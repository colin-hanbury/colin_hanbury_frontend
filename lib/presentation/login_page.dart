import 'package:colin_hanbury_frontend/bloc/auth/auth_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/auth/auth_event.dart';
import 'package:colin_hanbury_frontend/bloc/auth/auth_state.dart';
import 'package:colin_hanbury_frontend/utils/routes.dart';
import 'package:colin_hanbury_frontend/utils/univeral_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          'Login',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _pageLayout(),
        ),
      ),
    );
  }

  Widget _pageLayout() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      switch (state.status) {
        case AuthStatus.unauthenticated:
          return _loginForm();
        case AuthStatus.authenticated:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.chat,
              (route) => false,
            );
          });
          return const SizedBox();
        case AuthStatus.error:
          return Stack(
            children: [
              _loginForm(),
              _showAlert(state.error),
            ],
          );
        case AuthStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          return _loginForm();
      }
    });
  }

  Widget _showAlert(String error) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: Text(error),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
    return const SizedBox();
  }

  Widget _loginForm() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'myemail@example.com',
                ),
                controller: emailController,
                autofillHints: const ['@gmail.com', '@outlook.com'],
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your name'
                    : value.contains('@')
                        ? null
                        : 'Invalid email address',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
                controller: passwordController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Password is mandatory'
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UniversalButton(
                  backgroundColour:
                      Theme.of(context).colorScheme.secondaryContainer,
                  onPressed: () => _formKey.currentState!.validate()
                      ? context.read<AuthBloc>().add(
                            LoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          )
                      : {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
