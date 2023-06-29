import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo {
  Stream<SharedPreferences> _initSharedPreferences() {
    return Stream.fromFuture(SharedPreferences.getInstance());
  }

  Stream<String?> getString(StorageKey key) {
    return _initSharedPreferences().map((sharedPreferences) {
      return sharedPreferences.getString(key.name);
    });
  }

  Stream<bool> setString(StorageKey key, String value) {
    return _initSharedPreferences().flatMap((sharedPreferences) {
      return sharedPreferences.setString(key.name, value).asStream();
    });
  }
}

enum StorageKey {
  albums,
  albumsDateUpdated,
}
