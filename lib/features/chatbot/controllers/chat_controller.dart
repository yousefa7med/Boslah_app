import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../core/services/api_services/chatbot_service.dart';

class ChatController extends GetxController {
  // Observable list للرسائل
  var messages = <types.Message>[].obs;

  // Loading indicator
  var isLoading = false.obs;

  final GeminiService _service = GeminiService.instance;

  /// ارسال رسالة المستخدم واضافة الرسالة للقائمة
  void sendUserMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = types.TextMessage(
      author: const types.User(id: 'user'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: text,
    );

    // ادخال الرسالة في اول القائمة (لتظهر اعلى)
    messages.insert(0, userMessage);

    // ارسال الرسالة للروبوت
    sendBotMessage(text);
  }

  /// ارسال رسالة للبوت والحصول على الرد من Gemini
  void sendBotMessage(String userText) async {
    isLoading.value = true;

    final reply = await _service.ask(userText);

    if (reply != null && reply.isNotEmpty) {
      final botMessage = types.TextMessage(
        author: const types.User(id: 'bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(),
        text: reply,
      );

      messages.insert(0, botMessage);
    } else {
      // رسالة خطأ بسيطة لو مفيش رد
      final errorMessage = types.TextMessage(
        author: const types.User(id: 'bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(),
        text: 'عذراً، حدث خطأ ولم يتم الحصول على رد.',
      );
      messages.insert(0, errorMessage);
    }

    isLoading.value = false;
  }
}
