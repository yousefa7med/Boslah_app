import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  GeminiService._privateConstructor();
  static final GeminiService instance = GeminiService._privateConstructor();

  /// ارسل رسالة مع شخصية Tour Guide + الرد بنفس لغة السؤال
  Future<String?> ask(String question) async {
    try {
      final response = await Gemini.instance.prompt(
        // model: 'gemini-2.5-flash-lite',
        parts: [
          // Part.text(
          //   "أنت مرشد سياحي خبير. جاوب بطريقة ودية ومفصلة. "
          //   "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\nالسؤال: $question",
          // ),
          // Part.text(
          //   "أنت مرشد سياحي خبير. جاوب بطريقة ودية وواضحة. "
          //   "انت بتكلم سائح و يجب عليك ان تزود السائح بمعلومات عن اماكن ليزورها في وجهته "
          //   "اكتب إجابة مختصرة، لكن تضمّن كل المعلومات المهمة فقط. "
          //   "استخدم جمل قصيرة ومباشرة. "
          //   "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\n"
          //   "السؤال: $question",
          // ),
          Part.text(
            "You are an expert tour guide. Answer in a friendly and clear way. "
            "Reply to the question in the same language the user wrote it in.\n"
            "You are talking to a tourist and you must provide the tourist with information about places to visit at their destination. "
            "Write a short answer, but include only the important information. "
            "Use short and direct sentences. "
            "Question: $question",
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
// import 'package:flutter_gemini/flutter_gemini.dart';

// class GeminiService {
//   GeminiService._privateConstructor();
//   static final GeminiService instance = GeminiService._privateConstructor();
//
//   final String primaryModel = "gemini-2.5-flash"; // الموديل الرئيسي
//   final String fallbackModel = "gemini-2.5-flash-lite"; // لو في Limit Exceeded
//
//   Future<String?> ask(String question) async {
//     try {
//       // -------- First Attempt with Primary Model --------
//       final response = await Gemini.instance.prompt(
//         model: primaryModel,
//         parts: [
//           Part.text(
//             "أنت مرشد سياحي خبير. جاوب بطريقة ودية وواضحة. "
//             "انت بتكلم سائح و يجب عليك ان تزود السائح بمعلومات عن اماكن ليزورها في وجهته "
//             "اكتب إجابة مختصرة، لكن تضمّن كل المعلومات المهمة فقط. "
//             "استخدم جمل قصيرة ومباشرة. "
//             "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\n"
//             "السؤال: $question",
//           ),
//         ],
//       );
//
//       return response?.output;
//     } catch (e) {
//       print("Primary model failed: $e");
//
//       // -------- Detect 429 Too Many Requests --------
//       if (e.toString().contains("429")) {
//         print("⚠ Limit exceeded → switching to fallback model...");
//
//         try {
//           // -------- Retry with Fallback Model --------
//           final fallbackResponse = await Gemini.instance.prompt(
//             model: fallbackModel,
//             parts: [
//               Part.text(
//                 "أنت مرشد سياحي خبير. جاوب بطريقة ودية وواضحة. "
//                 "انت بتكلم سائح و يجب عليك ان تزود السائح بمعلومات عن اماكن ليزورها في وجهته "
//                 "اكتب إجابة مختصرة، لكن تضمّن كل المعلومات المهمة فقط. "
//                 "استخدم جمل قصيرة ومباشرة. "
//                 "رد على السؤال بنفس اللغة التي كتب بها المستخدم.\n"
//                 "السؤال: $question",
//               ),
//             ],
//           );
//
//           return fallbackResponse?.output;
//         } catch (e2) {
//           print("Fallback model failed: $e2");
//         }
//       }
//
//       return null;
//     }
//   }
// }
