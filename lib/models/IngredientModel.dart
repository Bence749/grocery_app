class Ingredient {
  final int id;
  final String name;
  final bool isVegan;
  final bool isVegetarian;
  final bool isHalal;
  final bool isKosher;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isNutFree;
  final bool isSoyFree;
  final bool isEggFree;
  final bool isShellfishFree;
  final bool isPeanutFree;
  final bool isWheatFree;
  final bool isFishFree;
  final bool isDairyFree;
  final bool isSesameFree;
  final bool isCeleryFree;
  final bool isMustardFree;
  final bool isLupinFree;
  final bool isMolluscFree;
  final bool isAlcoholFree;
  final bool isCaffeineFree;
  final bool isSugarFree;

  Ingredient({
    required this.id,
    required this.name,
    required this.isVegan,
    required this.isVegetarian,
    required this.isHalal,
    required this.isKosher,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isNutFree,
    required this.isSoyFree,
    required this.isEggFree,
    required this.isShellfishFree,
    required this.isPeanutFree,
    required this.isWheatFree,
    required this.isFishFree,
    required this.isDairyFree,
    required this.isSesameFree,
    required this.isCeleryFree,
    required this.isMustardFree,
    required this.isLupinFree,
    required this.isMolluscFree,
    required this.isAlcoholFree,
    required this.isCaffeineFree,
    required this.isSugarFree,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
      'isHalal': isHalal,
      'isKosher': isKosher,
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'isNutFree': isNutFree,
      'isSoyFree': isSoyFree,
      'isEggFree': isEggFree,
      'isShellfishFree': isShellfishFree,
      'isPeanutFree': isPeanutFree,
      'isWheatFree': isWheatFree,
      'isFishFree': isFishFree,
      'isDairyFree': isDairyFree,
      'isSesameFree': isSesameFree,
      'isCeleryFree': isCeleryFree,
      'isMustardFree': isMustardFree,
      'isLupinFree': isLupinFree,
      'isMolluscFree': isMolluscFree,
      'isAlcoholFree': isAlcoholFree,
      'isCaffeineFree': isCaffeineFree,
      'isSugarFree': isSugarFree,
    };
  }
}
