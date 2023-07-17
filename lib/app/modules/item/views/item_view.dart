import 'package:flutter/material.dart';
import 'package:flutter_sqlite/app/data/model/item_model.dart';
import 'package:flutter_sqlite/app/modules/item/controllers/item_controller.dart';
import 'package:flutter_sqlite/app/modules/item/views/add_item_view.dart';
import 'package:get/get.dart';

class ItemListScreen extends StatelessWidget {
  final ItemController itemListController = Get.put(ItemController());

  ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item List')),
      body: Obx(() {
        if (itemListController.items.isEmpty) {
          return const Center(child: Text('No items found.'));
        } else {
          return ListView.builder(
            itemCount: itemListController.items.length,
            itemBuilder: (context, index) {
              final item = itemListController.items[index];
              return ListTile(
                title: Text(item.name),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showOptions(context, item);
                  },
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(() => AddItemScreen());
          itemListController.fetchItems();
        },
      ),
    );
  }

  void showOptions(BuildContext context, Item item) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () async {
                await Get.to(() => AddItemScreen(item: item));
                Get.back();
                Get.find<ItemController>().fetchItems();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                itemListController.deleteItem(item);
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
