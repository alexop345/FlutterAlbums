import 'dart:io';

Future<bool> hasNetwork(String url) async {
  try {
    final result = await InternetAddress.lookup(url);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}