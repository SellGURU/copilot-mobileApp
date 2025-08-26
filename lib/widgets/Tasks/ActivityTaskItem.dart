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
  final bool readOnly; // پراپ جدید برای حالت فقط خواندن
  final VoidCallback?
      onTaskCompletionChanged; // Callback for task completion changes
  const ActivityTaskItem(
      {super.key,
      required this.task,
      this.readOnly = false,
      this.onTaskCompletionChanged});
  @override
  State<ActivityTaskItem> createState() {
    return _ActivityTaskItemState();
  }
}

class _ActivityTaskItemState extends State<ActivityTaskItem> {
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
    if (widget.task['type'] == 'Check-In' ||
        widget.task['type'] == 'Questionary') {
      String taskType =
          widget.task['type'] == 'Check-In' ? 'checkin' : 'questionary';
      _controller = WebViewController()
        ..loadRequest(Uri.parse(
            "https://holisticare.vercel.app/$taskType/$encodeId/${widget.task["id"]}"));
      setState(() {});
    } else {
      _controller = WebViewController()
        // ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(
            "http://localhost:5173/tasks/$encodeId/${widget.task["task_id"]}"));
      setState(() {});
    }
  }

  void _openWebViewModal(BuildContext context, String title) {
    if (widget.task['type'] == 'Check-In' ||
        widget.task['type'] == 'Questionary') {
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
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    title: Text(title, style: AppTextStyles.title1),
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                    backgroundColor: Colors.white,
                    elevation: 0,
                    foregroundColor: AppColors.textPrimary,
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: WebViewWidget(controller: _controller),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary),
                        ),
                        Row(
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Checkbox(
                                  value: widget.task["completed"] == 'Done',
                                  onChanged: widget.readOnly
                                      ? null
                                      : (val) {
                                          if (widget.task["completed"] !=
                                              'Done') {
                                            print(
                                                'widget.task["completed"] ${widget.task}');
                                            context
                                                .read<TaskCubit>()
                                                .completeTask(widget.task);
                                            setState(() {
                                              widget.task["completed"] = 'Done';
                                            });
                                            // Notify parent about completion change
                                            widget.onTaskCompletionChanged
                                                ?.call();
                                          } else {
                                            context
                                                .read<TaskCubit>()
                                                .uncheckTask(widget.task);
                                            setState(() {
                                              widget.task["completed"] = '';
                                            });
                                            // Notify parent about completion change
                                            widget.onTaskCompletionChanged
                                                ?.call();
                                          }
                                        },
                                );
                              },
                            ),
                            const Text("Done"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTask(widget.task),
      child: BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
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
                      return Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: widget.task["completed"] == 'Done' ||
                                        widget.task["Status"] == true
                                    ? AppColors.dynamicPrimaryColor
                                    : AppColors.SilverGray,
                                width: 3,
                              )),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/firstline.svg',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                            color: widget.task["completed"] == 'Done' ||
                                    widget.task["Status"] == true
                                ? AppColors.dynamicPrimaryColor
                                : AppColors.TextTriarty,
                          )));
                    }),
                Container(
                  width: 140, // یا هر عددی که مناسب طراحی‌ات است
                  child: Tooltip(
                    message: widget.task["Title"] ?? "",
                    child: Text(
                      widget.task["Title"] ?? "",
                      style: AppTextStyles.hintMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
                onTap: widget.readOnly
                    ? null
                    : () {
                        _openWebViewModal(context, widget.task["Title"]);
                        // if (widget.task["completed"] == 'Done' ||
                        //     widget.task["Status"] == true) {
                        //   context.read<TaskCubit>().uncheckTask(widget.task);
                        //   // Notify parent about completion change
                        //   setState(() {
                        //     widget.task["completed"] = '';
                        //   });
                        //   widget.onTaskCompletionChanged?.call();
                        // } else {
                        //   context.read<TaskCubit>().completeTask(widget.task);
                        //   // Notify parent about completion change
                        //   setState(() {
                        //     widget.task["completed"] = 'Done';
                        //   });
                        //   widget.onTaskCompletionChanged?.call();
                        // }
                      },
                child: ValueListenableBuilder<Color>(
                    valueListenable: AppColors.dynamicPrimaryColorNotifier,
                    builder: (context, secondaryColor, child) {
                      return Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.task["completed"] == 'Done' ||
                                    widget.task["Status"] == true
                                ? AppColors.dynamicPrimaryColor
                                : AppColors.SilverGray,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Opacity(
                            opacity: widget.readOnly ? 0.5 : 1.0,
                            child: widget.task["completed"] == 'Done' ||
                                    widget.task["Status"] == true
                                ? Center(
                                    child: SvgPicture.asset('assets/tick.svg',
                                        color: AppColors.dynamicPrimaryColor),
                                  )
                                : Center(
                                    child: SvgPicture.asset('assets/pelas.svg',
                                        color: AppColors.dynamicPrimaryColor),
                                  )),
                      );
                    }))
          ],
        );
      }),
    );
  }
}
