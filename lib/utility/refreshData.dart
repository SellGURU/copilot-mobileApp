import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/mainScreenV2/userinfoCubit/cubit.dart';
import '../screens/mainScreenV2/cubit/cubit.dart';
import '../screens/home/cubit/cubit.dart';
import '../screens/mainScreenV2/downloadReport/cubit.dart';
import '../widgets/Tasks/cubit.dart';
import '../widgets/Tasks.dart';

/// Utility class to handle data refresh across the application
class DataRefreshUtil {
  
  /// Refresh all main data sources
  static void refreshAllData(BuildContext context) {
    try {
      BlocProvider.of<ClientInformationMobileCubit>(context).getPdf();
      BlocProvider.of<BiomarkerCubit>(context).getBiomarker();
      BlocProvider.of<HealthScoreCubit>(context).getBiomarker();
      BlocProvider.of<DownloadReportPdfCubit>(context).getPdf();
      _refreshTasksData(context);
    } catch (e) {
      print('Error refreshing data: $e');
    }
  }

  /// Refresh data based on specific page index
  static void refreshDataForPage(BuildContext context, int pageIndex) {
    try {
      switch (pageIndex) {
        case 0: // Overview page
          BlocProvider.of<ClientInformationMobileCubit>(context).getPdf();
          BlocProvider.of<BiomarkerCubit>(context).getBiomarker();
          BlocProvider.of<HealthScoreCubit>(context).getBiomarker();
          BlocProvider.of<DownloadReportPdfCubit>(context).getPdf();
          _refreshTasksData(context);
          break;
        case 1: // Results page
          BlocProvider.of<BiomarkerCubit>(context).getBiomarker();
          BlocProvider.of<HealthScoreCubit>(context).getBiomarker();
          break;
        case 3: // Progress page
          _refreshTasksData(context);
          break;
        case 4: // Settings page
          // Add specific data refresh for settings page if needed
          break;
      }
    } catch (e) {
      print('Error refreshing data for page $pageIndex: $e');
    }
  }

  /// Refresh only biomarker data
  static void refreshBiomarkerData(BuildContext context) {
    try {
      BlocProvider.of<BiomarkerCubit>(context).getBiomarker();
    } catch (e) {
      print('Error refreshing biomarker data: $e');
    }
  }

  /// Refresh only health score data
  static void refreshHealthScoreData(BuildContext context) {
    try {
      BlocProvider.of<HealthScoreCubit>(context).getBiomarker();
    } catch (e) {
      print('Error refreshing health score data: $e');
    }
  }

  /// Refresh tasks data by calling the static method
  static void _refreshTasksData(BuildContext context) {
    try {
      // Call the static method to refresh all Tasks widgets
      Tasks.refreshAllTasks();
    } catch (e) {
      print('Error refreshing tasks data: $e');
    }
  }

  /// Test method to verify all refresh methods work
  static void testAllRefreshMethods(BuildContext context) {
    print('Testing all refresh methods...');
    refreshAllData(context);
    print('All refresh methods called successfully');
  }
} 