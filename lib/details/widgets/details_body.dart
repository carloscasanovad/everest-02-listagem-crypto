import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:crypto/details/widgets/details_header.dart';

import '../../shared/model/crypto_list_model.dart';
import '../../shared/providers/providers.dart';
import '../../shared/repositories/crypto_list_repository.dart';
import 'convert_crypto_button.dart';
import 'crypto_information.dart';
import 'details_line_chart.dart';
import 'line_chart_list_view_buttons.dart';

class DetailsBody extends ConsumerStatefulWidget {
  const DetailsBody({super.key});

  @override
  ConsumerState<DetailsBody> createState() => _CryptoDetailsBodyState();
}

class _CryptoDetailsBodyState extends ConsumerState<DetailsBody> {
  CryptoListRepository repository = CryptoListRepository();
  late Future<List<CryptoListModel>> cryptos;

  @override
  void initState() {
    cryptos = repository.getAllCryptos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String cryptoName = ref.watch(cryptoFilterProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: FutureBuilder(
        future: cryptos,
        builder: (BuildContext context,
            AsyncSnapshot<List<CryptoListModel>> snapshot) {
          if (snapshot.hasData) {
            CryptoListModel dataCrypto = snapshot.data!.firstWhere(
              (crypto) => crypto.shortName == cryptoName,
            );

            return Column(
              children: [
                DetailsHeader(dataCrypto: dataCrypto),
                DetailsLineChart(dataCrypto: dataCrypto),
                const LineChartListViewButtons(),
                CryptoInformation(dataCrypto: dataCrypto),
                const ConvertCryptoButton(),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
