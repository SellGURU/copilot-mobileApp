import 'package:camera/camera.dart';
import 'package:copilet/screens/Wearable%20Device/authorizersRook/cubit.dart';
import 'package:copilet/screens/mainScreenV2/MainScreenV2.dart';
import 'package:copilet/screens/mainScreenV2/cubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/state.dart';
import 'package:copilet/screens/mainScreenV2/downloadWeaklyReportState/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadWeaklyReportState/state.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/cubit.dart';
import 'package:copilet/screens/welcomScreen/welcomScreen.dart';
import 'package:copilet/widgets/SurveysCard/googleForm/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:copilet/route/routes.dart';
import 'package:copilet/screens/home/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/state.dart';
import 'package:copilet/screens/login/login.dart';
import 'package:copilet/screens/mainScreen/mainScreen.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_events.dart';
import 'package:copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
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
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return const Mainscreen();
              // return const ();
            }
            if (state is LoggedOutState) {
              return const Welcomscreen();
            } else {
              BlocProvider.of<ClientInformationMobileCubit>(
                  context)
                  .getPdf();
              BlocProvider.of<GoogleFormCubit>(
                  context)
                  .getBiomarker();
              return const Center(
                child: SpinKitThreeBounce(color: Colors.purple,),
              );
            }
          },
        ),
      ),
    );
  }
}
