import 'dart:async';
import 'dart:html' as html;

class CameraService {
  static Future<String?> pickImageWeb() async {
    final completer = Completer<String?>();

    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        final base64Image = reader.result.toString();
        completer.complete(base64Image);
      });

      reader.readAsDataUrl(file);
    });

    return completer.future;
  }
}
