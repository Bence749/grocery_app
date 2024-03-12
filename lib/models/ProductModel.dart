import 'IngredientModel.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final List<Ingredient> ingredients;

  Product({required this.id, required this.name, required this.description, required this.ingredients});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients.map((ingredient) => ingredient.id).toList(),
    };
  }
}
