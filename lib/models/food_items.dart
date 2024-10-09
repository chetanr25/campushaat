// class FoodItem {
//   final String creatorImageUrl;
//   final String title;
//   final int productPreparationTime;
//   final String info;
//   final String id;
//   final double mrp;
//   final double discount;
//   final double off;
//   final String productId;
//   final double originalPrice;
//   final String mediaUrls;

//   FoodItem({
//     required this.creatorImageUrl,
//     required this.title,
//     required this.productPreparationTime,
//     required this.info,
//     required this.id,
//     required this.mrp,
//     required this.discount,
//     required this.off,
//     required this.productId,
//     required this.originalPrice,
//     required this.mediaUrls,
//   });

//   factory FoodItem.fromJson(Map<String, dynamic> json) {
//     String capatilise(String s) {
//       return s[0].toUpperCase() +
//           s.substring(
//             1,
//           );
//     }

//     return FoodItem(
//       creatorImageUrl: json['productSoldBy']['creatorImageUrl'] ?? '',
//       mediaUrls: json['media']['mediaUrls'][0] ?? '',
//       title: capatilise(json['title'].toString()),
//       productPreparationTime: json['productPreparationTime'] ?? 0,
//       info: json['info'] ?? '',
//       id: json['id'] ?? '',
//       mrp: json['mrp']?.toDouble() ?? 0.0,
//       discount: json['discount']?.toDouble() ?? 0.0,
//       off: json['productPricing']['off']?.toDouble() ?? 0.0,
//       productId: json['productId'] ?? '',
//       originalPrice: json['productPricing']['originalPrice']?.toDouble() ?? 0.0,
//     );
//   }
// }

class FoodItem {
  final String id;
  final String productId;
  final String title;
  final String info;
  final List<String> mediaUrls;
  final String status;
  final double discount;
  final double mrp;
  final double off;
  final int orderQuantityTotal;
  final int orderTotal;
  final int productPreparationTime;
  final ProductPricing productPricing;
  final int productQuantity;
  final ProductSoldBy productSoldBy;
  final int productTotalSale;
  final double sale;

  FoodItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.info,
    required this.mediaUrls,
    required this.status,
    required this.discount,
    required this.mrp,
    required this.off,
    required this.orderQuantityTotal,
    required this.orderTotal,
    required this.productPreparationTime,
    required this.productPricing,
    required this.productQuantity,
    required this.productSoldBy,
    required this.productTotalSale,
    required this.sale,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      info: json['info'] ?? '',
      mediaUrls: List<String>.from(json['media']['mediaUrls'] ?? []),
      status: json['status']['ATVP'] ?? '',
      discount: json['discount']?.toDouble() ?? 0.0,
      mrp: json['mrp']?.toDouble() ?? 0.0,
      off: json['off']?.toDouble() ?? 0.0,
      orderQuantityTotal: json['orderQuantityTotal'] ?? 0,
      orderTotal: json['orderTotal'] ?? 0,
      productPreparationTime: json['productPreparationTime'] ?? 0,
      productPricing: ProductPricing.fromJson(json['productPricing'] ?? {}),
      productQuantity: json['productQuantity'] ?? 0,
      productSoldBy: ProductSoldBy.fromJson(json['productSoldBy'] ?? {}),
      productTotalSale: json['productTotalSale'] ?? 0,
      sale: json['sale']?.toDouble() ?? 0.0,
    );
  }
}

class ProductPricing {
  final double discount;
  final int isTax;
  final int minQty;
  final double off;
  final double originalPrice;
  final double price;
  final String priceId;
  final String priceText;
  final int quantity;
  final String unit;

  ProductPricing({
    required this.discount,
    required this.isTax,
    required this.minQty,
    required this.off,
    required this.originalPrice,
    required this.price,
    required this.priceId,
    required this.priceText,
    required this.quantity,
    required this.unit,
  });

  factory ProductPricing.fromJson(Map<String, dynamic> json) {
    return ProductPricing(
      discount: json['discount']?.toDouble() ?? 0.0,
      isTax: json['isTax'] ?? 0,
      minQty: json['minQty'] ?? 0,
      off: json['off']?.toDouble() ?? 0.0,
      originalPrice: json['originalPrice']?.toDouble() ?? 0.0,
      price: json['price']?.toDouble() ?? 0.0,
      priceId: json['priceId'] ?? '',
      priceText: json['priceText'] ?? '',
      quantity: json['quantity'] ?? 0,
      unit: json['unit']['categoryTitle'] ?? '',
    );
  }
}

class ProductSoldBy {
  final String creatorImageUrl;
  final String creatorName;
  final String id;

  ProductSoldBy({
    required this.creatorImageUrl,
    required this.creatorName,
    required this.id,
  });

  factory ProductSoldBy.fromJson(Map<String, dynamic> json) {
    return ProductSoldBy(
      creatorImageUrl: json['creatorImageUrl'] ?? '',
      creatorName: json['creatorName'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
