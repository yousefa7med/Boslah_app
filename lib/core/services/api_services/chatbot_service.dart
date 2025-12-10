import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  GeminiService._privateConstructor();
  static final GeminiService instance = GeminiService._privateConstructor();

  /// ارسل رسالة مع شخصية Tour Guide + الرد بنفس لغة السؤال
  Future<String?> ask(String question) async {
    try {
      final response = await Gemini.instance.prompt(
        parts: [
          // Part.text(
          //   "أنت مرشد سياحي خبير. جاوب بطريقة ودية ومفصلة. "
          //   "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\nالسؤال: $question",
          // ),
          Part.text(
            "أنت مرشد سياحي خبير. جاوب بطريقة ودية وواضحة. "
            "انت بتكلم سائح و يجب عليك ان تزود السائح بمعلومات عن اماكن ليزورها في وجهته "
            "اكتب إجابة مختصرة، لكن تضمّن كل المعلومات المهمة فقط. "
            "استخدم جمل قصيرة ومباشرة. "
            "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\n"
            "السؤال: $question",
          ),
        ],
      );
      return response?.output;
    } catch (e) {
      print("Gemini Error: $e");
      return null;
    }
  }
}
