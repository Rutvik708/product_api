import 'package:flutter/material.dart';

class detail extends StatefulWidget {
  detail(int? id);



  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  getproduct() async {
    var url = Uri.parse('https://dummyjson.com/products/${widget.}');
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
    return Scaffold();
  }
}
