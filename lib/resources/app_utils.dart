import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// A method used to check if the device is connected to the internet.
/// it returns 'true' if the device is connected, otherwise 'false'
Future<bool> isInternetConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi);
}

/// A method used to show snackbar in the app, with the given message.
/// - [context]: The [BuildContext] to display the snackbar in.
/// - [msg]: The message to display inside the snackbar.
void showSnackBar(final BuildContext context, final String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(msg),
    ),
  );
}