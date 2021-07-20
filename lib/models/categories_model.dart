// CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));
//
// String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    required this.status,
    required this.data,
  });

  bool status;
  CategoriesDataModel data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        data: CategoriesDataModel.fromJson(json["data"]),
      );
}

class CategoriesDataModel {
  late int currentPage;
  late List<DataModel> data;
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  dynamic nextPageUrl;
  late String path;
  late int perPage;
  dynamic prevPageUrl;
  late int to;
  late int total;
  CategoriesDataModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      CategoriesDataModel(
        currentPage: json["current_page"],
        data: List<DataModel>.from(
            json["data"].map((x) => DataModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class DataModel {
  DataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
