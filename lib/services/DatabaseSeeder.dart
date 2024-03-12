import 'package:faker/faker.dart';
import 'package:sqflite/sqflite.dart';

import '../models/ProductModel.dart';
import '../models/IngredientModel.dart';
import 'DatabaseHandler.dart';

Future<void> main() async {
  final Database db = await DatabaseHelper.getDB();
  final faker = Faker();

  // Generate and insert fake ingredients
  final List<Ingredient> ingredients = List.generate(10, (index) {
    final ingredient = Ingredient(
      id: index + 1,
      name: faker.food.cuisine(),
      isVegan: random.boolean(),
      isVegetarian: random.boolean(),
      isHalal: random.boolean(),
      isKosher: random.boolean(),
      isGlutenFree: random.boolean(),
      isLactoseFree: random.boolean(),
      isNutFree: random.boolean(),
      isSoyFree: random.boolean(),
      isEggFree: random.boolean(),
      isShellfishFree: random.boolean(),
      isPeanutFree: random.boolean(),
      isWheatFree: random.boolean(),
      isFishFree: random.boolean(),
      isDairyFree: random.boolean(),
      isSesameFree: random.boolean(),
      isCeleryFree: random.boolean(),
      isMustardFree: random.boolean(),
      isLupinFree: random.boolean(),
      isMolluscFree: random.boolean(),
      isAlcoholFree: random.boolean(),
      isCaffeineFree: random.boolean(),
      isSugarFree: random.boolean(),
    );
    db.insert('ingredients', ingredient.toJson());
    return ingredient;
  });


  // Generate and insert fake products
  List<Product> products = List.generate(10, (index) {
    List<Ingredient> productIngredients = [];
    // Randomly assign 1-5 ingredients to each product
    for (var i = 0; i < faker.randomGenerator.integer(5); i++) {
      productIngredients.add(ingredients[faker.randomGenerator.integer(10)]);
    }
    final product = Product(
      id: index + 1,
      name: faker.food.dish(),
      description: faker.lorem.sentence(),
      ingredients: productIngredients,
    );
    db.insert('products', product.toJson());
    return product;
  });

  products = await DatabaseHelper.getProducts();
  for (var product in products) {
    print('Product: ${product.name}');
    print('Description: ${product.description}');
    print('Ingredients:');
    product.ingredients.forEach((ingredient) {
      print('- ${ingredient.name}');
    });
    print('----------------------');
  }

  await db.close();
}
