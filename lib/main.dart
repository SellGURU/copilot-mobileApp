/// This file serves as the entry point for the application.
/// It initializes required dependencies, sets up providers, and defines the main app widget structure.

import 'package:camera/camera.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/screens/Wearable%20Device/authorizersRook/cubit.dart';
import 'package:copilet/screens/camera/imageHandlerCubit/cubit.dart';
import 'package:copilet/screens/chatScreen/cubit/cubit.dart';
import 'package:copilet/screens/mainScreen/mainScreen.dart';
import 'package:copilet/screens/mainScreenV2/cubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadWeaklyReportState/cubit.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/cubit.dart';
import 'package:copilet/screens/welcomScreen/welcomScreen.dart';
import 'package:copilet/utility/deviceName.dart';
import 'package:copilet/widgets/SurveysCard/googleForm/cubit.dart';
import 'package:copilet/widgets/restart/RestartWidget.dart';
import 'package:copilet/widgets/Tasks/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copilet/route/routes.dart';
import 'package:copilet/screens/home/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/state.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_events.dart';
import 'package:copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// Custom Scroll Behavior
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // For Android - use GlowingOverscrollIndicator
    if (Theme.of(context).platform == TargetPlatform.android) {
      return GlowingOverscrollIndicator(
        axisDirection: details.direction,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    }
    // For iOS - use default behavior
    return super.buildOverscrollIndicator(context, child, details);
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Custom physics for different platforms
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
        return const BouncingScrollPhysics();
      case TargetPlatform.android:
        return const ClampingScrollPhysics();
      default:
        return const BouncingScrollPhysics();
    }
  }
}


void main() async {
  /// Ensures binding is initialized for widgets before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }  

  runApp(const RestartWidget(child: MyApp()));
}

/// The main widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  
    return MultiBlocProvider(
      providers: [
        /// Provides state management for various features of the application.
        BlocProvider(create: (_) => PageIndexBloc()),
        BlocProvider(create: (_) => DownloadWeaklyReportCubit()),
        BlocProvider(create: (_) => SwitchValueGraphBloc()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => AuthorizersRookCubit()),
        BlocProvider(create: (_) => BiomarkerCubit()),
        BlocProvider(create: (_) => GoogleFormCubit()),
        BlocProvider(create: (_) => HealthScoreCubit()),
        BlocProvider(create: (_) => DownloadReportPdfCubit()),
        BlocProvider(create: (_) => ClientInformationMobileCubit()),
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(create: (_) => ImageHandlerCubit()),
        BlocProvider(create: (_) => TaskCubit()),
        BlocProvider(
          lazy: false,
          create: (context) {
            final cameraBloc = CameraBloc();
            cameraBloc.add(CameraInitialize()); // Trigger initialization
            return cameraBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'App Holisticare',
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehavior(),
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return Center(
                child: Container(
                  width: kIsWeb ? 420 : double.infinity,
                  child: const Mainscreen(),
                ),
              );
            }

            if (state is LoggedOutState) {
              return const Welcomscreen();
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )

      ),
    );
  }
}
