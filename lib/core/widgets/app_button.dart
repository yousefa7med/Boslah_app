import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, this.style, required this.child});
  final void Function()? onPressed;
  final ButtonStyle? style;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, style: style, child: child),
    );
  }
}
