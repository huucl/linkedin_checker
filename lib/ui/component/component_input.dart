import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chrome_app/utils/style/style.dart';
import 'package:get/get.dart';

class ComponentInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool? isPasswordForm;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? customSuffixWidget;
  final String? errorMessage;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isHideBorderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? prefixIcon;

  // region for button only
  final bool? isButton;
  final bool? withDropDownIcon;
  final VoidCallback? onButtonClick;
  final String? currentValue;
  final bool? isDisable;

  //endregion

  const ComponentInput({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.validator,
    this.isPasswordForm = false,
    this.keyboardType = TextInputType.text,
    this.customSuffixWidget,
    this.errorMessage,
    this.textInputAction,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.inputFormatters,
    this.isHideBorderColor,
    this.withDropDownIcon,
    this.isButton = false,
    this.onButtonClick,
    this.currentValue,
    this.isDisable = false,
    this.backgroundColor,
    this.textStyle,
    this.prefixIcon,
  });

  @override
  State<ComponentInput> createState() => _ComponentInputState();
}

class _ComponentInputState extends State<ComponentInput> {
  bool _isObscure = false;

  @override
  void initState() {
    _isObscure = widget.isPasswordForm ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isButton == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //region label if needed
          widget.label == null
              ? Container()
              : Text(
                  widget.label ?? '',
                  style: TextStyle(
                    color: theme.n800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          //endregion
          widget.label == null ? Container() : const SizedBox(height: 8),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () {
              widget.isDisable == true ? null : _handleOnButtonClick();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              height: 44,
              width: Get.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.n300,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: widget.isDisable == true ? theme.n200 : theme.transparent),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getButtonDisplayText(),
                    style: _getButtonTextStyle(),
                  ),
                  _buildButtonSuffixIcon()
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //region label if needed
        widget.label == null
            ? Container()
            : Text(
                widget.label ?? '',
                style: TextStyle(
                  color: theme.n800,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        //endregion
        widget.label == null ? Container() : const SizedBox(height: 8),
        TextFormField(
          focusNode: widget.isDisable == true ? AlwaysDisabledFocusNode() : null,
          autovalidateMode: widget.autoValidateMode,
          obscureText: _isObscure,
          validator: widget.validator,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: widget.textStyle ??
              TextStyle(
                fontSize: 14,
                color: theme.n800,
                fontWeight: FontWeight.w500,
              ),
          textAlignVertical: widget.prefixIcon != null ? TextAlignVertical.center : null,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            contentPadding: const EdgeInsets.only(top: 14, bottom: 14, left: 16),
            hintText: widget.hintText ?? '',
            errorMaxLines: 5,
            hintStyle: TextStyle(
              fontSize: 14,
              color: theme.n600,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            errorStyle: TextStyle(
              fontSize: 12,
              color: theme.error400,
              fontWeight: FontWeight.w300,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: widget.isHideBorderColor == true ? Colors.transparent : theme.n300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: widget.isHideBorderColor == true ? Colors.transparent : theme.n300),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  width: 1,
                  color: theme.error400,
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                width: 1,
                color: theme.error400,
              ),
            ),
            suffixIcon: _getSuffixIcon(),
            suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
            fillColor: widget.backgroundColor ?? theme.n000,
            errorText: widget.errorMessage,
          ),
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }

  void _handleOnButtonClick() {
    if (widget.onButtonClick != null) {
      widget.onButtonClick!();
    }
  }

  String _getButtonDisplayText() {
    return '${widget.currentValue?.isNotEmpty == true ? widget.currentValue : widget.hintText}';
  }

  Widget? _getSuffixIcon() {
    if (widget.customSuffixWidget != null) {
      return widget.customSuffixWidget;
    }
    if (widget.isPasswordForm == true) {
      return InkWell(
        onTap: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(right: 4.0),
          child: _isObscure
              ? Icon(
                  Icons.remove_red_eye,
                  color: theme.n600,
                )
              : Icon(
                  Icons.visibility_off,
                  color: theme.n600,
                ),
        ),
      );
    } else {
      return null;
    }
  }

  TextStyle _getButtonTextStyle() {
    if (widget.currentValue?.isNotEmpty == true) {
      return TextStyle(
        fontSize: 14,
        color: theme.n800,
        fontWeight: FontWeight.w500,
      );
    }
    return TextStyle(
      fontSize: 14,
      color: theme.n600,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildButtonSuffixIcon() {
    if (widget.customSuffixWidget != null) {
      return widget.customSuffixWidget!;
    }
    return widget.withDropDownIcon == true ? Container() : Container();
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange}) : assert(decimalRange == 0 || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != 0) {
      String value = newValue.text;

      if (value.contains('.') && value.substring(value.indexOf('.') + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == '.') {
        truncated = '0.';

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(',')) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
