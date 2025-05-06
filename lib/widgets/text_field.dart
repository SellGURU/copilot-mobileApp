import 'package:flutter/material.dart';
import '../components/text_style.dart';
import '../res/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final Function(String)? onChanged;
  final String? tooltipMessage;

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
    this.onChanged,
    this.tooltipMessage,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Text(
                widget.label,
                style: AppTextStyles.hintBlack,
              ),
              if (widget.isPassword && widget.tooltipMessage != null) ...[
                const SizedBox(width: 8),
                Theme(
                  data: Theme.of(context).copyWith(
                    tooltipTheme: TooltipThemeData(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  child: Tooltip(
                    message: widget.tooltipMessage,
                    child: Container(
                      width: 8,
                      height: 8,
                      child: SvgPicture.asset(
                        "info-circle.svg",
                        width: 8,
                        height: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ],
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
            style: TextStyle(color: Colors.black),
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.hint.copyWith(color: const Color(0xFFB0B0B0)),
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
