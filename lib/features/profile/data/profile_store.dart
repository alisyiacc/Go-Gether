import 'package:flutter/foundation.dart';

/// Data profil user yang dipakai di beberapa halaman.
class ProfileStore {
  ProfileStore._();

  static final ValueNotifier<String> name = ValueNotifier<String>('Caca');

  static final ValueNotifier<bool> notificationsEnabled =
      ValueNotifier<bool>(true);

  static void setName(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) name.value = trimmed;
  }
}
