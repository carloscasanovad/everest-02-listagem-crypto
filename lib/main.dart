import 'package:crypto/shared/routes/routes.dart';
import 'package:crypto/transactions/transactions_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'details/views/details_page.dart';
import 'wallet/views/wallet_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Crypto',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      );
}
