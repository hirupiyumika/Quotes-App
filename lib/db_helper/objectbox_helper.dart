import 'package:flutter/material.dart';
import '../objectbox.g.dart';

class ObjectboxHelper {

  factory ObjectboxHelper.getInstance() {
    if (hasNotBeenInitialized) {
      _createStore();
      debugPrint('Created successfully!');
      hasNotBeenInitialized = false;
    }
    debugPrint('ObjectboxHelper.getInstance() works!');
    return _ObjectboxHelper;
  }


  ObjectboxHelper._internal();

  static final ObjectboxHelper _ObjectboxHelper = ObjectboxHelper._internal();
  static late final Store _store;


  static bool hasNotBeenInitialized = true;

  static Future<void> _createStore() async {
    debugPrint('_createStore() works!');

    _store = await openStore();
  }

  static Future<void> closeObjectboxHelper() async {
    if (Store?.isOpen(null)) {
      _store.close();
      debugPrint('Store is closed!');
    }
  }

  static Store getStore() {
    return _store;
  }
}
