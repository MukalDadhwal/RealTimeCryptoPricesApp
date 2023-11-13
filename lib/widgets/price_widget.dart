import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceWidget extends ConsumerWidget {
  final String name;
  final String symbol;
  final String price;

  const PriceWidget({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Align(
        widthFactor: 1,
        alignment: Alignment.centerLeft,
        child: FlutterLogo(
          size: 30,
        ),
      ),
      title: Text(name),
      subtitle: Text(symbol),
      trailing: Text(price),
    );
  }
}
