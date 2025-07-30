import 'dart:convert';
import 'dart:typed_data';

import 'package:copilet/screens/camera/imageHandlerCubit/cubit.dart';
import 'package:copilet/screens/camera/imageHandlerCubit/state.dart';
import 'package:copilet/screens/chatScreen/cubit/cubit.dart';
import 'package:copilet/screens/chatScreen/cubit/cubit.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';

enum ChatMode {
  ai,
  coach
}

class Chatscreen extends StatefulWidget {
  final void Function(bool)? onReportModalChanged;
  const Chatscreen({Key? key, this.onReportModalChanged}) : super(key: key);

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final TextEditingController _controller = TextEditingController();
  ChatMode _selectedMode = ChatMode.ai;
  bool _isDropdownOpen = false;
  String conversationIdReport = "";
  // State management for like/dislike buttons
  Map<int, bool> _likedMessages = {};
  Map<int, bool> _dislikedMessages = {};
  // State management for copied messages
  Map<int, bool> _copiedMessages = {};

  // State management for report modal
  String? _selectedReportReason;
  final TextEditingController _reportDetailsController = TextEditingController();
  final List<String> _reportReasons = [
    'Inaccurate or misleading information',
    'Offensive, harmful, or inappropriate content',
    'Irrelevant or nonsensical response',
    'Harassment',
    'Other (please specify)'
  ];

  // State to track if report modal is open
  bool _isReportModalOpen = false;
  
  // State to track if this is the first time loading messages
  bool _isFirstLoad = true;
  
  // State to track previous message count for auto-scroll
  int _previousMessageCount = 0;

  Future<String?> getNameUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('name'); // Assuming 'name' is the key for the user's name
  }

  // Copy message to clipboard
  void _copyMessage(String text, [int? messageIndex]) {
    Clipboard.setData(ClipboardData(text: text));
    if (messageIndex != null) {
      setState(() {
        _copiedMessages[messageIndex] = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _copiedMessages[messageIndex] = false;
          });
        }
      });
    }
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Message copied to clipboard'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  // Regenerate the last AI message
  void _regenerateMessage() {
    BlocProvider.of<ChatCubit>(context).regenerateMessage(
      message_to: _selectedMode == ChatMode.coach ? "coach" : "ai"
    );
  }

  // Toggle like status
  void _toggleLike(int messageIndex,String conversationId,String feedback) {
    setState(() {
      if (isMessageLiked(messageIndex,feedback)) {
        BlocProvider.of<ChatCubit>(context).likeDislikeMessage(conversationId, null);
        _likedMessages[messageIndex] = false;
      } else {
        _likedMessages[messageIndex] = true;
        BlocProvider.of<ChatCubit>(context).likeDislikeMessage(conversationId, "like");
        _dislikedMessages[messageIndex] = false; // Remove dislike if liked
      }
    });
  }

  // Toggle dislike status
  void _toggleDislike(int messageIndex,String conversationId,String feedback) {
    setState(() {
      if (isMessageDisliked(messageIndex,feedback)) {
        BlocProvider.of<ChatCubit>(context).likeDislikeMessage(conversationId, null);
        _dislikedMessages[messageIndex] = false;
      } else {
        _dislikedMessages[messageIndex] = true;
        _likedMessages[messageIndex] = false; 
        BlocProvider.of<ChatCubit>(context).likeDislikeMessage(conversationId, "dislike");// Remove like if disliked
      }
    });
  }

  void _sendMessage(image) async {
    if (_controller.text.isNotEmpty) {
      final now = DateTime.now();
      final formattedTime =
          "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

      // Get the user's name from SharedPreferences
      String? userName = await getNameUser();
      BlocProvider.of<ChatCubit>(context)
          .sendMessage(_controller.value.text, "data:image/png;base64,$image", 
              message_to: _selectedMode == ChatMode.coach ? "coach" : "ai");
      _controller.clear();
      _scrollToBottom();
    }
  }

  final ScrollController _scrollController = ScrollController(); // Step 1

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Show report bottom modal
  void _showReportModal() {
    _selectedReportReason = null;
    _reportDetailsController.clear();
    
    widget.onReportModalChanged?.call(true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        // Add listener to detect when modal is dismissed
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _isReportModalOpen = false;
            });
          }
        });
        
        return WillPopScope(
          onWillPop: () async {
            setState(() {
              _isReportModalOpen = false;
            });
            return true;
          },
          child: Container(
            height:450,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 40,
                //   height: 4,
                //   margin: const EdgeInsets.only(top: 10),
                //   decoration: BoxDecoration(
                //     color: Colors.grey[300],
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40), // Empty space to center the title
                    Expanded(
                      child: Center(
                        child: Text(
                          'Report AI Response',
                          style: AppTextStyles.headline5,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          'assets/close-circle.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text("Tell us what was wrong with this response.", style: AppTextStyles.body2,),
                const SizedBox(height: 20),
                Text(
                  'Reason for Reporting',
                  style:AppTextStyles.headline6,
                ),
                const SizedBox(height: 10),
                Container(
                  // height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray50),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedReportReason,
                    dropdownColor: Colors.white,
                    style: AppTextStyles.body2,
                    // alignment: Alignment.center,

                    decoration: const InputDecoration(
                      
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2)
                    ),
                    hint: Text('Select a reason', style: AppTextStyles.hint,),
                    items: _reportReasons.map((String reason) {
                      return DropdownMenuItem<String>(
                        value: reason,
                        child: Text(reason, style: AppTextStyles.body2,),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedReportReason = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Additional Details (optional)',
                  style:AppTextStyles.headline6,
                ),        
                const SizedBox(height: 10),
                TextField(
                  controller: _reportDetailsController,
                  maxLines: 5,
                  style: AppTextStyles.body2,
                  decoration: InputDecoration(
                    hintStyle: AppTextStyles.hint,
                    hintText: 'Describe the issue in more detail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.gray50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.gray50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.gray50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap:  () {
                        setState(() {
                          _isReportModalOpen = false;
                        });
                        BlocProvider.of<ChatCubit>(context).ReportMessage(conversationIdReport, _selectedReportReason!, _reportDetailsController.text);
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 2), () {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            });
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(24, 39, 75, 0.08),
                                          blurRadius: 24,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset("assets/iconTick.svg",width: 16,height: 16),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Your feedback has been submitted.',
                                          style: TextStyle(color:  AppColors.textPrimary, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    width:double.infinity ,
                    // margin:
                    //     EdgeInsets.symmetric(horizontal: size.width / 10),
                    decoration: BoxDecoration(
                        color: AppColors.mainSecandaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    // width: size.width,
                    child: Text(
                      "Submit Report",
                      style: AppTextStyles.hintWhite,
                    ),
                  ),
                ),
            
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //       onPressed: _selectedReportReason != null
                //           ? () {
                //               setState(() {
                //                 _isReportModalOpen = false;
                //               });
                //               Navigator.pop(context);
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(
                //                   content: Text('Report submitted: ${_selectedReportReason}'),
                //                   duration: const Duration(seconds: 2),
                //                 ),
                //               );
                //             }
                //           : null,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.purpleDark,
                //       padding: const EdgeInsets.symmetric(vertical: 12),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //     child: const Text(
                //       'Submit Report',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
              
              ],
            ),
          ),
        ));
      },
    ).whenComplete(() {
      widget.onReportModalChanged?.call(false);
    });
  }



  @override
  void initState() {
    super.initState();
    // Remove the auto-scroll listener to prevent unwanted scrolling on like/dislike
    // _scrollController.addListener(() {
    //   if (_scrollController.position.atEdge &&
    //       _scrollController.position.pixels != 0) {
    //     _scrollToBottom();
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        // height: size.height,
        width: size.width,
        child: Container(
          // width: size.width > 440 ? 440 : size.width,
          margin: EdgeInsets.only(top: size.height * .02),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isDropdownOpen ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ] : null,
                        ),
                        child: DropdownButton<ChatMode>(
                          value: _selectedMode,
                          underline: const SizedBox(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: const Color(0xFF383838),
                            size: 20,
                          ),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: [
                            DropdownMenuItem(
                              value: ChatMode.ai,
                              child: Text(
                                "AI Copilot",
                                style: const TextStyle(
                                  color: Color(0xFF383838),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: ChatMode.coach,
                              child: Text(
                                "Coach",
                                style: const TextStyle(
                                  color: Color(0xFF383838),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (ChatMode? newValue) async {
                            if (newValue != null) {
                              setState(() {
                                _selectedMode = newValue;
                                _isDropdownOpen = false;
                                _isFirstLoad = true; // Reset for new mode
                                _previousMessageCount = 0; // Reset message count for new mode
                              });
                              // Clear messages and get history for the new mode
                              BlocProvider.of<ChatCubit>(context).clearMessages(messageType: _selectedMode == ChatMode.coach ? "coach" : "ai");
                              BlocProvider.of<ChatCubit>(context).getHistoryChat(messageType: _selectedMode == ChatMode.coach ? "coach" : "ai");
                            }
                          },
                          onTap: () {
                            setState(() {
                              _isDropdownOpen = !_isDropdownOpen;
                            });
                          },
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.notifications_none_outlined,
                      //       color: AppColors.purpleDark,
                      //     ),
                      //     const SizedBox(width: 10),
                      //     SvgPicture.asset(
                      //       "assets/notificationIcon.svg",
                      //       width: 25,
                      //       height: 25,
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatHistoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChatHistoryLoaded) {
                        if (state.messages.isEmpty) {
                          return SizedBox(
                            height: size.height * .65,
                            child: Center(
                              child: SvgPicture.asset("assets/empty.svg"),
                            ),
                          );
                        } else {
                          // Scroll to bottom when message count changes (new message added)
                          if (state.messages.length != _previousMessageCount) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              if (mounted && _scrollController.hasClients) {
                                _scrollToBottom();
                              }
                            });
                            _previousMessageCount = state.messages.length;
                          }
                          return Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                var message = state.messages[index];
                                return _buildMessageBubble(
                                    message.text,
                                    message.sender,
                                    message.time,
                                    message.avatarUrl,
                                    message.images.isNotEmpty
                                        ? message.images[0]
                                        : "",
                                    index,message.conversation_id,message.feedback,message.reported);
                              },
                            ),
                          );
                        }
                      } else if (state is ChatHistoryError ||
                          state is ChatError) {
                        // Handle errors with messages
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    context.read<ChatCubit>().messages.length,
                                itemBuilder: (context, index) {
                                  final message =
                                      context.read<ChatCubit>().messages[index];
                                  return _buildMessageBubble(
                                      message.text,
                                      message.sender,
                                      message.time,
                                      message.avatarUrl,
                                      message.images.isNotEmpty
                                          ? message.images[0]
                                          : "",
                                      index,message.conversation_id,message.feedback,message.reported);
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                "An error occurred. Unable to load new messages.",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                            child: Text("No messages available."));
                      }
                    },
                    listener: (context, state) {
                      // if (state is ChatHistoryError || state is ChatError) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("Internet error")),
                      //   );
                      // }
                    },
                  ),
                  const SizedBox(height: 120),
                ],
              ),
              BlocBuilder<ImageHandlerCubit, ImageHandlerState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 30,
                    width: 320,
                    //  > 420 ? 400 : size.width * .9,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 5),
                      height: state is HaveImage ? 110 : 58,
                      child: Material(
                        color: AppColors.mainBg,
                        elevation: 15,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        shadowColor: AppColors.mainShadow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (state is HaveImage)
                              Row(
                                children: [
                                  Container(
                                    width: 51,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.purpleDark),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image.memory(
                                        state.imageByte,
                                        fit: BoxFit.cover,
                                        width: 51,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<ImageHandlerCubit>(
                                                context)
                                            .DeletImage();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/close-circle.svg",
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      )),
                                ],
                              ),
                            if (state is HaveImage)
                              const SizedBox(height: 5,),
                            TextFormField(
                              controller: _controller,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.hint,
                                hintText: "Ask me anything...",
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset('assets/send-2.svg',width: 24,height: 24),
                                  onPressed: () {
                                    _sendMessage(state is HaveImage
                                        ? state.imageBase64
                                        : "");
                                    BlocProvider.of<ImageHandlerCubit>(context)
                                        .DeletImage();
                                  },
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildMessageBubble(String text, String sender, String time,
      String avatarUrl, String imageBase64, int messageIndex,String conversationId,String feedback,bool reported) {
    // setState(() {
    //   _dislikedMessages[messageIndex] = feedback == "dislike" ? true : false;
    //   _likedMessages[messageIndex] = feedback == "like" ? true : false;

    // });
    if (sender == "User") {
      String cleanBase64 =
          imageBase64.replaceFirst('data:image/png;base64,', '');
      Uint8List bytesImage = base64Decode(cleanBase64);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                                              Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(
                              time,
                              style: AppTextStyles.titleMedium
                                  .copyWith(color: Colors.grey),
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(width: 8),
                            FutureBuilder<String?>(
                              future: getNameUser(),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data ?? "User",
                                  style: AppTextStyles.title2
                                      .copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                );
                              },
                            ),
                          ],
                        ),
                      const SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 255,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              text,
                              style: AppTextStyles.titleMedium,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (bytesImage.isNotEmpty)
                            Container(
                              width: 120,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.purpleDark),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10)), // Match the container's border radius
                                child: Image.memory(
                                  bytesImage, // Your base64 decoded image bytes
                                  fit: BoxFit.cover, // Ensures the image scales to cover the area
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                FutureBuilder<String?>(
                  future: getNameUser(),
                  builder: (context, snapshot) {
                    String initials = "U";
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      initials = snapshot.data![0].toUpperCase();
                    }
                    return CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.purpleDark,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            // Icon row outside the bubble
          ],
        ),
      );
    } else {
      String cleanBase64 =
          imageBase64.replaceFirst('data:image/png;base64,', '');
      Uint8List bytesImage = base64Decode(cleanBase64);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: reported ? 0.5 : 1.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.gray50, // or any color you want for the border
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor:_selectedMode == ChatMode.coach?AppColors.purpleDark : AppColors.bgScreen,
                      child: _selectedMode == ChatMode.coach ?
                      Text(
                            _selectedMode == ChatMode.coach ? "C" : "A",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )          
                      : SvgPicture.asset(
                        "assets/aiAssistant.svg",
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      // child: Text(
                      //   _selectedMode == ChatMode.coach ? "C" : "A",
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ),
                  ),
                 
                 const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(
                              _selectedMode == ChatMode.coach ? "Coach" : "AI Copilot",
                              style: AppTextStyles.title2
                                  .copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              time.split(' ')[1],
                              style: AppTextStyles.titleMedium
                                  .copyWith(color: Colors.grey),
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                        const SizedBox(height: 0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 255,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                text,
                                style: AppTextStyles.titleMedium,
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                            // const SizedBox(height: 20),
                            if (bytesImage.isNotEmpty)
                              Container(
                                width: 120,
                                // height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.purpleDark),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.memory(
                                    bytesImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Icon row outside the bubble
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Copy button - available for both AI and Coach

                  // Like, Dislike, and More buttons - only for AI Assistant
                  if (_selectedMode == ChatMode.ai) ...[
                    // Regenerate button - only for the last AI message
                    if (messageIndex == context.read<ChatCubit>().messages.length - 1) ...[
                      Opacity(
                        opacity: reported ? 0.5 : 1.0,
                        child:GestureDetector(
                          onTap: reported ? null : () => _regenerateMessage(),
                          child: Container(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset('assets/refresh-2.svg',width: 16,height: 16)
                        ),
                      ),
                      ),                    
                      const SizedBox(width: 2),
                    ],
                    Opacity(
                      opacity: reported ? 0.5 : 1.0,
                      child:GestureDetector(
                        onTap: reported ? null : () => _copyMessage(text, messageIndex),
                        child: Container(
                        padding: const EdgeInsets.all(4),
                        child: _copiedMessages[messageIndex] == true
                          ? SvgPicture.asset('assets/tickNormal.svg',width: 10,height: 10)
                          : SvgPicture.asset('assets/copy.svg',width: 16,height: 16)
                      ),
                    ),
                    ),                    
                    const SizedBox(width: 2),
                    Opacity(
                      opacity: reported ? 0.5 : 1.0,
                      child: GestureDetector(
                        onTap: reported ? null : () => {
                          _toggleLike(messageIndex,conversationId,feedback),
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: isMessageLiked(messageIndex,feedback)?SvgPicture.asset('assets/likefill.svg',width: 16,height: 16):SvgPicture.asset('assets/like.svg',width: 16,height: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Opacity(
                      opacity: reported ? 0.5 : 1.0,
                      child: GestureDetector(
                        onTap: reported ? null : () => {
                          _toggleDislike(messageIndex,conversationId,feedback),
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: isMessageDisliked(messageIndex,feedback)?
                          SvgPicture.asset('assets/dislikeFill.svg',width: 16,height: 16):
                          SvgPicture.asset('assets/dislike.svg',width: 16,height: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Opacity(
                      opacity: reported ? 0.5 : 1.0,
                      child: reported ? Container(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset('assets/treepoint.svg')
                      ) : PopupMenuButton<String>(
                        icon: SvgPicture.asset('assets/treepoint.svg'),
                        onSelected: (value) {
                          if (value == 'report') {
                            _showReportModal();
                            conversationIdReport = conversationId;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'report',
                            height: 30,
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                'Report',
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Show feedback text for reported messages - only for AI Assistant
            if (reported && _selectedMode == ChatMode.ai)
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/danger.svg",
                      width: 16,
                      height: 16,
                      // color: Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "You reported this message. Thank you for your feedback.",
                        style: AppTextStyles.body2.copyWith(
                          color: Color.fromRGBO(136, 136, 136, 1.0),
                          fontSize: 11,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    }
  }

  bool isMessageDisliked(int messageIndex,String feedback) {
    if (_dislikedMessages.containsKey(messageIndex)) {
      return _dislikedMessages[messageIndex] == true;
    } else {
      return feedback == "dislike" ? true : false; // or false, or any value you want
    }
  }
  bool isMessageLiked(int messageIndex,String feedback) {
    if (_likedMessages.containsKey(messageIndex)) {
      return _likedMessages[messageIndex] == true;
    } else {
      return feedback == "like" ? true : false; // or false, or any value you want
    }
  }
}
