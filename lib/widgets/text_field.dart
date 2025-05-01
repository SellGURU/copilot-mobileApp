import 'package:flutter/material.dart';
import '../components/text_style.dart';
import '../res/colors.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String prefixLabel;
  final String hint;
  final TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  final TextInputType? inputType;
  final String? errorText;
  final bool isPassword;

  AppTextField({
    required this.label,
    required this.isPassword,
    required this.hint,
    required this.controller,
    this.icon = const SizedBox(width: 0,height: 0,),
    this.prefixLabel = '',
    this.textAlign = TextAlign.start,
    this.inputType,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final borderStyle = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
gapPadding: 0,
      borderSide: BorderSide(

        color: widget.errorText == null ? AppColors.gray50 : AppColors.red,
        width: widget.errorText == null ? 1.0 : 5.5,
      ),
    );

    final textColor = widget.errorText == null ? Colors.black : AppColors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            widget.label,
            style: AppTextStyles.hintBlack,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: size.width,
          child: TextFormField(
            textAlign: widget.textAlign,
            controller: widget.controller,
            obscureText: widget.isPassword && _isObscured,
            keyboardType: widget.inputType,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.hint,
              // prefixIcon: widget.icon,
              contentPadding: EdgeInsets.symmetric(vertical: 16,horizontal: 24), //Change this value to custom as you like
              isDense: true, // and add this line
              suffixIcon: widget.isPassword
                  ? IconButton(  
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child:  Icon(
                          _isObscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color.fromRGBO(123, 147, 175, 1),
                        ),
                        
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
              errorStyle: AppTextStyles.error,
              errorText: widget.errorText,
              border: borderStyle,
              enabledBorder: borderStyle,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gapPadding: 0,
                borderSide: BorderSide(
                  color: AppColors.greenBega,
                  width: 2.0,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gapPadding: 0,
                borderSide: BorderSide(
                  color: AppColors.red,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gapPadding: 0,
                borderSide: BorderSide(
                  color: AppColors.red,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
