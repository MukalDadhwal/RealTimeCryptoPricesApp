import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSearchBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final Size size;
  final FocusNode focusNode;
  const AppSearchBar({
    super.key,
    required this.size,
    required this.focusNode,
  });

  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.05);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends ConsumerState<AppSearchBar> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        builder: (context, controller) => SearchBar(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          focusNode: widget.focusNode,
          elevation: MaterialStatePropertyAll(0),
          controller: _controller,
          hintText: 'Search',
          // backgroundColor: MaterialStatePropertyAll(Colors.white),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
        ),
        suggestionsBuilder: (context, controller) => [
          Text('hehe'),
          Text('hehe'),
          Text('haha'),
        ],
      ),
    );
  }
}
