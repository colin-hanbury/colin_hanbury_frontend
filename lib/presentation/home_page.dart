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
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'About Colin',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        centerTitle: true,
        actions: [_themeSwitcher()],
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: Scaffold.of(context).openDrawer,
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Blogs',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              onTap: () => Navigator.pushNamed(context, Routes.blogs),
              // {
              //   // Update the state of the app
              //   Navigator.pushNamed(context, Routes.blogs);
              //   // Then close the drawer
              //   Navigator.pop(context);
              // },
            ),
          ],
        ),
      ),
      body: Expanded(
        child: _tutorial(),
      ),
    );
  }

  Widget _auth() {
    return Column(
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

            // double scrollDiff =
            //     amountScrolled - (amountScrolled - screenHeight);
            final imageSlide = (screenWidth / screenHeight) *
                (amountScrolled - (screenHeight * currSection));

            // log("-----------------------------");
            // log("CURRENT SECTION = $currSection");
            // log("-----------------------------");
            // log("Total Scroll = $amountScrolled");
            // log("-----------------------------");
            // log("Screen Width = $screenWidth");
            // log("-----------------------------");
            // log("Image Slide = $imageSlide");
            // log("-----------------------------");
            return SingleChildScrollView(
              controller: _controller,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: screenHeight * 5, maxWidth: screenWidth),
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
                                      Icon(
                                        Icons.android_outlined,
                                        color: Colors.lightGreen,
                                        size: imageHeight,
                                      ),
                                      Icon(
                                        Icons.cloud_circle_rounded,
                                        color: Colors.blueAccent,
                                        size: imageHeight,
                                      ),
                                      // Image.asset(
                                      //   _images[0],
                                      //   height: imageHeight,
                                      //   width: imageHeight,
                                      // ),
                                      // Image.asset(
                                      //   _images[1],
                                      //   height: imageHeight,
                                      //   width: imageHeight,
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.school_rounded,
                                        color: Colors.grey,
                                        size: imageHeight,
                                      ),
                                      Icon(
                                        Icons.developer_mode_rounded,
                                        color: Colors.amberAccent,
                                        size: imageHeight,
                                      ),
                                      // Image.asset(
                                      //   _images[2],
                                      //   height: imageHeight,
                                      //   width: imageHeight,
                                      //   // fit: BoxFit.fill,
                                      // ),
                                      // Image.asset(
                                      //   _images[3],
                                      //   height: imageHeight,
                                      //   width: imageHeight,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "I've worked on\na wide range of\ntechnologies",
                                    textAlign: TextAlign.center,
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
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight: screenHeight),
                              child: Stack(
                                alignment: Alignment.center,
                                fit: StackFit.passthrough,
                                children: [
                                  Image.asset(
                                    'assets/world-map.png',
                                    fit: BoxFit.fill,
                                    // height: imageHeight,
                                    // width: imageHeight,
                                  ),
                                  const Text(
                                    "In April 2023 I decided to take a career break and do some travelling in Asia.",
                                    style: TextStyle(
                                      height: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: screenHeight),
                            child: Transform.translate(
                              offset: Offset(
                                currSection == 0
                                    ? 0.0
                                    : currSection >= 3
                                        ? screenWidth
                                        : currSection == 2
                                            ? imageSlide
                                            : 0,
                                currSection == 0
                                    ? screenHeight
                                    : currSection >= 3
                                        ? screenHeight * 2
                                        : currSection >= 2
                                            ? amountScrolled - (screenHeight)
                                            : screenHeight,
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  'assets/plane.png',
                                  height: imageHeight,
                                  width: imageHeight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        offset: Offset(
                          0,
                          currSection >= 3
                              ? screenHeight * 2
                              : screenHeight * (screenHeight * currSection),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: screenHeight),
                          child: _auth(),
                        ),
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
      icon: Icon(
        Icons.format_color_fill_outlined,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
