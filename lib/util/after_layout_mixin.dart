import 'dart:async';
import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  FutureOr<void> didLayoutEnded();

  @override
  void initState() {
    super.initState();
    unawaited(_asyncInitState());
  }

  Future<void> _asyncInitState() async {
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) {
      await didLayoutEnded();
    }
  }
}
