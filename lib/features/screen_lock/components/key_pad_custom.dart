import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

import 'key_pad_button_custom.dart';

///custom from lib 'package:flutter_screen_lock/flutter_screen_lock.dart'

/// [GridView] or [Wrap] make it difficult to specify the item size intuitively.
/// We therefore arrange them manually with [Column]s and [Row]s
class KeyPadCustom extends StatelessWidget {
  const KeyPadCustom({
    super.key,
    required this.inputState,
    required this.didCancelled,
    this.enabled = true,
    KeyPadConfig? config,
    this.customizedButtonChild,
    this.customizedButtonTap,
    this.deleteButton,
    this.cancelButton,
  }) : config = config ?? const KeyPadConfig();

  final InputController inputState;
  final VoidCallback? didCancelled;
  final bool enabled;
  final KeyPadConfig config;
  final Widget? customizedButtonChild;
  final VoidCallback? customizedButtonTap;
  final Widget? deleteButton;
  final Widget? cancelButton;

  KeyPadButtonConfig get actionButtonConfig =>
      config.actionButtonConfig ?? const KeyPadButtonConfig(fontSize: 18);

  Widget _buildDeleteButton() {
    return KeyPadButtonCustom.transparent(
      onPressed: () => inputState.removeCharacter(),
      onLongPress: config.clearOnLongPressed ? () => inputState.clear() : null,
      config: actionButtonConfig,
      child: deleteButton ?? const Icon(Icons.backspace),
    );
  }

  Widget _buildCancelButton() {
    if (didCancelled == null) {
      return _buildHiddenButton();
    }

    return KeyPadButtonCustom.transparent(
      onPressed: didCancelled,
      config: actionButtonConfig,
      child: cancelButton ??
          const Text(
            'Cancel',
            textAlign: TextAlign.center,
          ),
    );
  }

  Widget _buildHiddenButton() {
    return KeyPadButtonCustom.transparent(
      onPressed: null,
      config: actionButtonConfig,
    );
  }

  Widget _buildRightSideButton() {
    return ValueListenableBuilder<String>(
      valueListenable: inputState.currentInput,
      builder: (context, value, child) {
        if (!enabled || value.isEmpty) {
          return _buildCancelButton();
        } else {
          return _buildDeleteButton();
        }
      },
    );
  }

  Widget _buildLeftSideButton() {
    if (customizedButtonChild == null) {
      return _buildHiddenButton();
    }

    return KeyPadButtonCustom.transparent(
      onPressed: customizedButtonTap!,
      config: actionButtonConfig,
      child: customizedButtonChild!,
    );
  }

  Widget _generateRow(BuildContext context, int rowNumber) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final number = (rowNumber - 1) * 3 + index + 1;
        final input = config.inputStrings[number];
        final display = config.displayStrings[number];

        return KeyPadButtonCustom(
          config: config.buttonConfig,
          text: display,
          onPressed: enabled ? () => inputState.addCharacter(input) : null,
          child: Text(display),
        );
      }),
    );
  }

  Widget _generateLastRow(BuildContext context) {
    final input = config.inputStrings[0];
    final display = config.displayStrings[0];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLeftSideButton(),
        KeyPadButtonCustom(
          config: config.buttonConfig,
          onPressed: enabled ? () => inputState.addCharacter(input) : null,
          child: Text(display),
          text: display,
        ),
        _buildRightSideButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(config.displayStrings.length == 10);
    assert(config.inputStrings.length == 10);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _generateRow(context, 1),
        _generateRow(context, 2),
        _generateRow(context, 3),
        _generateLastRow(context),
      ],
    );
  }
}
