class CategoryTripModel {
  final String id;
  final String categoryName;
  final String? image;

  CategoryTripModel({required this.id, required this.categoryName, this.image});

  factory CategoryTripModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryTripModel(
      id: id,
      categoryName: data['categoryName'] ?? '',
      image: data['image'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'categoryName': categoryName, 'image': image};
  }
}
