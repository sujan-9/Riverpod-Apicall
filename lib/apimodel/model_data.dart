/// The `ApiModel` class represents a model for an API response with an `id`, `title`, and `description`
/// field.
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiModel {
  final int id;
  final String title;
  final String description;

  ApiModel({required this.id, required this.title, required this.description});

  /// The above function is a factory constructor in Dart that creates an instance of the ApiModel class
  /// from a map of key-value pairs.
  ///
  /// Args:
  ///   map (Map<String, dynamic>): A map containing key-value pairs where the keys are strings and the
  /// values can be of any type.
  ///
  /// Returns:
  ///   The factory method is returning an instance of the class `ApiModel`.
  factory ApiModel.fromMap(Map<String, dynamic> map) {
    return ApiModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  factory ApiModel.fromJson(String source) =>
      ApiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
