import 'dart:convert';

class KeyModel {
  final String name;
  final String value;
  KeyModel({
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory KeyModel.fromMap(Map<String, dynamic> map) {
    return KeyModel(
      name: map['name'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyModel.fromJson(String source) => KeyModel.fromMap(json.decode(source));
}
