import 'dart:developer';

import 'package:colin_hanbury_frontend/bloc/intro/intro_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/intro/intro_event.dart';
import 'package:colin_hanbury_frontend/bloc/intro/intro_state.dart';
import 'package:colin_hanbury_frontend/bloc/theme/theme_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/theme/theme_event.dart';
import 'package:colin_hanbury_frontend/utils/routes.dart';
import 'package:colin_hanbury_frontend/utils/univeral_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() => {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Tech Talent WA'),
        centerTitle: true,
        actions: [_themeSwitcher()],
      ),
      body: Expanded(
        child: Column(
          children: [
            _auth(),
            Expanded(
              child: _tutorial(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _auth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _login(),
        _register(),
      ],
    );
  }

  final List<String> _images = [
    "assets/programmerA.png",
    "assets/programmerB.png",
    "assets/programmerC.png",
    "assets/programmerD.png",
  ];

  Widget _tutorial() {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        Size screenSize = MediaQuery.of(context).size;
        _controller.addListener(
          () {
            context.read<IntroBloc>().add(
                  ScrollEvent(
                    offset: _controller.offset,
                  ),
                );
          },
        );

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            final screenHeight = viewportConstraints.maxHeight;
            final screenWidth = viewportConstraints.maxWidth;
            final amountScrolled = state.amountScrolled;
            // final scrollDiff = state.dy;

            /// image growth
            final initialImageHeight = 0.25 * screenHeight;
            final imageScale = initialImageHeight + (0.25 * amountScrolled);
            final maxImageHeight = screenHeight * 0.5;
            final imageHeight =
                maxImageHeight > imageScale ? imageScale : maxImageHeight;

            final int currSection = amountScrolled > screenHeight
                ? amountScrolled ~/ screenHeight
                : 0;

            double scrollDiff =
                amountScrolled - (amountScrolled - screenHeight);
            final imageSlide = (screenHeight / screenHeight) *
                (amountScrolled - (screenHeight * currSection));

            log("-----------------------------");
            log("CURRENT SECTION = $currSection");
            log("-----------------------------");
            log("Total Scroll = $amountScrolled");
            log("-----------------------------");
            log("Screen Width = $screenWidth");
            log("-----------------------------");
            log("Image Slide = $imageSlide");
            log("-----------------------------");
            return SingleChildScrollView(
              controller: _controller,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: screenHeight, maxWidth: screenWidth),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: screenHeight),
                        child: Transform.translate(
                          offset: Offset(
                              0,
                              // currSection >= 2
                              //     ? 0.0
                              //     :
                              currSection >= 1 ? screenHeight : amountScrolled),
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.passthrough,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        _images[0],
                                        height: imageHeight,
                                        width: imageHeight,
                                      ),
                                      Image.asset(
                                        _images[1],
                                        height: imageHeight,
                                        width: imageHeight,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        _images[2],
                                        height: imageHeight,
                                        width: imageHeight,
                                        // fit: BoxFit.fill,
                                      ),
                                      Image.asset(
                                        _images[3],
                                        height: imageHeight,
                                        width: imageHeight,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "We find the talent",
                                    style: TextStyle(
                                      fontSize: currSection < 1
                                          ? 2.0 * (amountScrolled * 0.01) + 10.0
                                          : 2.0 * (screenHeight * 0.01) + 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        fit: StackFit.passthrough,
                        children: [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: screenHeight),
                            child: Transform.translate(
                              offset: Offset(
                                currSection == 0
                                    ? 0.0
                                    : currSection >= 3
                                        ? screenWidth - imageHeight
                                        : currSection % 2 == 0
                                            ? screenWidth - imageHeight
                                            : imageSlide,
                                currSection == 0
                                    ? screenHeight
                                    : currSection >= 3
                                        ? screenHeight * 2
                                        : currSection % 2 == 0
                                            ? amountScrolled - screenHeight
                                            : screenHeight,
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  'assets/businesswoman.png',
                                  height: imageHeight,
                                  width: imageHeight,
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(
                              0,
                              currSection == 0
                                  ? screenHeight
                                  : currSection >= 3
                                      ? screenHeight * 2
                                      : currSection % 2 == 0
                                          ? amountScrolled - screenHeight
                                          : screenHeight,

                              /// against scroll
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tell us what you're looking for",
                                style: TextStyle(height: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: screenHeight * 4),
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _register() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: UniversalButton(
        backgroundColour: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () => Navigator.pushNamed(context, Routes.registration),
        child: Text(
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 18,
              fontWeight: FontWeight.normal),
          'Register',
        ),
      ),
    );
  }

  Widget _login() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: UniversalButton(
        backgroundColour: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () => Navigator.pushNamed(context, Routes.login),
        child: Text(
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 18,
              fontWeight: FontWeight.normal),
          'Login',
        ),
      ),
    );
  }

  Widget _themeSwitcher() {
    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(10.0),
      constraints: const BoxConstraints(
        minWidth: 50.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('Light'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: context.read<ThemeBloc>().state.mode,
                onChanged: (mode) {
                  context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(0.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('Dark'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: context.read<ThemeBloc>().state.mode,
                onChanged: (mode) {
                  context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        PopupMenuItem<int>(
          padding: const EdgeInsets.all(0.0),
          value: 1,
          child: Center(
            child: ListTile(
              title: const Text('System'),
              leading: Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: context.read<ThemeBloc>().state.mode,
                  onChanged: (mode) {
                    context.read<ThemeBloc>().add(ThemeChanged(mode: mode!));
                    Navigator.pop(context);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

enum ScrollType { withScroll, againstScroll, static }
