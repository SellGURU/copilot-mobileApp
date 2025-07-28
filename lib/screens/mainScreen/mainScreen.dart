import 'dart:math';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:copilet/services/branding_service.dart';
import 'package:copilet/services/branding_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import '../mainScreenV2/MainScreenV2.dart';
import '../plan/planScreen.dart';
import '../progressScreen/progress.dart';
import '../result/result.dart';
import '../settingPage/SettingPage.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool _isReportModalOpen = false;
  final GlobalKey<NavigatorState> _healthPlanScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _settingScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _resultScreenKey = GlobalKey();
  final GlobalKey<NavigatorState> _chatScreenKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Load branding data when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Clear cache first to force API call
        _clearBrandingCache();
        // Load branding data
        context.read<BrandingBloc>().add(LoadBrandingData());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Clear branding cache to force API call
  Future<void> _clearBrandingCache() async {
    try {
      // Clear in-memory cache
      BrandingService.instance.clearCache();
      
      // Clear local cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('branding_data');
      
    } catch (e) {
      print('MainScreen: Error clearing cache: $e');
    }
  }

  // override the back btn
  Future<bool> _onWillPop() async {
    if (_healthPlanScreenKey.currentState!.canPop()) {
      _healthPlanScreenKey.currentState!.pop();
    }
    if (_resultScreenKey.currentState!.canPop()) {
      _resultScreenKey.currentState!.pop();
    }
    if (_chatScreenKey.currentState!.canPop()) {
      _chatScreenKey.currentState!.pop();
    }
    if (_settingScreenKey.currentState!.canPop()) {
      _settingScreenKey.currentState!.pop();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: ColorfulSafeArea(
        child: BlocBuilder<PageIndexBloc, PageIndexState>(
          builder: (context, state) {
            return IndexedStack(
              index: state.pageIndex,
              children: [
                const Mainscreenv2(),
                Navigator(
                  key: _resultScreenKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => const ResultScreen(),
                  ),
                ),
                const SizedBox(),
                Navigator(
                  key: _healthPlanScreenKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => ProgressScreen(),
                  ),
                ),
                Navigator(
                  key: _settingScreenKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => SettingPage(
                      onLogoutModalChanged: (isOpen) {
                        setState(() {
                          _isReportModalOpen = isOpen;
                        });
                      },
                    ),
                  ),
                ),
                Navigator(
                  key: _chatScreenKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => Chatscreen(
                      onReportModalChanged: (isOpen) {
                        setState(() {
                          _isReportModalOpen = isOpen;
                        });
                      },
                    ),
                  ),
                ),
                CameraScreen(
                  isCameraStart: false, Parentcontext: context,
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: _isReportModalOpen ? null : BottomNavigationBarCustom(),
    );
  }
}
