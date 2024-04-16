import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/theme/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OutlineReactiveTextField extends HookWidget {
  final String formControlName;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool obscureText;

  const OutlineReactiveTextField({
    super.key,
    required this.formControlName,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(obscureText);
    return ReactiveTextField(
      formControlName: formControlName,
      style: context.textTheme.body1Medium.tsColor(context.colors.brandBlack),
      cursorColor: context.colors.brandBlueDeep,
      cursorHeight: 20,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.greyGrey150,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        hintText: hintText,
        hintStyle:
            context.textTheme.body1Medium.tsColor(context.colors.brandBlueDeep),
        border: _buildBorder(context.colors.brandBlack),
        focusedBorder: _buildBorder(context.colors.brandBlack),
        enabledBorder: _buildBorder(context.colors.greyGrey200),
        errorBorder: _buildBorder(context.colors.generalRed),
        focusedErrorBorder: _buildBorder(context.colors.brandBlack),
        prefixIcon: prefixIcon,
        prefixIconColor: context.colors.brandBlueDeep,
        suffixIconColor: context.colors.brandBlueDeep,
        suffixIcon: (obscureText)
            ? IconButton(
                onPressed: () => isObscure.value = !isObscure.value,
                icon: Icon(
                  isObscure.value
                      ? AppIcons.eye_outlined
                      : AppIcons.eye_outlined_off,
                ),
              )
            : null,
      ),
      keyboardType: keyboardType,
      obscureText: isObscure.value,
    );
  }
}

OutlineInputBorder _buildBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      width: 2,
      color: color,
    ),
  );
}
