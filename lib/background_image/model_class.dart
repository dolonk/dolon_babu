class CategoryModelClass {
  final int id;
  final String allBackgroundCategories;

  CategoryModelClass({required this.id, required this.allBackgroundCategories});

  factory CategoryModelClass.fromJson(Map<String, dynamic> json) {
    return CategoryModelClass(
      id: json['id'] as int,
      allBackgroundCategories: json['allBackgroundCategoris'] as String,
    );
  }
}