class Item {
  int? id;
  String name;

  Item({required this.name, this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'name': name,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
    );
  }
}
