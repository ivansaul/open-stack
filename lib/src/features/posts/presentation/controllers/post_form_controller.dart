import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/constants/enums.dart';
import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:openstack/src/services/picker/image_picker_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_form_controller.g.dart';
part 'post_form_controller.mapper.dart';

enum PostFormControl {
  /// This control save the post title
  title('title'),

  /// This control save the post summary
  summary('summary'),

  /// This control save the post source URL
  sourceUrl('source_url'),

  /// This control save the thumbnail file path
  thumbnailPath('thumbnail_path'),
  ;

  final String key;
  const PostFormControl(this.key);
}

@riverpod
class PostFormController extends _$PostFormController {
  late FormGroup _formGroup;
  @override
  PostFormState build({required PostEntity? post}) {
    _formGroup = FormGroup(
      {
        PostFormControl.title.key: FormControl<String>(
          value: post?.title,
          validators: [
            Validators.required,
          ],
        ),
        PostFormControl.sourceUrl.key: FormControl<String>(
          value: post?.sourceUrl,
          validators: [
            Validators.pattern(
              RegExp(Constants.patternsUrl),
              validationMessage: 'Invalid URL',
            ),
          ],
        ),
        PostFormControl.summary.key: FormControl<String>(
          value: post?.summary,
        ),
        PostFormControl.thumbnailPath.key: FormControl<String>(),
      },
    );

    _listenFormChanges();

    return PostFormState(
      formGroup: _formGroup,
    );
  }

  void _listenFormChanges() {
    _formGroup.valueChanges.listen((event) {
      state = state.copyWith(
        isDirty: true,
        isValid: _formGroup.valid,
        value: _formGroup.value,
      );
    });
  }

  void unfocus() {
    _formGroup.unfocus();
  }

  Future<File?> pickImage(ImageSource source) async {
    final imagePicker = ref.read(imagePickerServiceProvider);
    final imageFile = await switch (source) {
      ImageSource.gallery => imagePicker.pickFromGallery(),
      ImageSource.files => imagePicker.pickFromFiles(),
    };
    _formGroup.control(PostFormControl.thumbnailPath.key).value =
        imageFile?.path;
    return imageFile;
  }
}

@MappableClass()
class PostFormState with PostFormStateMappable {
  PostFormState({
    required this.formGroup,
    this.isValid = false,
    this.isDirty = false,
    this.value = const {},
  });

  final FormGroup formGroup;
  final bool isValid;
  final bool isDirty;
  final Map<String, dynamic> value;

  static const fromMap = PostFormStateMapper.fromMap;
  static const fromJson = PostFormStateMapper.fromJson;
}
