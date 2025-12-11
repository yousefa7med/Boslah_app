import 'package:Boslah/core/functions/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../core/utilities/app_colors.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: !isDark() ? Colors.black : Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            const Text(
              "Chatbot",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    "Online",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => Chat(
              messages: controller.messages.value,
              onSendPressed: (types.PartialText msg) {
                controller.sendUserMessage(msg.text);
              },
              user: const types.User(id: 'user'),
              theme: const DefaultChatTheme(
                backgroundColor: Color.fromARGB(19, 28, 28, 34),
                primaryColor: AppColors.main,
                sentMessageBodyTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                secondaryColor: Color(0xFFE9ECF1),
                receivedMessageBodyTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                inputBackgroundColor: Colors.blueGrey,
                inputTextColor: Colors.white,
                inputMargin: EdgeInsets.all(12),
                inputBorderRadius: BorderRadius.all(Radius.circular(25)),
                messageInsetsVertical: 16,
                messageInsetsHorizontal: 16,
              ),
              // removed customMessageBuilder to disable image previews
            ),
          ),

          // Loading indicator when bot is thinking
          Obx(() {
            if (controller.isLoading.value) {
              return const Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
