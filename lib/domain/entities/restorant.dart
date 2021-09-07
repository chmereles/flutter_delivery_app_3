class Restaurant {
  const Restaurant({
    required this.name,
    required this.rating,
    required this.distance,
    required this.time,
    required this.foodList,
    required this.image,
    required this.logo,
  });

  final String name;
  final double rating;
  final String distance;
  final String time;
  final String image;
  final String logo;
  final List<String> foodList;
}

final restaurantList = <Restaurant>[
  const Restaurant(
      name: "Mc Donald's",
      rating: 5,
      distance: '2.1Km',
      time: '30 min',
      image: 'assets/retaurants/mc_donals.jpg',
      logo: 'assets/retaurants/mc_donals_logo.jpg',
      foodList: ['Burger', 'American food']),
  const Restaurant(
      name: 'Burger King',
      rating: 5,
      distance: '150m',
      time: '10 min',
      image: 'assets/retaurants/burger_king.jpeg',
      logo: 'assets/retaurants/burger_king_logo.jpeg',
      foodList: ['Burger', 'American food']),
];
