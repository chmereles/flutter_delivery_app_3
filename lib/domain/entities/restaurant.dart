class Restaurant {
  const Restaurant({
    required this.name,
    required this.rating,
    required this.distance,
    required this.time,
    required this.foodList,
    required this.image,
    required this.logo,
    required this.freeDelivery,
  });

  final String name;
  final double rating;
  final String distance;
  final String time;
  final String image;
  final String logo;
  final List<String> foodList;
  final bool freeDelivery;
}

final myRestaurantList = <Restaurant>[
  const Restaurant(
    name: "Mc Donald's",
    rating: 5,
    distance: '2.1Km',
    time: '30 min',
    image: 'assets/retaurants/mc_donals.jpg',
    logo: 'assets/retaurants/mc_donals_logo.jpg',
    foodList: ['Burger', 'American food'],
    freeDelivery: true,
  ),
  const Restaurant(
    name: 'Burger King',
    rating: 5,
    distance: '150m',
    time: '10 min',
    image: 'assets/retaurants/burger_king.jpeg',
    logo: 'assets/retaurants/burger_king_logo.jpeg',
    foodList: ['Burger', 'American food'],
    freeDelivery: false,
  ),
  const Restaurant(
    name: 'KFC',
    rating: 4.9,
    distance: '150m',
    time: '30 min',
    image: 'assets/retaurants/kfc_1.jpg',
    logo: 'assets/retaurants/burger_king_logo.jpeg',
    foodList: ['Chines', 'Fast food', 'Coffee'],
    freeDelivery: false,
  ),
  const Restaurant(
    name: 'Spice House',
    rating: 4.5,
    distance: '150m',
    time: '30 min',
    image: 'assets/retaurants/spice_house.jpg',
    logo: 'assets/retaurants/burger_king_logo.jpeg',
    foodList: ['Chines', 'Fast food', 'Coffee'],
    freeDelivery: false,
  ),
];
