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
  final List<Message> _messages = [];

  Future<String?> getNameUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('name'); // Assuming 'name' is the key for the user's name
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final now = DateTime.now();
      final formattedTime =
          "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

      // Get the user's name from SharedPreferences
      String? userName = await getNameUser();

      BlocProvider.of<ChatCubit>(context).sendMessage(_controller.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        child: Container(
          width: size.width > 440 ? 440 : size.width,
          margin: EdgeInsets.only(top: size.height * .02),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                  BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatHistoryLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final message = state.messages[index];
                              return _buildMessageBubble(
                                message.text,
                                message.sender,
                                message.time,
                                message.avatarUrl,
                              );
                            },
                          ),
                        );
                      }
                      if (state is ChatHistoryLoading) {
                        return Text("ChatHistoryLoading");
                      }
                      if(state is ChatLoading){
                        return _buildMessageBubble(
                          "message.text",
                          "message.sender",
                          "message.time",
                          "message.avatarUrl",
                        );
                      }
                      else {
                        return Center(
                          child: Text("have error"),
                        );

                      }
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 50,
                width: size.width > 420 ? 400 : size.width * .9,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Material(
                    color: AppColors.mainBg,
                    elevation: 15,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    shadowColor: AppColors.mainShadow,
                    child: TextFormField(
                      controller: _controller,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.hint,
                        hintText: "Ask me anything...",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColors.purpleDark,
                          ),
                          onPressed: _sendMessage,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildMessageBubble(
      String text, String sender, String time, String avatarUrl) {
    if (sender == "User") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/40"),
              radius: 20,
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
                ],
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/40"),
              radius: 20,
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
                        time,
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

class Message {
  final String text;
  final String sender;
  final String time;
  final String avatarUrl;

  Message({
    required this.text,
    required this.sender,
    required this.time,
    required this.avatarUrl,
  });
}
