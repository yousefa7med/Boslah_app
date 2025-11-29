import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> _hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

Future<bool> hasInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }

  return await _hasInternet();
}
