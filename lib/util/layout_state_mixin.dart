import 'dart:async';
import 'package:flutter/material.dart';

mixin LayoutStateMixin<T extends StatefulWidget> on State<T> {
  void didLayoutEnded();

  @override
  void initState() {
    super.initState();
    unawaited(_asyncInitState());
  }

  Future<void> _asyncInitState() async {
    await WidgetsBinding.instance.endOfFrame;
    didLayoutEnded();
  }
}
