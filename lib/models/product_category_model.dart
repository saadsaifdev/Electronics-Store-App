class StoreCategoryModel {
  final String image;
  final String categoryName;
  final String apiSlug;
  final String? brandFilter;

  const StoreCategoryModel({
    required this.image,
    required this.categoryName,
    required this.apiSlug,
    this.brandFilter,
  });
}
