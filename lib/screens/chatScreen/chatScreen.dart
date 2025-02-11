import 'dart:convert';
import 'dart:typed_data';

import 'package:copilet/screens/camera/imageHandlerCubit/cubit.dart';
import 'package:copilet/screens/camera/imageHandlerCubit/state.dart';
import 'package:copilet/screens/chatScreen/cubit/cubit.dart';
import 'package:copilet/screens/chatScreen/cubit/cubit.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final TextEditingController _controller = TextEditingController();

  Future<String?> getNameUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('name'); // Assuming 'name' is the key for the user's name
  }

  void _sendMessage(image) async {
    if (_controller.text.isNotEmpty) {
      final now = DateTime.now();
      final formattedTime =
          "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

      // Get the user's name from SharedPreferences
      String? userName = await getNameUser();
      BlocProvider.of<ChatCubit>(context)
          .sendMessage(_controller.value.text, "data:image/png;base64,$image");
      _controller.clear();
      _scrollToBottom();
    }
  }

  final ScrollController _scrollController = ScrollController(); // Step 1

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    // Add a listener to automatically scroll when messages are added
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        _scrollToBottom();
      }
    });
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
                      Text(
                        "AI Copilot",
                        style: AppTextStyles.title1,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            color: AppColors.purpleDark,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/notificationIcon.svg",
                            width: 25,
                            height: 25,
                          ),
                        ],
                      )
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
                          // Ensure scrolling after messages are loaded
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollToBottom();
                          });
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
                                        : "");
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
                                          : "");
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
                      if (state is ChatHistoryError || state is ChatError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Internet error")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 120),
                ],
              ),
              BlocBuilder<ImageHandlerCubit, ImageHandlerState>(
                builder: (context, state) {
                  return Positioned(
                    bottom: 50,
                    width: 400,
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
                                  icon: const Icon(
                                    Icons.send,
                                    color: AppColors.purpleDark,
                                  ),
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
      String avatarUrl, String imageBase64) {
    if (sender == "User") {
      String cleanBase64 =
          imageBase64.replaceFirst('data:image/png;base64,', '');
      Uint8List bytesImage = base64Decode(cleanBase64);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000), // Image border

              child: Image.asset(
                "assets/man2.png",
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        sender,
                        style: AppTextStyles.title2
                            .copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: AppTextStyles.titleMedium
                            .copyWith(color: Colors.grey),
                        textDirection: TextDirection.rtl,
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
                          textDirection: TextDirection.rtl,
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
                                Radius.circular(
                                    10)), // Match the container's border radius
                            child: Image.memory(
                              bytesImage, // Your base64 decoded image bytes
                              fit: BoxFit
                                  .cover, // Ensures the image scales to cover the area
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
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            CircleAvatar(
              radius: 20,
              child: SvgPicture.asset("assets/AiPic.svg"),
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
                        sender,
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
                  const SizedBox(height: 5),
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
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
