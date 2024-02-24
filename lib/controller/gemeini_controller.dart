import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiController extends GetxController {
  static GeminiController get to => Get.find();

  GenerativeModel? model;

  @override
  void onInit() {
    super.onInit();

    final apiKey = dotenv.get('GEMINI_API_KEY');

    // ignore: unnecessary_null_comparison
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
    }

    this.model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(),
    );
  }

  Stream<GenerateContentResponse> generateText(String prompt) {
    try {
      if (this.model == null) {
        throw 'Model not initialized... try again.';
      }
      final content = [Content.text(prompt)];
      final response = this.model?.generateContentStream(content);

      if (response == null) {
        throw 'response is null';
      }
      return response;
    } catch (e) {
      print('Error during generateText: $e');
      return Stream.empty();
    }
  }
}
