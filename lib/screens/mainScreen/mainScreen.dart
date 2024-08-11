import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../../utility/changeScreanBloc/PageIndex_states.dart';
import '../../utility/switchValueBloc/PageIndex_Bloc.dart';
import '../../utility/token/getTokenLocaly.dart';
import '../../widgets/bottomNavigationBar.dart';
import '../Detailed Plan/detailedPlan.dart';
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
  var pageIndexSelect;

  // map[0] => _homeKey
  // map[1] => _basketKey
  // map[2] => _profileKey

  Future<bool> _onWillPop() async {
    print(pageIndexSelect);
    // if (map[selectedIndex]!.currentState!.canPop()) {
    //   map[selectedIndex]!.currentState!.pop();
    // } else if (_routeHistory.length > 1) {
    //   setState(() {
    //     _routeHistory.removeLast();
    //     selectedIndex = _routeHistory.last;
    //   });
    // }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: BlocBuilder<PageIndexBloc, PageIndexState>(
                      builder: (context, state) {
                        // setState(() {
                        //   pageIndexSelect=state.pageIndex;
                        // });
                        // print(pageIndexSelect);

                        return IndexedStack(
                          index: state.pageIndex,
                          children: [
                            const HomeScreen(),
                            const ResultScreen(),
                            SizedBox(),
                            Navigator(
                              key: _healthPlanScreenKey,
                              onGenerateRoute: (settings) => MaterialPageRoute(
                                builder: (context) => HealthPlanScreen(),
                              ),
                            ),
                            detailedPlan()
                          ],
                        );
                      },
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBarCustom());
            }
          }
        });
  }
}
