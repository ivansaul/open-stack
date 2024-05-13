import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/auth/data/auth_repository_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_profile_form_provider.g.dart';
part 'edit_profile_form_provider.mapper.dart';

enum EditProfileFormControl {
  name('name'),
  username('username'),
  ;

  final String key;
  const EditProfileFormControl(this.key);
}

@riverpod
class EditProfileForm extends _$EditProfileForm {
  late FormGroup _formGroup;
  @override
  EditProfileFormState build() {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    _formGroup = FormGroup({
      EditProfileFormControl.name.key: FormControl<String>(
        value: currentUser?.name,
      ),
      EditProfileFormControl.username.key: FormControl<String>(
        value: currentUser?.username,
        validators: [
          Validators.required,
        ],
      ),
    });

    _listenFormChanges();

    return EditProfileFormState(
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
}

@MappableClass()
class EditProfileFormState with EditProfileFormStateMappable {
  EditProfileFormState({
    required this.formGroup,
    this.isValid = false,
    this.isDirty = false,
    this.value = const {},
  });

  final FormGroup formGroup;
  final bool isValid;
  final bool isDirty;
  final Map<String, dynamic> value;

  static const fromMap = EditProfileFormStateMapper.fromMap;
  static const fromJson = EditProfileFormStateMapper.fromJson;
}
