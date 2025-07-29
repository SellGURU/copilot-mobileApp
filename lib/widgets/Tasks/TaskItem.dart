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
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class TaskItem extends StatefulWidget {
  final Map<String, dynamic> task;
  final bool readOnly; // پراپ جدید برای حالت فقط خواندن
  const TaskItem({super.key,required this.task, this.readOnly = false});
  @override
  State<TaskItem> createState() {
    return _TaskItemState();
  }  
}

class _TaskItemState extends State<TaskItem> {
  // late Map<String, dynamic> taskData;
  late final WebViewController _controller;
  late String encodeId;
  
  @override
  void initState() {
    super.initState();
    // taskData = widget.task;
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
    if (kIsWeb) {
      if (widget.task['type'] == 'Check-In' || widget.task['type'] == 'Questionary') {
        String taskType = widget.task['type'] == 'Check-In' ? 'checkin' : 'questionary';
        // launchUrl(Uri.parse("https://holisticare-develop.vercel.app/$taskType/$encodeId/${taskData["id"]}"));
        _controller = WebViewController()
          ..loadRequest(Uri.parse("https://holisticare-develop.vercel.app/$taskType/$encodeId/${widget.task["id"]}"));
        setState(() {});
      }
    }else {
      if (widget.task['type'] == 'Check-In' || widget.task['type'] == 'Questionary') {
        String taskType = widget.task['type'] == 'Check-In' ? 'checkin' : 'questionary';
        // launchUrl(Uri.parse("https://holisticare-develop.vercel.app/$taskType/$encodeId/${widget.task["id"]}"));
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse("https://holisticare-develop.vercel.app/$taskType/$encodeId/${widget.task["id"]}"));
        setState(() {});
      }

    }
  }

  void _openWebViewModal(BuildContext context, String title) {
    if (widget.task['type'] == 'Check-In' || widget.task['type'] == 'Questionnaire') {
      // showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   builder: (context) {
      //     return SizedBox(
      //       height: MediaQuery.of(context).size.height * 0.9,
      //       child: Column(
      //         children: [
      //           AppBar(
      //             title: Text(title, style: AppTextStyles.title1),
      //             automaticallyImplyLeading: false,
      //             actions: [
      //               IconButton(
      //                 icon: const Icon(Icons.close),
      //                 onPressed: () => Navigator.pop(context),
      //               ),
      //             ],
      //           ),
      //           Expanded(
      //             child: GestureDetector(
      //               behavior: HitTestBehavior.opaque,  // مهم
      //               child: WebViewWidget(controller: _controller),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
      print('widget.task["completed"] ${widget.task}');
       String taskType = widget.task['type'] == 'Check-In' ? 'checkin' : 'questionary';
      launchUrl(Uri.parse("https://holisticare-develop.vercel.app/$taskType/$encodeId/${widget.task["id"]}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTask(widget.task),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 4,
                children: [
                  ValueListenableBuilder<Color>(
                    valueListenable: AppColors.dynamicPrimaryColorNotifier,
                    builder: (context, secondaryColor, child) {
                      return  Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: widget.task["completed"] == 'Done' || widget.task["status"] == 'Done' ? AppColors.dynamicPrimaryColor : AppColors.SilverGray,
                                width: 3,
                              )
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                widget.task['type'] == 'Check-In'?'assets/firstline.svg':'assets/note.svg',
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                                color: widget.task["completed"] == 'Done' || widget.task["status"] == 'Done' ? AppColors.dynamicPrimaryColor : AppColors.TextTriarty,
                              )
                            )
                          );
                    }
                  ),

                  Container(
                  width: 140, // یا هر عددی که مناسب طراحی‌ات است
                  child: Tooltip(
                    message: widget.task["title"] ?? "",
                    child: Text(
                      widget.task["title"] ?? "",
                      style: AppTextStyles.hintMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                )
                
                ],
              ),
              GestureDetector(
                onTap: widget.readOnly ? null : () {
                  if(widget.task["completed"] != 'Done' ){
                    print('widget.task["completed"] ${widget.task}');
                    _openWebViewModal(context, widget.task["title"]);
                    context.read<TaskCubit>().completeTask(widget.task);
                    setState(() {
                      widget.task["completed"] = 'Done';
                    });
                  }else {
                    // _openWebViewModal(context, widget.task["title"]);
                    context.read<TaskCubit>().uncheckTask(widget.task);
                    setState(() {
                      widget.task["completed"] = '';
                    });
                  }
                },                
                child:ValueListenableBuilder<Color>(
                  valueListenable: AppColors.dynamicPrimaryColorNotifier,
                  builder: (context, secondaryColor, child) {
                    return Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.task["completed"] == 'Done' ? AppColors.dynamicPrimaryColor : AppColors.SilverGray,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Opacity(
                              opacity: widget.readOnly ? 0.5 : 1.0,
                              child: widget.task["completed"] == 'Done' || widget.task["status"] == 'Done'
                                ? Center(
                                    child: SvgPicture.asset('assets/tick.svg', color: AppColors.dynamicPrimaryColor),
                                  )
                                : Center(
                                    child: SvgPicture.asset('assets/pelas.svg', color: AppColors.dynamicPrimaryColor),
                                  )
                            ),
                          );
                  }
                ) 
             ,
              )

            ],
          );
        }
      ),
    );
  }  
}