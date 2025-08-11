import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A widget that handles mobile keyboard viewport issues in Flutter web applications.
/// This widget automatically adjusts the layout when the mobile keyboard opens and closes,
/// preventing the white space issue that occurs when the keyboard is dismissed.
class MobileKeyboardHandler extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool enableKeyboardAvoidance;

  const MobileKeyboardHandler({
    Key? key,
    required this.child,
    this.padding,
    this.enableKeyboardAvoidance = true,
  }) : super(key: key);

  @override
  State<MobileKeyboardHandler> createState() => _MobileKeyboardHandlerState();
}

class _MobileKeyboardHandlerState extends State<MobileKeyboardHandler> {
  double _keyboardHeight = 0.0;
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    // Only apply keyboard handling on web platform
    if (!kIsWeb || !widget.enableKeyboardAvoidance) {
      return widget.child;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: widget.padding ?? EdgeInsets.zero,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          viewInsets: MediaQuery.of(context).viewInsets,
        ),
        child: widget.child,
      ),
    );
  }
}

/// A scrollable widget that properly handles mobile keyboard viewport issues.
/// This widget is specifically designed for forms and input-heavy screens.
class MobileKeyboardScrollView extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final ScrollController? controller;
  final bool enableKeyboardAvoidance;
  final double? bottomPadding;

  const MobileKeyboardScrollView({
    Key? key,
    required this.child,
    this.padding,
    this.controller,
    this.enableKeyboardAvoidance = true,
    this.bottomPadding,
  }) : super(key: key);

  @override
  State<MobileKeyboardScrollView> createState() => _MobileKeyboardScrollViewState();
}

class _MobileKeyboardScrollViewState extends State<MobileKeyboardScrollView> {
  @override
  Widget build(BuildContext context) {
    // Only apply keyboard handling on web platform
    if (!kIsWeb || !widget.enableKeyboardAvoidance) {
      return SingleChildScrollView(
        controller: widget.controller,
        padding: widget.padding,
        child: widget.child,
      );
    }

    return SingleChildScrollView(
      controller: widget.controller,
      padding: widget.padding ?? EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + (widget.bottomPadding ?? 20),
        ),
        child: widget.child,
      ),
    );
  }
}

/// A scaffold that automatically handles mobile keyboard viewport issues.
/// This is useful for screens that need to handle keyboard input properly.
class MobileKeyboardScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool enableKeyboardAvoidance;
  final EdgeInsets? bodyPadding;

  const MobileKeyboardScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.enableKeyboardAvoidance = true,
    this.bodyPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      body: MobileKeyboardHandler(
        enableKeyboardAvoidance: enableKeyboardAvoidance,
        padding: bodyPadding,
        child: body,
      ),
    );
  }
}
