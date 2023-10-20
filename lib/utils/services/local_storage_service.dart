import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final String _pincode = "pincode";

  Future<String?> read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> write(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> delete(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> deleteAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> savePincode(String token) async {
    await write(_pincode, token);
  }

  Future<String?> getPincode() async {
    return await read(_pincode);
  }
}

final localStorageServiceProvider =
    Provider<LocalStorageService>((ref) => LocalStorageService());
