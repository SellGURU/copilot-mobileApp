// ignore: file_names
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/utility/token/getTokenLocaly.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'cubit.dart';
import 'state.dart';

class ActivityTaskItem extends StatefulWidget {
  final Map<String, dynamic> task;
  const ActivityTaskItem({super.key,required this.task});
  @override
  State<ActivityTaskItem> createState() {
    return _ActivityTaskItemState();
  }  
}

class _ActivityTaskItemState extends State<ActivityTaskItem> {
  late Map<String, dynamic> taskData;
  late final WebViewController _controller;
  late String encodeId;
  
  @override
  void initState() {
    super.initState();
    taskData = widget.task;
    _initializeTask();
  }

  Future<void> _initializeTask() async {
    String fetchedEncodeId = await _getEncodeId();
    setState(() {
      encodeId = fetchedEncodeId;
    });
    _initializeWebView();
  }  

  Future<String> _getEncodeId() async {
    return await getEncodeLocally() as String;   
  }  

  void _initializeWebView() {
    if (taskData['type'] == 'Check-In' || taskData['type'] == 'Questionary') {
      String taskType = taskData['type'] == 'Check-In' ? 'checkin' : 'questionary';
      _controller = WebViewController()
        ..loadRequest(Uri.parse("https://holisticare.vercel.app/$taskType/$encodeId/${taskData["id"]}"));
      setState(() {});
    }
  }

  void _openWebViewModal(BuildContext context, String title) {
    if (taskData['type'] == 'Check-In' || taskData['type'] == 'Questionary') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                AppBar(
                  title: Text(title, style: AppTextStyles.title1),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: WebViewWidget(controller: _controller),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTask(taskData),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 4,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: taskData["completed"] == 'Done' ? AppColors.greenBega : AppColors.SilverGray,
                        width: 3,
                      )
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/firstline.svg',
                        width: 16,
                        height: 16,
                        fit: BoxFit.contain,
                        color: taskData["completed"] == 'Done' ? AppColors.greenBega : AppColors.TextTriarty,
                      )
                    )
                  ),
                  Text(taskData["Title"], style: AppTextStyles.hintMedium)
                ],
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: taskData["completed"] == 'Done' ? AppColors.greenBega : AppColors.SilverGray,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: taskData["completed"] == 'Done'
                  ? GestureDetector(
                      child: Center(
                        child: SvgPicture.asset('assets/tick.svg'),
                      ),
                    )
                  : GestureDetector(
                      child: Center(
                        child: SvgPicture.asset('assets/pelas.svg'),
                      ),
                      onTap: () {
                        _openWebViewModal(context, taskData["Title"]);
                        context.read<TaskCubit>().completeTask(taskData);
                      },
                    )
              )
            ],
          );
        }
      ),
    );
  }  
}