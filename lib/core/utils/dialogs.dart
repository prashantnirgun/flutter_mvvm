import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  // ----------------- Success Dialog -----------------
  static void showSuccess(
    BuildContext context, {
    String title = 'Success',
    String desc = 'Operation completed successfully',
    VoidCallback? onOk,
    Function(DismissType)? onDismiss,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
      btnOkIcon: Icons.check_circle,
      onDismissCallback: onDismiss,
    ).show();
  }

  // ----------------- Error Dialog -----------------
  static void showError(
    BuildContext context, {
    String title = 'Error',
    String desc = 'Something went wrong',
    VoidCallback? onOk,
    Function(DismissType)? onDismiss,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
      btnOkIcon: Icons.cancel,
      onDismissCallback: onDismiss,
    ).show();
  }

  // ----------------- Info Dialog -----------------
  static void showInfo(
    BuildContext context, {
    String title = 'Info',
    String desc = 'Here is some information',
    VoidCallback? onOk,
    Function(DismissType)? onDismiss,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
      btnOkIcon: Icons.info,
      onDismissCallback: onDismiss,
    ).show();
  }

  // ----------------- Warning Dialog -----------------
  static void showWarning(
    BuildContext context, {
    String title = 'Warning',
    String desc = 'Be careful!',
    VoidCallback? onOk,
    Function(DismissType)? onDismiss,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
      btnOkIcon: Icons.warning,
      onDismissCallback: onDismiss,
    ).show();
  }

  // ----------------- Loading Dialog -----------------
  static void showLoading(
    BuildContext context, {
    String title = 'Loading...',
    String desc = '',
    Function(DismissType)? onDismiss,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      onDismissCallback: onDismiss,
      btnOk: null,
    ).show();
  }
}
