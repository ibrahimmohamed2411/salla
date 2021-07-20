import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:salla/models/home_model.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/styles/colors.dart';

class BuildGridProduct extends StatelessWidget {
  final Product product;
  const BuildGridProduct(this.product);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopState>(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                '${product.image}',
                width: double.infinity,
                height: 200,
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                Row(
                  children: [
                    Text(
                      product.price.round().toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.oldPrice.round().toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          product.inFavorites ? defaultColor : Colors.grey,
                      child: IconButton(
                        onPressed: () async {
                          await provider.changeFavouriteState(
                            product,
                            product.id,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            elevation: 10.0,
                            padding: const EdgeInsets.all(8.0),
                            content: Text(
                              provider.changeFavouritesModel.message,
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.white,
                          ));
                        },
                        icon: Icon(
                          product.inFavorites
                              ? Icons.favorite
                              : Icons.favorite_outline_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
