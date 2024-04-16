import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form_group_provider.g.dart';

enum AuthFormControl {
  email,
  username,
  password,
  rePassword,
}

/// Creates and provides a [FormGroup] for the login form.
///
/// This form group contains two [FormControl]s for email and password, each with
/// their respective set of validators to ensure the input is valid.
///
/// The [AuthFormControl.email] requires a valid email and cannot be empty.
/// The [AuthFormControl.password] requires at least 6 characters and cannot be empty.
///
@Riverpod(keepAlive: false)
FormGroup loginFormGroup(LoginFormGroupRef ref) {
  return FormGroup({
    AuthFormControl.email.name: FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    AuthFormControl.password.name: FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(6),
      ],
    ),
  });
}
