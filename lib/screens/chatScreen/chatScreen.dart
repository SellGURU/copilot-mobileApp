import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final now = DateTime.now();
      final formattedTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

      setState(() {
        _messages.add(Message(
          text: _controller.text,
          sender: "Michael Gough",
          time: formattedTime,
          avatarUrl: "https://via.placeholder.com/40", // Placeholder image URL
        ));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(
                      message.text,
                      message.sender,
                      message.time,
                      message.avatarUrl,
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            width: size.width > 420 ? 380 : size.width * .9,
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
    );
  }

  Widget _buildMessageBubble(String text, String sender, String time, String avatarUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
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
                      style: AppTextStyles.title2.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,

                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: AppTextStyles.titleMedium.copyWith(color: Colors.grey),
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
