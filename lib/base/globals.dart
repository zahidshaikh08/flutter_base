import 'dart:core';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/services/stacked_services_module.dart';
import 'package:flutter_base/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.dart';

void unawaited(Future<void> future) {}

// SystemChannels.platform.invokeMethod('SystemNavigator.pop');

bool isEmulator = false;

final dialogService = StackedServicesModuleImpl.dialogService;
final snackBarService = StackedServicesModuleImpl.snackbarService;
final bottomSheetService = StackedServicesModuleImpl.bottomSheetService;
final navigationService = StackedServicesModuleImpl.navigationService;

const somethingWentWrongM = "Something went wrong, please try again later!";
const somethingWentWrongN =
    'Oop\'s sorry something went wrong from our side, we are working on fixing the problem. Please try again.';

late SharedPreferences sharedPref;

// EventBus eventBus = EventBus();

double screenHeight = 0.0;
double screenWidth = 0.0;

const NA = "NA";

Future<bool> isNetworkConnected() async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  } on SocketException catch (e) {
    print("isNetworkConnected exception =====>>> $e");
  }

  return false;
}

void somethingWentWrongBar() {
  showSnackbar(somethingWentWrongM);
}

void noInternetBar() {
  showSnackbar(Strings.noInternet);
}

void showLog(String msg) {
  debugPrintThrottled(msg, wrapWidth: 220);
}

void showBotToastNotification(String? message, {Alignment? alignment, Duration? duration}) {
  BotToast.showSimpleNotification(
    title: message ?? somethingWentWrongM,
    align: alignment,
    duration: duration ?? const Duration(seconds: 3),
  );
}

void showCustomBotToastNotification(String title, String? message, {VoidCallback? onTap}) {
  BotToast.showCustomNotification(
    toastBuilder: (function) {
      return Card(
        elevation: 5.0,
        child: ListTile(
          onTap: onTap,
          title: Texts(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          subtitle: message != null && message.isNotEmpty
              ? Texts(
                  message.trimRight(),
                  fontSize: 14,
                )
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => function.call(),
          ),
        ),
      );
    },
    duration: const Duration(seconds: 4),
  );
}

Future<void> showSnackbar([String? msg, BuildContext? context, Color? color]) async {
  ScaffoldMessenger.of(context ?? StackedService.navigatorKey!.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Texts(msg ?? somethingWentWrongM, color: Colors.white),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}

void hideKeyboard([BuildContext? context]) {
  if (context != null) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
  } else {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }
}

CancelFunc? loading;

void showLoader() {
  loading = BotToast.showCustomLoading(
    backgroundColor: Colors.black54,
    toastBuilder: (func) => const NativeLoader.android(),
    backButtonBehavior: BackButtonBehavior.ignore,
  );
}

void hideLoader() {
  loading?.call();
}

const unsplash = "https://images.unsplash.com/photo-"
    "1512621776951-a57141f2eefd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8f"
    "GVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";
