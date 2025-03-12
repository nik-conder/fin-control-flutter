import 'dart:io';

import 'package:fin_control/core/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static const _secureStorage = FlutterSecureStorage();
  final SharedPreferences _prefs;

  SecureStorage(this._prefs);

  Future<void> write(String key, String value) async {
    try {
      if (_isWindows()) {
        await _prefs.setString(key, value);
      } else if (isMobile) {
        await _secureStorage.write(key: key, value: value);
      } else {
        logger.w('Secure storage is not supported on this platform');
      }
    } catch (e) {
      logger.e('Error writing secure storage: $e', time: DateTime.now());
    }
  }

  Future<String?> read(String key) async {
    try {
      if (_isWindows()) {
        return _prefs.getString(key);
      } else if (isMobile) {
        return await _secureStorage.read(key: key);
      } else {
        logger.w('Secure storage is not supported on this platform');
        return null;
      }
    } catch (e) {
      logger.e('Error reading secure storage: $e', time: DateTime.now());
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      if (_isWindows()) {
        await _prefs.remove(key);
      } else if (isMobile) {
        await _secureStorage.delete(key: key);
      } else {
        logger.w('Secure storage is not supported on this platform');
      }
    } catch (e) {
      logger.e('Error deleting from secure storage: $e', time: DateTime.now());
    }
  }

  static bool _isWindows() {
    return Platform.isWindows || Platform.isLinux;
  }

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
