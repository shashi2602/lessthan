// To parse this JSON data, do
//
//     final Detailsjsonpage = DetailsjsonpageFromJson(jsonString);

import 'dart:convert';

Detailsjsonpage detailsjsonpageFromJson(String str) => Detailsjsonpage.fromJson(json.decode(str));

String detailsjsonpageToJson(Detailsjsonpage data) => json.encode(data.toJson());

class Detailsjsonpage {
    Data data;

    Detailsjsonpage({
        this.data,
    });

    factory Detailsjsonpage.fromJson(Map<String, dynamic> json) => new Detailsjsonpage(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    String productName;
    String productModel;
    String productBrand;
    String productId;
    String productRatings;
    String productMrp;
    String productCategory;
    String productSubCategory;
    bool isAvailable;
    List<String> availableColors;
    List<String> productImages;
    bool isComparable;
    bool specAvailable;
    bool reviewAvailable;
    List<Map<String, List<dynamic>>> stores;

    Data({
        this.productName,
        this.productModel,
        this.productBrand,
        this.productId,
        this.productRatings,
        this.productMrp,
        this.productCategory,
        this.productSubCategory,
        this.isAvailable,
        this.availableColors,
        this.productImages,
        this.isComparable,
        this.specAvailable,
        this.reviewAvailable,
        this.stores,
    });

    factory Data.fromJson(Map<String, dynamic> json) => new Data(
        productName: json["product_name"],
        productModel: json["product_model"],
        productBrand: json["product_brand"],
        productId: json["product_id"],
        productRatings: json["product_ratings"],
        productMrp: json["product_mrp"],
        productCategory: json["product_category"],
        productSubCategory: json["product_sub_category"],
        isAvailable: json["is_available"],
        availableColors: new List<String>.from(json["available_colors"].map((x) => x)),
        productImages: new List<String>.from(json["product_images"].map((x) => x)),
        isComparable: json["is_comparable"],
        specAvailable: json["spec_available"],
        reviewAvailable: json["review_available"],
        stores: new List<Map<String, List<dynamic>>>.from(json["stores"].map((x) => new Map.from(x).map((k, v) => new MapEntry<String, List<dynamic>>(k, new List<dynamic>.from(v.map((x) => x)))))),
    );

    Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_model": productModel,
        "product_brand": productBrand,
        "product_id": productId,
        "product_ratings": productRatings,
        "product_mrp": productMrp,
        "product_category": productCategory,
        "product_sub_category": productSubCategory,
        "is_available": isAvailable,
        "available_colors": new List<dynamic>.from(availableColors.map((x) => x)),
        "product_images": new List<dynamic>.from(productImages.map((x) => x)),
        "is_comparable": isComparable,
        "spec_available": specAvailable,
        "review_available": reviewAvailable,
        "stores": new List<dynamic>.from(stores.map((x) => new Map.from(x).map((k, v) => new MapEntry<String, dynamic>(k, new List<dynamic>.from(v.map((x) => x)))))),
    };
}
