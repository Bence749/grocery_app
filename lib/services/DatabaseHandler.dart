import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/ProductModel.dart';
import '../models/IngredientModel.dart';

class DatabaseHandler {
  static const int _version = 1;
  static const String _dbName = "Products.db";

  static Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT)");
      await db.execute(
          "CREATE TABLE ingredients(id INTEGER PRIMARY KEY, name TEXT NOT NULL)");
      await db.execute(
          "CREATE TABLE product_ingredients(product_id INTEGER, ingredient_id INTEGER, FOREIGN KEY(product_id) REFERENCES products(id), FOREIGN KEY(ingredient_id) REFERENCES ingredients(id))");
    }, version: _version);
  }

  // Get a product from the database by ID
  static Future<Product> getProduct(int id) async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> productMaps =
        await db.query('products', where: 'id = ?', whereArgs: [id]);
    final List<Map<String, dynamic>> ingredientMaps = await db.rawQuery('''
      SELECT ingredients.id, ingredients.name
      FROM ingredients
      INNER JOIN product_ingredients ON ingredients.id = product_ingredients.ingredient_id
      WHERE product_ingredients.product_id = ?
    ''', [id]);

    List<Ingredient> ingredients = ingredientMaps.map((map) {
      return Ingredient(
        id: map['id'],
        name: map['name'],

        isVegan: map['isVegan'],
        isVegetarian: map['isVegetarian'],
        isHalal: map['isHalal'],
        isKosher: map['isKosher'],
        isGlutenFree: map['isGlutenFree'],
        isLactoseFree: map['isLactoseFree'],
        isNutFree: map['isNutFree'],
        isSoyFree: map['isSoyFree'],
        isEggFree: map['isEggFree'],
        isShellfishFree: map['isShellfishFree'],
        isPeanutFree: map['isPeanutFree'],
        isWheatFree: map['isWheatFree'],
        isFishFree: map['isFishFree'],
        isDairyFree: map['isDairyFree'],
        isSesameFree: map['isSesameFree'],
        isCeleryFree: map['isCeleryFree'],
        isMustardFree: map['isMustardFree'],
        isLupinFree: map['isLupinFree'],
        isMolluscFree: map['isMolluscFree'],
        isAlcoholFree: map['isAlcoholFree'],
        isCaffeineFree: map['isCaffeineFree'],
        isSugarFree: map['isSugarFree'],
      );
    }).toList();

    return Product(
      id: productMaps[0]['id'],
      name: productMaps[0]['name'],
      description: productMaps[0]['description'],
      ingredients: ingredients,
    );
  }

  // Add a product to the database
  static Future<int> addProduct(Product product) async {
    final Database db = await getDB();
    int productId = await db.insert('products', product.toJson());
    await _linkIngredients(productId, product.ingredients);
    return productId;
  }

  // Helper function to link ingredients to a product
  static Future<void> _linkIngredients(
      int productId, List<Ingredient> ingredients) async {
    final Database db = await getDB();
    for (var ingredient in ingredients) {
      await db.rawInsert('''
        INSERT INTO product_ingredients(product_id, ingredient_id)
        VALUES(?, ?)
      ''', [productId, ingredient.id]);
    }
  }

  // Get all products from the database
  static Future<List<Product>> getProducts() async {
    final Database db = await getDB();
    final List<Map<String, dynamic>> productMaps = await db.query('products');
    List<Product> products = [];
    for (var productMap in productMaps) {
      products.add(await getProduct(productMap['id']));
    }
    return products;
  }

  // Update a product in the database
  static Future<int> updateProduct(Product product) async {
    final Database db = await getDB();
    int productId = await db.update('products', product.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
    await db.delete('product_ingredients',
        where: 'product_id = ?', whereArgs: [product.id]);
    await _linkIngredients(product.id, product.ingredients);
    return productId;
  }

  // Delete a product from the database
  static Future<int> deleteProduct(int id) async {
    final Database db = await getDB();
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
