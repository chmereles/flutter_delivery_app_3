class Food {
  const Food({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
  });

  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double rating;
}

final myFoodList = [
  const Food(
    id: 1,
    name: 'Chicken Burger',
    description: 'Sandwich features two savory flame-grilled beef patties',
    image: 'assets/images/burger_1.jpg',
    price: 99.99,
    rating: 4.5,
  ),
  const Food(
    id: 2,
    name: 'Cripcy Burger',
    description: 'Sandwich features two savory flame-grilled beef patties',
    image: 'assets/images/burger_1.jpg',
    price: 99.99,
    rating: 3.5,
  ),
  const Food(
    id: 3,
    name: 'Beef Burger Meel',
    description: 'Sandwich features two savory flame-grilled beef patties',
    image: 'assets/images/burger_1.jpg',
    price: 99.99,
    rating: 2.5,
  ),
  const Food(
    id: 4,
    name: 'Golden Double Burger Myffin',
    description: 'Sandwich features two savory flame-grilled beef patties',
    image: 'assets/images/burger_1.jpg',
    price: 99.99,
    rating: 2.5,
  ),
];
