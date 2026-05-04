import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionService {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> recognizeTextFromImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return "لم يتم اختيار صورة";

    final inputImage = InputImage.fromFilePath(image.path);

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;

    textRecognizer.close();

    return text.isEmpty ? "لم يتم العثور على نص في الصورة" : text;
  }
}