import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_navbar/models/rive_asset.dart';
import 'package:rive_navbar/utils/rive_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RiveAsset> bottomNavs = [
    RiveAsset(
      src: "assets/rive/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
      title: "Chat",
    ),
    RiveAsset(
      src: "assets/rive/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search",
    ),
    RiveAsset(
      src: "assets/rive/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Timer",
    ),
    RiveAsset(
      src: "assets/rive/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications",
    ),
    RiveAsset(
      src: "assets/rive/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile",
    ),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF17203A).withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    bottomNavs[index].input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 2),
                        height: 4,
                        width: index == selectedIndex ? 20 : 0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF81B4FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: index == selectedIndex ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);
                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
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
