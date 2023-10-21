import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/src/configurations/key_pad_button_config.dart';

///custom from lib 'package:flutter_screen_lock/flutter_screen_lock.dart'
/// Button in a [KeyPad].
class KeyPadButtonCustom extends StatelessWidget {
  const KeyPadButtonCustom({
    super.key,
    this.child,
    required this.onPressed,
    this.onLongPress,
    this.text,
    KeyPadButtonConfig? config,
  }) : config = config ?? const KeyPadButtonConfig();

  factory KeyPadButtonCustom.transparent({
    Key? key,
    Widget? child,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    KeyPadButtonConfig? config,
  }) =>
      KeyPadButtonCustom(
        key: key,
        onPressed: onPressed,
        onLongPress: onLongPress,
        config: KeyPadButtonConfig(
          size: config?.size,
          fontSize: config?.fontSize,
          foregroundColor: config?.foregroundColor,
          backgroundColor: Colors.transparent,
          buttonStyle: config?.buttonStyle?.copyWith(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        child: child,
      );

  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final KeyPadButtonConfig config;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: config.size,
      width: config.size,
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        key: (text != null) ? Key('pad$text') : null,
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: config.toButtonStyle(),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
