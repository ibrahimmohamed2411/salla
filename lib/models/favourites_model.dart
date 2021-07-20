class FavouritesModel {
  bool status;
  dynamic message;
  Data data;

  FavouritesModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<Datum> data;
  dynamic prevPageUrl;

  Data({
    required this.data,
    this.prevPageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        prevPageUrl: json["prev_page_url"],
      );
}

class Datum {
  int id;
  FavouritesProduct product;
  Datum({
    required this.id,
    required this.product,
  });
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        product: FavouritesProduct.fromJson(json["product"]),
      );
}

class FavouritesProduct {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  bool inFavorites = true;
  FavouritesProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory FavouritesProduct.fromJson(Map<String, dynamic> json) =>
      FavouritesProduct(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );
}
