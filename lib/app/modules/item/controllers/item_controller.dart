import 'package:flutter_sqlite/app/data/database/database.dart';
import 'package:flutter_sqlite/app/data/model/item_model.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final itemDatabase = ItemDatabase.instance;
    final itemList = await itemDatabase.getItems();
    items.value = itemList;
  }

  Future<void> deleteItem(Item item) async {
    final itemDatabase = ItemDatabase.instance;
    await itemDatabase.deleteItem(item.id!);
    fetchItems();
  }
}
