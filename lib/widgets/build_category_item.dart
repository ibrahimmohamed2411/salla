import 'package:flutter/material.dart';
import 'package:salla/models/categories_model.dart';

class BuildCategoryItem extends StatelessWidget {
  final DataModel dataModel;
  const BuildCategoryItem(this.dataModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              dataModel.image,
            ),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            dataModel.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
