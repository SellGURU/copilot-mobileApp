import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  var selectedValue="none";
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
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),
        SizedBox(height: 5,),
        RadioMenuButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(10),
              shadowColor: WidgetStatePropertyAll(Colors.grey.withOpacity(.3))),
          value: "salam",
          groupValue: selectedValue,
          onChanged: (String? value) {
            setState(() =>selectedValue=value!);
          },
          child: Text("salam"),
        ),

      ],
    ));
  }
}
