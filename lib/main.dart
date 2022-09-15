import 'package:crypto/transactions/transactions_page.dart';
import 'package:crypto/wallet/widgets/crypto_details.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'shared/widgets/bottom_nav_bar.dart';
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
        routes: {
          '/': (context) => const BottomNavBar(),
          '/wallet': (context) => const WalletPage(),
          '/transactions': (context) => const TransactionsPage(),
          //'/cryptoDetails': (context) => const CryptoDetails(),
        },
      );
}
