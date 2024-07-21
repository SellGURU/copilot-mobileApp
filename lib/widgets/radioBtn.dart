import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/components/text_style.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  var selectedValue = "none";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Try a new yoga flow",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.title1,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
