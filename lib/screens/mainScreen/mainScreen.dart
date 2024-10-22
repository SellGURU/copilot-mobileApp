import 'dart:math';

import 'package:copilet/screens/mainScreenV2/MainScreenV2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:screenshot/screenshot.dart';

import '../../res/colors.dart';
import '../../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../../utility/changeScreanBloc/PageIndex_states.dart';
import '../../utility/token/getTokenLocaly.dart';
import '../../widgets/bottomNavigationBar.dart';
import '../Detailed Plan/detailedPlan.dart';
import '../camera/camaraScreen.dart';
import '../chatScreen/chatScreen.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../plan/planScreen.dart';
import '../progressScreen/progress.dart';
import '../result/result.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final GlobalKey<NavigatorState> _healthPlanScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _resultScreenKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

  // override the back btn
  Future<bool> _onWillPop() async {
    if (_healthPlanScreenKey.currentState!.canPop()) {
      _healthPlanScreenKey.currentState!.pop();
    }
    if (_resultScreenKey.currentState!.canPop()) {
      _resultScreenKey.currentState!.pop();
    }

    return false;
  }

  bool isTakingScreenShot = false;
  void takeScreenShot() {
    print("check screen");
    setState(() {
      isTakingScreenShot = true;
    });
    screenshotController.capture().then((capturedImage) async {
      print(capturedImage);
    }).catchError((onError) {
      setState(() {
        isTakingScreenShot = true;
      });
      print(onError);
    }).whenComplete(() {
      setState(() {
        isTakingScreenShot = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: size.height,
              width: size.width,
              child: Container(
                width: size.width > 440 ? 440 : size.width,
                child: Scaffold(
                    backgroundColor: AppColors.bgScreen,
                    body: SafeArea(
                      child: BlocBuilder<PageIndexBloc, PageIndexState>(
                        builder: (context, state) {
                          // setState(() {
                          //   pageIndex = state.pageIndex;
                          // });
                          return IndexedStack(
                            index: state.pageIndex,
                            children: [
                              const Mainscreenv2(),
                              Navigator(
                                key: _resultScreenKey,
                                onGenerateRoute: (settings) =>
                                    MaterialPageRoute(
                                  builder: (context) => const ResultScreen(),
                                ),
                              ),
                              const SizedBox(),
                              Navigator(
                                key: _healthPlanScreenKey,
                                onGenerateRoute: (settings) =>
                                    MaterialPageRoute(
                                  builder: (context) => ProgressScreen(),
                                ),
                              ),
                              const SizedBox(),

                              // HealthPlanScreen(),
                              const Chatscreen(),
                              CameraScreen(
                                isCameraStart: false,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    bottomNavigationBar: BottomNavigationBarCustom(
                      takeScreenShot: takeScreenShot,
                    )),
              ),
            ),
            isTakingScreenShot
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, .0)),
                        child: const SizedBox(),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
}
