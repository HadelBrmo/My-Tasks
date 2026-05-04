import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytasks/features/extract%20Text%20From%20Image/presentation/bloc/ocrEvent.dart';
import 'package:mytasks/features/extract%20Text%20From%20Image/presentation/bloc/ocrState.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  OcrBloc() : super(OcrInitial()) {
    on<PickImageFromGallery>((event, emit) async {
      emit(OcrLoading());
      try {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);

        if (image == null) {
          emit(OcrInitial());
          return;
        }

        final inputImage = InputImage.fromFilePath(image.path);
        final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
        emit(OcrSuccess(recognizedText.text));
      } catch (e) {
        emit(OcrFailure("فشل استخراج النص: $e"));
      }
    });

    on<PickImageAndExtractText>((event, emit) async {
      emit(OcrLoading());
      try {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: event.fromCamera ? ImageSource.camera : ImageSource.gallery,
        );

        if (image == null) {
          emit(OcrInitial());
          return;
        }

        final inputImage = InputImage.fromFilePath(image.path);
        final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
        emit(OcrSuccess(recognizedText.text));
      } catch (e) {
        emit(OcrFailure("فشل استخراج النص: $e"));
      }
    });
  }

  @override
  Future<void> close() {
    _textRecognizer.close(); 
    return super.close();
  }
}