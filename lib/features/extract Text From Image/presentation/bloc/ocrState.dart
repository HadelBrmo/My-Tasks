abstract class OcrState {}

class OcrInitial extends OcrState {}
class OcrLoading extends OcrState {}
class OcrSuccess extends OcrState {
  final String extractedText;
  OcrSuccess(this.extractedText);
}
class OcrFailure extends OcrState {
  final String errorMessage;
  OcrFailure(this.errorMessage);
}