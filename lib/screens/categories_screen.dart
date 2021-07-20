import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/widgets/build_category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopState>(
      builder: (ctx, Data, child) => ListView.separated(
        itemBuilder: (ctx, index) => BuildCategoryItem(
          Data.categoriesModel.data.data[index],
        ),
        separatorBuilder: (ctx, index) => Divider(
          height: 15,
          color: Colors.grey,
        ),
        itemCount: Data.categoriesModel.data.data.length,
      ),
    );
  }
}
