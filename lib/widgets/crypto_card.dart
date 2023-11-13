import 'package:cryto_price_app/pages/crypto_detail_page.dart';
import 'package:cryto_price_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/crytomodel.dart';

class CryptoCard extends ConsumerWidget {
  final Data dataModel;
  const CryptoCard({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CryptoDetailPage(
            dataModel: dataModel,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(40.0),
      child: Card(
        elevation: 2.0,
        color: theme ? Theme.of(context).cardTheme.color : dataModel.color,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Text(
              //       dataModel.cmc_rank.toString(),
              //       style: const TextStyle(
              //         fontWeight: FontWeight.w900,
              //         fontSize: 20,
              //       ),
              //     ),
              //     const Spacer(),
              //   ],
              // ),
              FittedBox(
                child: Hero(
                  tag: dataModel.cmc_rank,
                  child: Image.asset(
                    dataModel.imagePath!,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  dataModel.name.toUpperCase(),
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
