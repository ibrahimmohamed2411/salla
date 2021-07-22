import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/statemanagement/search_state.dart';
import 'package:salla/widgets/build_favourite_item.dart';
import 'package:salla/widgets/build_search_item.dart';
import 'package:salla/widgets/default_form_field.dart';

class SearchScreen extends StatelessWidget {
  static const String route = 'search-screen';
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SearchState(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<SearchState>(
              builder: (ctx, Data, child) => Column(
                children: [
                  DefaultFormField(
                    action: TextInputAction.search,
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter text to search';
                      }
                      return null;
                    },
                    icon: Icon(Icons.search),
                    labelText: 'Search',
                    onSubmit: (String text) async {
                      if (formKey.currentState!.validate()) {
                        Data.search(text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (Data.searchModel != null)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx, index) =>
                            BuildSearchItem(Data.searchModel!.data.data[index]),
                        separatorBuilder: (ctx, index) => Divider(
                          height: 15,
                          color: Colors.grey,
                        ),
                        itemCount: Data.searchModel!.data.data.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
