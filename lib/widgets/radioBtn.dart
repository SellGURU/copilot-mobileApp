import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/components/text_style.dart';

class TrackProgress extends StatefulWidget {

  TrackProgress(
      {super.key});

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  var selectedValue = "none";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/yoga.svg",
                  // colorFilter: ColorFilter.mode(widget.colorIcon, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Try a new yoga flow",
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Start taking an LAL supplement",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/pill.svg",
                  // colorFilter: ColorFilter.mode(widget.colorIcon, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Start taking an LAL supplement",
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Eat a probiotic food today",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/drag.svg",
                  // colorFilter: ColorFilter.mode(widget.colorIcon, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Eat a probiotic food today",
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "Bump up your fibre intake",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() => selectedValue = value!);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/bump.svg",
                  // colorFilter: ColorFilter.mode(widget.colorIcon, BlendMode.srcIn),
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Bump up your fibre intake",
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
