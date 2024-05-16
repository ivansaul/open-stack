import 'dart:io';

import 'package:file_picker/file_picker.dart';

class ImagePickerService {
  /// List of allowed image extensions for file selection.
  List<String> get _allowedExtensions => [
        'png',
        'jpg',
        'jpeg',
        'gif',
        'webp',
        'PNG',
        'JPG',
        'JPEG',
        'GIF',
        'WEBP',
      ];

  /// Picks an image from the device's gallery.
  /// Returns a [File] if an image is selected, otherwise returns null.
  Future<File?> pickFromGallery() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return null;
    File file = File(result.files.single.path!);
    return file;
  }

  /// Picks an image from the device's file system with allowed extensions.
  /// Returns a [File] if an image is selected, otherwise returns null.
  Future<File?> pickFromFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
    );

    if (result == null) return null;
    File file = File(result.files.single.path!);
    return file;
  }
}
