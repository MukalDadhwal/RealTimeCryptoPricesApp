import 'package:cryto_price_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/crypto_card.dart';
import '../widgets/search_bar.dart';
import '../providers/api_provider.dart';

final mediaQueryProvider = StateProvider.family<Size, BuildContext>(
  (ref, ctx) => MediaQuery.sizeOf(ctx),
);

class PricesPage extends ConsumerStatefulWidget {
  const PricesPage({super.key});

  @override
  ConsumerState<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends ConsumerState<PricesPage> {
  FocusNode searchBarFocusNode = FocusNode();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      print("at the end!");
      if (_controller.position.maxScrollExtent == _controller.offset) {
        print('at the end!');
        ref.read(apiProvider.notifier).addItems();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchMoreItems() {}

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(apiProvider);
    final size = ref.watch(mediaQueryProvider(context));
    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).requestFocus(FocusNode());
        searchBarFocusNode.unfocus();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Consumer(
            builder: (context, ref, child) {
              return Text(
                "Crypto Currencies",
                style: GoogleFonts.oswald(
                  fontSize: 38,
                  color:
                      ref.watch(appThemeProvider) ? Colors.white : Colors.black,
                ),
              );
            },
          ),
          toolbarHeight: size.height * 0.1,
          bottom: AppSearchBar(size: size, focusNode: searchBarFocusNode),
          actions: [
            Consumer(
              builder: (context, ref, child) {
                return Switch.adaptive(
                  value: ref.watch(appThemeProvider),
                  onChanged: (value) =>
                      ref.read(appThemeProvider.notifier).toggleTheme(),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              ref.read(apiProvider.notifier).loadCurrencies("1", "16"),
          child: model.when(
            data: (modelData) {
              return GridView.builder(
                controller: _controller,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 500 ? 3 : 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) {
                  if (index >= modelData.data.length) {
                    return Card(
                      elevation: 2.0,
                      color: Theme.of(context).cardTheme.color,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.transparent,
                              highlightColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 50,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.transparent,
                              highlightColor: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  color: Colors.black,
                                ),
                                width: size.width * 0.3,
                                height: size.height * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    );
                  }
                  return CryptoCard(
                    dataModel: modelData.data[index],
                  );
                },
                itemCount: modelData.data.length + 2,
              );
            },
            error: (error, _) {
              return Text('Something definitely went wrong here\n $error ');
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
