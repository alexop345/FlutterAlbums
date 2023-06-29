import 'dart:io';

class NetworkConnection {
  final String url;

  const NetworkConnection({required this.url});

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup(url);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
