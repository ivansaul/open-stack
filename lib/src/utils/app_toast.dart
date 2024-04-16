import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:openstack/src/shared/widgets/toast_notification_widget.dart';

enum ToastType {
  error,
}

class AppToast {
  static void Function() showLoading() => BotToast.showLoading();

  static void closeAllToasts() => BotToast.cleanAll();

  static void closeAllLoading() => BotToast.closeAllLoading();

  static void showText(String text) => BotToast.showText(text: text);

  static void showNotification(String message,
          [ToastType type = ToastType.error]) =>
      BotToast.showCustomNotification(
        duration: const Duration(seconds: 10),
        enableSlideOff: true,
        toastBuilder: (cancelFunc) => ToastNotificationWidget(
          message: message,
          type: type,
        ),
        onlyOne: true,
        crossPage: true,
        align: Alignment.bottomCenter,
      );
}
