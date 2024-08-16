import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popover/popover.dart';
import 'package:test_copilet/screens/camera/camaraScreen.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_events.dart';

import '../components/text_style.dart';
import '../res/colors.dart';
import '../route/names.dart';
import '../utility/camareControlerBloc/camera_Bloc.dart';

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
        shadowColor: Color.fromRGBO(153, 171, 198, 0.18),
        onTap: (index) => setState(() {
          if (index != 2) {
            setState(() {
              pageIndex = index;
            });

            BlocProvider.of<PageIndexBloc>(context).add(UpdatePageIndex(index));
          } else {
            showPopover(
              context: context,
              bodyBuilder: (contextBodyBuilder) =>
                  ListItems(Parentcontext: context),
              onPop: () => print('Popover was popped!'),
              direction: PopoverDirection.bottom,
              width: 600,
              height: 140,
              arrowHeight: 0,
              shadow: [BoxShadow(color: Colors.transparent)],
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent.withOpacity(.65),
              arrowWidth: 0,
            );
          }
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
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              padding: EdgeInsets.all(1),
              height: (size.height),
              decoration: BoxDecoration(
                  color: AppColors.iconPurpleDark,
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(97, 62, 234, 0.5),
                        offset: Offset(0, 4),
                        blurRadius: 12)
                  ]),
              child: Image.asset("assets/codie.png"),
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
                    alignment: Alignment.center,
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

class ListItems extends StatefulWidget {
  var Parentcontext;
  ListItems({Key? key, this.Parentcontext}) : super(key: key);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  var itemSelect = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // itemSelect=1;
          GestureDetector(
            onTap: () {
              // to navigate to Chat Screen
              BlocProvider.of<PageIndexBloc>(widget.Parentcontext)
                  .add(UpdatePageIndex(5));
              // to close the background black
              Navigator.pop(widget.Parentcontext);
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 3.5, right: 3.5, top: 8, bottom: 13),
              alignment: Alignment.center,
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/message-text.svg",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Chat',
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          // itemSelect=2;
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 3.5, right: 3.5, top: 8, bottom: 13),
              alignment: Alignment.center,
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/Screenshot.svg",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Screenshot',
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          // itemSelect=3;
          GestureDetector(
            onTap: () {
              Navigator.of(widget.Parentcontext).push(
                MaterialPageRoute<void>(
                  // provide the Bloc to other screen
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<CameraBloc>(widget.Parentcontext),
                      child: CameraScreen()),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 3.5, right: 3.5, top: 8, bottom: 13),
              alignment: Alignment.center,
              width: 80,
              height: 75,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/camera.svg",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Take Picture',
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
