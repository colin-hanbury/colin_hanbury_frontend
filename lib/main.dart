import 'dart:developer';

import 'package:colin_hanbury_frontend/bloc/auth/auth_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/candidates/candidates_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/intro/intro_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/registration/registration_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/theme/theme_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/theme/theme_state.dart';
import 'package:colin_hanbury_frontend/presentation/home_page.dart';
import 'package:colin_hanbury_frontend/repositories/auth_repo.dart';
import 'package:colin_hanbury_frontend/repositories/registration_repo.dart';
import 'package:colin_hanbury_frontend/repositories/visitor_repo.dart';
import 'package:colin_hanbury_frontend/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (BuildContext context) => VisitorRepo()),
          RepositoryProvider(create: (BuildContext context) => AuthRepo()),
          RepositoryProvider(
              create: (BuildContext context) => RegistrationRepo()),
          //more repos
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CandidatesBLoC>(
              create: (BuildContext context) =>
                  CandidatesBLoC(visitorRepo: context.read<VisitorRepo>()),
            ),
            BlocProvider<ThemeBloc>(
              create: (BuildContext context) => ThemeBloc(),
            ),
            BlocProvider<AuthBloc>(
              create: (BuildContext context) =>
                  AuthBloc(authRepo: context.read<AuthRepo>()),
            ),
            BlocProvider<RegistrationBloc>(
              create: (BuildContext context) => RegistrationBloc(
                  registrationRepo: context.read<RegistrationRepo>()),
            ),
            BlocProvider<IntroBloc>(
              create: (BuildContext context) => IntroBloc(),
            ),
          ],
          child: const TechTalentApp(),
        ),
      ),
    );
  } catch (error) {
    log(error.toString());
  }
  // WidgetsFlutterBinding.ensureInitialized();
  /// Load theme preference
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String mode = prefs.getString('theme_mode') ?? '';
}

class TechTalentApp extends StatelessWidget {
  const TechTalentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          initialRoute: Routes.home,
          home: const HomePage(),
          theme: ThemeData(
            textTheme: GoogleFonts.loraTextTheme(),
            brightness: Brightness.light,
            colorScheme: const ColorScheme.light(),
          ),
          darkTheme: ThemeData(
            // useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark(),
          ),
          themeMode: state.mode,
          title: 'Tech Talent WA',
        ),
      ),
    );
  }
}
