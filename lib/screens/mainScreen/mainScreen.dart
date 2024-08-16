import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:test_copilet/res/colors.dart';

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
import '../result/result.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final GlobalKey<NavigatorState> _healthPlanScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _resultScreenKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getTokenLocally(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // if (false) {
            return const Center(
                child: Scaffold(
              body: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            // } else if (false) {
            print("$snapshot.error");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String? token = snapshot.data;
            print(token);
            if (token == null) {
              // if (false) {
              return LoginPage();
            } else {
              // TODO: replace with new version of widget
              return WillPopScope(
                onWillPop: _onWillPop,
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
                              const HomeScreen(),
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
                                  builder: (context) => HealthPlanScreen(),
                                ),
                              ),
                              detailedPlan(),
                              const Chatscreen(),
                              CameraScreen(),
                            ],
                          );
                        },
                      ),
                    ),
                    bottomNavigationBar:  BottomNavigationBarCustom()),
              );
            }
          }
        });
  }
}
