import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/styles/colors.dart';

class BuildSearchItem extends StatelessWidget {
  final Product product;
  const BuildSearchItem(this.product);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopState>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Image.network(
              product.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        product.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
