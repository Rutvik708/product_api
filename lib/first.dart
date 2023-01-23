import 'package:api_7_product/detail.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class products extends StatefulWidget {
  String? l;

  products(this.l);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  getproduct() async {
    var url = Uri.parse('https://dummyjson.com/products/category/${widget.l}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = demoProductFromJson(response.body);

      return data!.products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.l}", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.white,

      ),
      body: FutureBuilder(
        future: getproduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Product?> prod = snapshot.data;
            return ListView.builder(
              itemCount: prod.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    title: Text("${prod[index]!.title}"),
                    subtitle: Column(
                      children: [
                        Text("${prod[index]!.description}"),
                        Text(
                          "Price : ${prod[index]!.price}Rs.",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    leading: Container(
                      height: 300,
                      width: 100,
                      child: Image.network(
                        prod[index]!.thumbnail.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return detail(prod[index]!.id);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final demoProduct = demoProductFromJson(jsonString);

DemoProduct? demoProductFromJson(String str) =>
    DemoProduct.fromJson(json.decode(str));

String demoProductToJson(DemoProduct? data) => json.encode(data!.toJson());

class DemoProduct {
  DemoProduct({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  List<Product?>? products;
  int? total;
  int? skip;
  int? limit;

  factory DemoProduct.fromJson(Map<String, dynamic> json) => DemoProduct(
        products: json["products"] == null
            ? []
            : List<Product?>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x!.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String?>? images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"].toDouble(),
        rating: json["rating"].toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        images: json["images"] == null
            ? []
            : List<String?>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}
