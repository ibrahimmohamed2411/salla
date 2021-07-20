import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/models/favourites_model.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<ShopState>(context);
    return Consumer<ShopState>(
      builder: (ctx, Data, chile) => ListView.separated(
        itemBuilder: (ctx, index) =>
            BuildFavouriteItem(Data.favouritesModel.data.data[index].product),
        separatorBuilder: (ctx, index) => Divider(
          height: 15,
          color: Colors.grey,
        ),
        itemCount: Data.favouritesModel.data.data.length,
      ),
    );
  }
}

class BuildFavouriteItem extends StatelessWidget {
  final FavouritesProduct favouritesProduct;
  const BuildFavouriteItem(this.favouritesProduct);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopState>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  favouritesProduct.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (favouritesProduct.discount != 0)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favouritesProduct.name,
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
                        favouritesProduct.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (favouritesProduct.discount != 0)
                        Text(
                          favouritesProduct.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: defaultColor,
                        //Colors.grey,
                        child: IconButton(
                          onPressed: () async {
                            await provider.changeFavouriteState(
                                favouritesProduct, favouritesProduct.id);
                          },
                          icon: Icon(
                            // product.inFavorites
                            //     ?
                            Icons.favorite,
                            //      :
                            // Icons.favorite_outline_rounded,
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
      ),
    );
  }
}
