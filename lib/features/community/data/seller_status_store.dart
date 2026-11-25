import 'package:flutter/foundation.dart';

/// Status pendaftaran seller user.
/// false = Unregistered, true = Registered.
class SellerStatusStore {
  SellerStatusStore._();

  static final ValueNotifier<bool> registered = ValueNotifier<bool>(false);

  static void markRegistered() => registered.value = true;
}
