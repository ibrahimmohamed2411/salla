import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/widgets/build_favourite_item.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
