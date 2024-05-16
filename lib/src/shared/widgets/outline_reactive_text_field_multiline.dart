import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OutlineReactiveTextFieldMultiline extends StatelessWidget {
  final String formControlName;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;
  final bool expands;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  const OutlineReactiveTextFieldMultiline({
    super.key,
    required this.formControlName,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = true,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      maxLength: maxLength,
      formControlName: formControlName,
      style: context.textTheme.body1Medium.tsColor(context.colors.brandBlack),
      cursorColor: context.colors.brandBlueDeep,
      cursorHeight: 20,
      obscuringCharacter: '●',
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        required maxLength,
      }) {
        if (maxLength == null || currentLength == 0 || !isFocused) {
          return null;
        }
        return Text(
          '${maxLength - currentLength} / $maxLength',
          style: context.textTheme.bodyCaptionRegular,
        );
      },
      decoration: InputDecoration(
        isDense: isDense,
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
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
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
