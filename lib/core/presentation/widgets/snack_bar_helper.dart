import 'package:bpp/core/theme/constants.dart';
import 'package:flutter/material.dart';

extension SnackBarHelper on BuildContext {
  void showAppSnackBar(
    String message, {
    bool success = true,
    Duration? duration,
  }) {
    final snack = SnackBar(
      content: Text(message),
      backgroundColor: success ? AppColors.success : AppColors.error,
      duration: duration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }
}
