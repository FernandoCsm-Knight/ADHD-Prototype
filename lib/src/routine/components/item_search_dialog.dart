import 'package:flutter/material.dart';
import 'package:prototype/src/common/components/item_card.dart';

class ItemSearchDialog extends StatefulWidget {
  final List<ItemCard> items;

  const ItemSearchDialog({required this.items, super.key});

  @override
  State<ItemSearchDialog> createState() => _ItemSearchDialogState();
}

class _ItemSearchDialogState extends State<ItemSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<ItemCard> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(() {
      setState(() {
        _filteredItems = widget.items
            .where((item) => item.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _filteredItems[index].onTap?.call(context);
              },
              child: _filteredItems[index],
            );
          },
        ),
      ),
    );
  }
}
