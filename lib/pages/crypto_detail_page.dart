import 'package:cryto_price_app/pages/cryto_price_page.dart';
import 'package:cryto_price_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/crytomodel.dart';

class CryptoDetailPage extends ConsumerWidget {
  final Data dataModel;
  const CryptoDetailPage({super.key, required this.dataModel});

  /*
    Name with symbol
    price
    cmc rank
    circulating supply
    percent change in last 1hr, 24hr, 3 months
    market dominance
   */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(mediaQueryProvider(context));
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: theme ? Colors.white : Colors.black),
        forceMaterialTransparency: true,
        title: Text(
          dataModel.name,
          style: TextStyle(color: theme ? Colors.white : Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: dataModel.cmc_rank,
                    child: Image.asset(dataModel.imagePath!),
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Currency",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            dataModel.symbol.toUpperCase(),
                            style: GoogleFonts.raleway(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Rank",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            dataModel.cmc_rank.toString(),
                            style: GoogleFonts.raleway(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Price",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "\$${dataModel.quote.usd.price.toStringAsFixed(2)}",
                            style: GoogleFonts.raleway(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 2,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Change in 1hr",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: dataModel.quote.usd.percent_change_1h < 0
                            ? FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_1h.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_1h.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FittedBox(
                        child: Text(
                          "Change in 24hr",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: dataModel.quote.usd.percent_change_24h < 0
                            ? FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_24h.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_24h.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FittedBox(
                        child: Text(
                          "Change in 90days",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: dataModel.quote.usd.percent_change_90d < 0
                            ? FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_90d.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : FittedBox(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    Text(
                                      "\$${dataModel.quote.usd.percent_change_90d.toStringAsFixed(3)}",
                                      style: GoogleFonts.raleway(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Card(
                color: theme ? Theme.of(context).cardColor : dataModel.color,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Market",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          "Dominance",
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "${dataModel.quote.usd.market_cap_dominance.toStringAsFixed(2)}%",
                            style: GoogleFonts.raleway(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
