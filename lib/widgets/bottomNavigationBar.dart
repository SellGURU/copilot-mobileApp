// import 'dart:ffi';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_events.dart';

import '../components/text_style.dart';
import '../res/colors.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        onTap: (index) => setState(() {
          setState(() {
            pageIndex = index;
          });
          BlocProvider.of<PageIndexBloc>(context).add(UpdatePageIndex(index));
        }),
        disableDefaultTabController: true,
        elevation: 5,
        height: 60,
        style: TabStyle.fixed,
        backgroundColor: AppColors.mainBg,
        color: AppColors.textLite,
        activeColor: AppColors.iconPurpleDark,
        // top: ((size.width*.06)*-1),
        curveSize: 70,
        items: [
          TabItem(
            title: "Overview",
            icon: SizedBox(
              height: (size.width),
              // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
              child: SvgPicture.asset("assets/overviewIcon.svg",
                  width: 5,
                  height: 5,
                  colorFilter: pageIndex == 0
                      ? ColorFilter.mode(AppColors.purpleDark, BlendMode.srcIn)
                      : ColorFilter.mode(AppColors.textLite, BlendMode.srcIn)),
            ),
          ),
          TabItem(
            title: "Results",
            icon: SizedBox(
              height: (size.height),
              // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
              child: SvgPicture.asset("assets/resultIcon.svg",
                  width: 5,
                  height: 5,
                  colorFilter: pageIndex == 1
                      ? const ColorFilter.mode(
                          AppColors.purpleDark, BlendMode.srcIn)
                      : const ColorFilter.mode(
                          AppColors.textLite, BlendMode.srcIn)),
            ),
          ),
          TabItem(
            title: "",
            icon: Container(
              margin: const EdgeInsets.all(5),
              height: (size.height),
              decoration: BoxDecoration(
                  color: AppColors.iconPurpleDark,
                  borderRadius: BorderRadius.circular(99)),
              child: SvgPicture.asset("assets/addIcon.svg",
                  width: 5,
                  height: 5,
                  colorFilter: pageIndex == 1
                      ? const ColorFilter.mode(
                          AppColors.purpleDark, BlendMode.srcIn)
                      : const ColorFilter.mode(
                          AppColors.textLite, BlendMode.srcIn)),
            ),
          ),
          TabItem(
              title: "Plan",
              icon: SizedBox(
                height: (size.height),
                // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                child: SvgPicture.asset("assets/planIcon.svg",
                    width: 5,
                    height: 5,
                    colorFilter: pageIndex == 3
                        ? const ColorFilter.mode(
                            AppColors.purpleDark, BlendMode.srcIn)
                        : const ColorFilter.mode(
                            AppColors.textLite, BlendMode.srcIn)),
              )),
          TabItem(
              title: "Setting",
              icon: SizedBox(
                height: (size.height),
                // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                child: SvgPicture.asset("assets/settingIcon.svg",
                    width: 5,
                    height: 5,
                    colorFilter: pageIndex == 4
                        ? const ColorFilter.mode(
                            AppColors.purpleDark, BlendMode.srcIn)
                        : const ColorFilter.mode(
                            AppColors.textLite, BlendMode.srcIn)),
              )),
        ],
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 65;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return AppTextStyles.hint;
  }
}
