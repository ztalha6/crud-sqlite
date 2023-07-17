import 'package:get/get.dart';

import '../modules/item/bindings/item_binding.dart';
import '../modules/item/views/item_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ITEM;

  static final routes = [
    GetPage(
      name: _Paths.ITEM,
      page: () => ItemListScreen(),
      binding: ItemBinding(),
    ),
  ];
}
