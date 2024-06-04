import 'dart:async';

import 'package:flutter/material.dart';

Future<T> showLoadingDialog<T>(
  BuildContext context,
  Future<T> Function() operation,
) async {
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );

  try {
    final result = await operation();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    return result;
  } on Exception catch (_) {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    rethrow;
  }
}
