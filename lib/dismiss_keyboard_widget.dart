import 'package:flutter/material.dart';

class DismissKeyboardWidget extends StatelessWidget {
  const DismissKeyboardWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        //Return when the keyboard is hidden
        if (FocusManager.instance.primaryFocus?.hasFocus != true) return;
        //Don't use the 'FocusManager. Instance. PrimaryFocus? .context? .findRenderObject()', it will get the wrong RenderObject
        final textFieldState = FocusManager.instance.primaryFocus?.context?.findAncestorStateOfType<State<TextField>>();
        final renderObject = textFieldState?.context.findRenderObject();
        if (renderObject == null || !renderObject.attached) {
          return;
        }

        final translation = renderObject.getTransformTo(null).getTranslation();
        final offset = Offset(translation.x, translation.y);
        final paintBounds = renderObject.paintBounds.shift(offset);
        if (paintBounds.contains(event.position)) return;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
