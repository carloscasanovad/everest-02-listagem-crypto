import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:crypto/shared/providers/asset_provider.dart';

import '../../shared/constants/app_colors.dart';
import '../../shared/model/crypto_list_model.dart';
import '../../shared/repositories/crypto_list_repository.dart';
import '../providers/providers.dart';
import 'line_chart_title_button.dart';

class CryptoDetailsBody extends ConsumerStatefulWidget {
  String cryptoName;
  CryptoDetailsBody({
    required this.cryptoName,
  });

  @override
  ConsumerState<CryptoDetailsBody> createState() => _CryptoDetailsBodyState();
}

class _CryptoDetailsBodyState extends ConsumerState<CryptoDetailsBody> {
  CryptoListRepository repository = CryptoListRepository();
  late Future<List<CryptoListModel>> cryptos;

  int chartIndex = 0;
  @override
  void initState() {
    cryptos = repository.getAllCryptos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int chartIndex = ref.watch(chartIndexTappedProvider);
    String chartDay = ref.watch(chartDayProvider);
    return SingleChildScrollView(
      child: FutureBuilder(
        future: cryptos,
        builder: (BuildContext context,
            AsyncSnapshot<List<CryptoListModel>> snapshot) {
          if (snapshot.hasData) {
            CryptoListModel dataCrypto = snapshot.data!.firstWhere(
              (crypto) => crypto.shortName == widget.cryptoName,
            );
            print(dataCrypto);

            CryptoListModel cryptoData = snapshot.data![0];
            List points =
                dataCrypto.marketPriceVariation.values.toList()[chartIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dataCrypto.fullName,
                            style: const TextStyle(
                              fontSize: 32,
                              color: kDefaultBlack,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Image.asset(
                            dataCrypto.cryptoLogo,
                            height: 48,
                            width: 48,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dataCrypto.shortName,
                        style: const TextStyle(
                          fontSize: 17,
                          color: kDefaultGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${cryptoData.marketActualPrice}',
                        style: const TextStyle(
                          fontSize: 32,
                          color: kDefaultBlack,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30, // bottom space
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 1:
                                        return Container(
                                          // margin: const EdgeInsets.only(top: 0),
                                          width: 30,
                                          child: LineChartTitleButton(
                                            dayTitle: '5D',
                                            titleIndex: 0,
                                          ),
                                        );
                                      case 2:
                                        return Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          width: 30,
                                          child: LineChartTitleButton(
                                            dayTitle: '10D',
                                            titleIndex: 1,
                                          ),
                                        );
                                      case 3:
                                        return Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          width: 30,
                                          child: LineChartTitleButton(
                                            dayTitle: '15D',
                                            titleIndex: 2,
                                          ),
                                        );
                                      case 4:
                                        return Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          width: 30,
                                          child: LineChartTitleButton(
                                            dayTitle: '30D',
                                            titleIndex: 3,
                                          ),
                                        );
                                      case 5:
                                        return Container(
                                          margin: const EdgeInsets.only(top: 0),
                                          width: 30,
                                          child: LineChartTitleButton(
                                            dayTitle: '50D',
                                            titleIndex: 4,
                                          ),
                                        );
                                      default:
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            backgroundColor: kDefaultBackgroundColor,
                            minX: 0,
                            maxX: 10,
                            minY: 0,
                            maxY: 15,
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              },
                              //Remove as linhas do eixo X e Y do gráfico
                              drawVerticalLine: false,
                              drawHorizontalLine: false,
                            ),
                            borderData: FlBorderData(
                              show: true,
                              // Cria a borda do gráfico
                              border: Border(
                                bottom: BorderSide(
                                    color: kDefaultGrey.withOpacity(0.3)),
                              ),
                              //Border.all(color: const Color(0xff37434d), width: 1),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                // Remove os pontos do gráfico
                                dotData: FlDotData(
                                  show: false,
                                ),
                                spots: points
                                    .map((point) => FlSpot(point[0], point[1]))
                                    .toList(),
                                isCurved: false,
                                barWidth: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Preço atual'),
                        trailing: Text('R\$ ${cryptoData.marketActualPrice}'),
                      ),
                      ListTile(
                        title: const Text('Variação do dia'),
                        trailing: Text(
                            ' ${(cryptoData.percentVariation.values.toList()[chartIndex]).toStringAsFixed(2)}%'),
                      ),
                      ListTile(
                        title: const Text('Quantidade'),
                        trailing: Text(
                            '${(Decimal.parse(cryptoData.userBalance.toString()) * cryptoData.exchange).toStringAsFixed(4)} ${cryptoData.shortName}'),
                      ),
                      ListTile(
                        title: const Text('Valor'),
                        trailing: Text('R\$ ${cryptoData.userBalance}'),
                      ),
                    ],
                  ),
                ],
              ),
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
