abstract class OcrEvent {}

class PickImageFromGallery extends OcrEvent {}

class PickImageAndExtractText extends OcrEvent {
  final bool fromCamera;
  PickImageAndExtractText({required this.fromCamera});
}