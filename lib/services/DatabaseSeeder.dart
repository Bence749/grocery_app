import 'package:sqflite/sqflite.dart';

import '../models/IngredientModel.dart';
import '../models/ProductModel.dart';
import '../services/DatabaseHandler.dart';

Future<void> seedDatabase() async {
  final Database db = await DatabaseHandler.getDB();

  // Manual list of ingredient names
  final List<String> ingredientNames = [
    'Chocolate',
    'Sugar',
    'Milk',
    'Wheat Flour',
    'Egg',
    'Nut',
  ];

  // Generate and insert ingredients
  final List<Ingredient> ingredients = [];
  for (var index = 0; index < ingredientNames.length; index++) {
    final ingredient = Ingredient(
      id: index + 1,
      name: ingredientNames[index],
      isSugarFree: ingredientNames[index] != 'Sugar',
      isLactoseFree: ingredientNames[index] != 'Milk',
      isNutFree: ingredientNames[index] != 'Nut',
      isWheatFree: ingredientNames[index] != 'Wheat Flour',
      isEggFree: ingredientNames[index] != 'Egg',
    );
    await db.insert('ingredients', ingredient.toJson());
    ingredients.add(ingredient);
  }

  // Manual list of product details
  final List<Map<String, dynamic>> productsData = [
    {
      'name': 'Milka Choco Wafer Single wafer filled with cocoa filling 30 g',
      'description':
          'Wafer filled with cocoa cream and coated with alpine milk chocolate. Place of origin: EU',
      'ingredientIndexes': [0, 1, 2, 3, 4, 5],
    },
    {
      'name':
          'Nestea peach flavored tea soft drink with sugar and sweetener 0.5 l',
      'description':
          'Low in energy, without the addition of preservatives or dyes',
      'ingredientIndexes': [1],
    },
  ];

  // Generate and insert products
  List<Product> products = [];
  for (var index = 0; index < productsData.length; index++) {
    final productData = productsData[index];
    final List<Ingredient> productIngredients = [];

    // Extract ingredients for this product
    for (final ingredientIndex in productData['ingredientIndexes']) {
      productIngredients.add(ingredients[ingredientIndex]);
    }

    final product = Product(
      id: index + 1,
      name: productData['name'],
      description: productData['description'],
      ingredients: productIngredients,
    );
    await db.insert('products', product.toJson());
    products.add(product);
  }

  await db.close();
}
