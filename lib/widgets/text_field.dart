import 'package:flutter/material.dart';
import '../components/text_style.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String prefixLabel;
  final String hint;
  final TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  final TextInputType? inputType;
  final String? errorText;
  final bool isPassword; // Keep track if this field is a password field

  AppTextField({
    required this.label,
    required this.isPassword,
    required this.hint,
    required this.controller,
    this.icon = const SizedBox(),
    this.prefixLabel = '',
    this.textAlign = TextAlign.start,
    this.inputType,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Variable to track whether the password is visible or not
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Set up border style based on error presence
    final borderStyle = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: widget.errorText == null ? Colors.grey : Colors.red,
        width: widget.errorText == null ? 1.0 : 2.5,
      ),
    );

    // Set up text color based on error presence
    final textColor = widget.errorText == null ? Colors.black : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width,
          child: TextFormField(
            textAlign: widget.textAlign,
            controller: widget.controller,
            obscureText: widget.isPassword && _isObscured, // Toggle password visibility
            keyboardType: widget.inputType,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.hint,
              prefixIcon: widget.icon,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured; // Toggle the obscureText state
                  });
                },
              )
                  : null, // Only show suffixIcon if it's a password field
              errorStyle: AppTextStyles.gradeRed,
              errorText: widget.errorText, // Show error message if available
              border: borderStyle, // Dynamic border based on errorText
            ),
          ),
        ),
      ],
    );
  }
}
