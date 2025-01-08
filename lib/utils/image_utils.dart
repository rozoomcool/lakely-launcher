import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageUtils {
  static Uint8List convertToGrayscale(Uint8List originalImageData) {
    // Декодируем Uint8List в объект изображения
    final image = img.decodeImage(originalImageData);
    if (image == null) {
      throw Exception("Не удалось декодировать изображение");
    }

    // Преобразуем изображение в черно-белое
    final grayscaleImage = img.grayscale(image);

    // Кодируем изображение обратно в Uint8List
    return Uint8List.fromList(img.encodePng(grayscaleImage));
  }
}