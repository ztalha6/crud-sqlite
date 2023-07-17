import 'package:flutter/material.dart';
import 'package:flutter_sqlite/app/data/database/database.dart';
import 'package:flutter_sqlite/app/data/model/item_model.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final Item? item;

  AddItemScreen({super.key, this.item}) {
    if (item != null) {
      _nameController.text = item!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveItem();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveItem() async {
    final name = _nameController.text;

    final itemDatabase = ItemDatabase.instance;
    if (item == null) {
      await itemDatabase.insertItem(Item(name: name));
    } else {
      final updatedItem = Item(id: item!.id, name: name);
      await itemDatabase.updateItem(updatedItem);
    }
    Get.back();
  }
}
