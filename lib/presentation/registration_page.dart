import 'package:colin_hanbury_frontend/bloc/registration/registration_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/registration/registration_event.dart';
import 'package:colin_hanbury_frontend/bloc/registration/registration_state.dart';
import 'package:colin_hanbury_frontend/utils/routes.dart';
import 'package:colin_hanbury_frontend/utils/univeral_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final forenameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(
          'Registration',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _pageLayout(),
      ),
    );
  }

  Widget _pageLayout() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      switch (state.status) {
        case RegistrationStatus.unregistered:
          return _registrationForm();
        case RegistrationStatus.registered:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          });
          return const SizedBox();
        case RegistrationStatus.error:
          return Stack(
            children: [
              _registrationForm(),
              _showAlert(state.error),
            ],
          );
        case RegistrationStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          return _registrationForm();
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

  Widget _registrationForm() {
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
                  hintText: 'Forename',
                ),
                controller: forenameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your forename'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Surname',
                ),
                controller: surnameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your surname'
                    : null,
              ),
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
                validator: (password) => _validatePassword(password),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                ),
                obscureText: false,
                autocorrect: false,
                controller: confirmPasswordController,
                validator: (value) =>
                    value?.compareTo(passwordController.text) == 0
                        ? null
                        : 'Passwords do not match',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UniversalButton(
                  backgroundColour:
                      Theme.of(context).colorScheme.secondaryContainer,
                  onPressed: () => _formKey.currentState!.validate()
                      ? context.read<RegistrationBloc>().add(
                            RegisterEvent(
                              forename: forenameController.text,
                              surname: surnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          )
                      : {},
                  child: Text(
                    'Register',
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

  String? _validatePassword(String? password) {
    String errorMessage = '';
    // Password length greater than 6
    if (password == null || password.isEmpty) {
      return 'Password is required.\n';
    }
    // Password length greater than 6
    if (password.length < 6) {
      errorMessage += '• Password must be longer than 6 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage += '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      errorMessage += '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      errorMessage += '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      errorMessage += '• Special character is missing.\n';
    }
    return errorMessage.isEmpty ? null : errorMessage;
  }
}
