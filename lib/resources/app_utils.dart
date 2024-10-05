import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> isInternetConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi);
}

void showSnackBar(final BuildContext context, final String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(msg),
    ),
  );
}