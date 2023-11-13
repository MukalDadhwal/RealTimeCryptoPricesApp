import 'dart:developer';

import 'package:cryto_price_app/keys.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/crytomodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';

final apiProvider = StateNotifierProvider<ApiProvider, AsyncValue<CryptoModel>>(
  (ref) => ApiProvider(),
);

class ApiProvider extends StateNotifier<AsyncValue<CryptoModel>> {
  ApiProvider() : super(const AsyncValue.loading()) {
    loadCurrencies();
  }

  Future<Color> getColorFromImage(String path) async {
    final color = await PaletteGenerator.fromImageProvider(
      Image.asset(path).image,
    );

    var hexcolor = color.dominantColor!.color;
    HSLColor hslColor = HSLColor.fromColor(hexcolor);
    HSLColor lighterColor = hslColor.withLightness(hslColor.lightness + 0.3);
    return lighterColor.toColor();
  }

  Future<Map<String, dynamic>> getImagePathAndColor(String symbol) async {
    String? path;
    switch (symbol) {
      case 'BTC':
        path = 'assets/btc.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'ETH':
        path = 'assets/eth.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'USDT':
        path = 'assets/tether.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'BNB':
        path = 'assets/bnb.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'XRP':
        path = 'assets/xrp.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'USDC':
        path = 'assets/usd.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'ADA':
        path = 'assets/cardano.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'DOGE':
        path = 'assets/dogecoin.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'SOL':
        path = 'assets/sol.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'TRX':
        path = 'assets/tron.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'TON':
        path = 'assets/btc.png';
        return {'path': path, 'color': await getColorFromImage(path)};
      case 'DAI':
        path = 'assets/dai.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'DOT':
        path = 'assets/polkadot.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'MATIC':
        path = 'assets/polygon.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      case 'LTC':
        path = 'assets/litecoin.png';
        return {'path': path, 'color': await getColorFromImage(path)};

      default:
        print('in default');
        path = 'assets/btc.png';
        return {'path': path, 'color': await getColorFromImage(path)};
    }
  }

  Future<void> loadCurrencies() async {
    try {
      final res = await Dio().get(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=${Keys().getApiKey}',
        queryParameters: {
          "start": "1",
          "limit": "15",
          "convert": "USD",
        },
        options: Options(
          headers: {
            "Accepts": "application/json",
          },
        ),
      );

      if (res.statusCode == 200) {
        CryptoModel model =
            CryptoModel.fromMap(res.data as Map<String, dynamic>);
        await Future.forEach(model.data, (item) async {
          Map<String, dynamic> map = await getImagePathAndColor(item.symbol);

          Color color = map['color'];
          String path = map['path'];

          item.setColor = color;
          item.setImagePath = path;
        });
        state = AsyncValue.data(model);
      } else {
        debugPrint('The response status code is not 200 ${res.statusCode}');
      }
    } catch (e) {
      print(e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
