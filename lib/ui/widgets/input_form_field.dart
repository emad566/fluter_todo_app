import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputFormField extends StatelessWidget {
  InputFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.parseErrors = const [],
    this.bgColor = Colors.black,
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.all(8.0),
    this.maxLines = 100,
    this.minLines = 1,
    this.isSHowClearIcon = true,
    this.expands = false,
    this.readOnly = false,
    this.borderColor = Colors.grey,
    this.suffix,
    this.enabled,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final Function? validator;

  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onTap;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  dynamic errors = const [];
  List<Widget> parseErrors = [];

  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color bgColor;
  final int maxLength;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final Widget? suffix;
  final bool readOnly;
  final bool? enabled;
  final bool isSHowClearIcon;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            maxLines: maxLines ?? 1,
            minLines: minLines,
            expands: expands,
            readOnly: readOnly,
            enabled: enabled,
            // maxLength: maxLength,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: (val) {
              return validator == null ? () {} : validator!(val);
            },
            onChanged: (val) {
              onChanged != null ? onChanged!(val) : null;
            },
            onFieldSubmitted: (val) {
              onFieldSubmitted != null ? onFieldSubmitted!(val) : null;
            },
            onTap: () {
              onTap != null ? onTap!() : null;
            },
            decoration: InputDecoration(
              contentPadding: padding,
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffix: suffix,
              suffixIcon: suffixIcon ??
                  ((isSHowClearIcon)
                      ? null
                      : IconButton(
                          onPressed: () {
                            controller.text = '';
                            if (onChanged != null) {
                              onChanged!('');
                            }
                          },
                          icon: const Icon(Icons.clear),
                        )),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor.withOpacity(0.5),
                ),
              ),
              labelStyle: TextStyle(
                color: borderColor,
              ),
              focusColor:borderColor,
            ),
          ),
          Column(
            children: parseErrors,
          ),
        ],
      ),
    );
  }
}
