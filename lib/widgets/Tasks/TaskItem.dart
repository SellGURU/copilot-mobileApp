// ignore: file_names
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/utility/token/getTokenLocaly.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
class TaskItem extends StatefulWidget {
  final Map<String, dynamic> task;
  const TaskItem({super.key,required this.task});
  @override
  State<TaskItem> createState() {
    return _TaskItemState();
  }  
}

class _TaskItemState extends State<TaskItem> {
  late Map<String, dynamic> taskData;
  late final WebViewController _controller;
  late String encodeId ;
  @override
  void initState() {
    super.initState();
    taskData = widget.task; // Access task from widget
    _initializeTask();
    // _controller = WebViewController()
    //   ..loadRequest(Uri.parse("https://holisticare.vercel.app/checkin/"+taskData["id"]));
  }

  Future<void> _initializeTask() async {
    // Simulate fetching taskId asynchronously (e.g., API call, SharedPreferences)
    String fetchedEncodeId = await _getEncodeId(); // Await an async function
    setState(() {
      encodeId = fetchedEncodeId; // Update state with fetched ID
    });

    _initializeWebView();
  }  
  Future<String> _getEncodeId() async {
    return await getEncodeLocally() as String;   
  }  
  void _initializeWebView() {
    _controller = WebViewController();
    _controller.loadRequest(Uri.parse("https://holisticare.vercel.app/checkin/$encodeId/$taskData.id"));
    print("https://holisticare.vercel.app/checkin/$encodeId/"+taskData["id"]);
    setState(() {}); // Ensure UI updates after WebView loads
  }
  void _openWebViewModal(BuildContext context,String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              AppBar(
                title: Text(title,style: AppTextStyles.title1),
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

  @override
  Widget build(BuildContext context) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                        Row(mainAxisAlignment:MainAxisAlignment.start,spacing: 4 ,children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: AppColors.SilverGray,
                                width: 3,
                              )// Rounded corners
                            ),
                            child: Center(
                              // ignore: deprecated_member_use
                              child:SvgPicture.asset('assets/firstline.svg',width: 16,height: 16,fit: BoxFit.contain,color: AppColors.TextTriarty ,) )
                          )
                          ,
                          Text(widget.task["title"],style: AppTextStyles.hintMedium,)
                        ],)
                        ,
                        Container(
                          width: 24,
                          height: 24,
                          decoration:BoxDecoration(
                            border: Border.all(
                              color:AppColors.SilverGray,
                              width:1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ) ,
                          child:GestureDetector(
                            child:Center(
                              child:SvgPicture.asset('assets/pelas.svg',) ,
                          ), onTap: () { _openWebViewModal(context,widget.task["title"]); },
                          ) 
                        )
                ] ,);
  }  
}