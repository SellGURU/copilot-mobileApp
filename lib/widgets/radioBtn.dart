import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/components/text_style.dart';

class RadioButton extends StatefulWidget {
  String text;
  String picUrl;
  Color colorIcon;
  RadioButton({super.key, required this.picUrl, required this.text,this.colorIcon=Colors.transparent});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  var selectedValue = "none";
  @override
  Widget build(BuildContext context) {
    return RadioMenuButton(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          elevation: WidgetStatePropertyAll(10),
          shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
      value: widget.text,
      groupValue: selectedValue,
      onChanged: (String? value) {
        setState(() => selectedValue = value!);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SvgPicture.asset(
             widget.picUrl,
              // colorFilter: ColorFilter.mode(widget.colorIcon, BlendMode.srcIn),
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.text,
            style: AppTextStyles.title1,
          ),
        ],
      ),
    );
  }
}
