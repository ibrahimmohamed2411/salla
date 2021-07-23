import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:salla/constants.dart';
import 'package:salla/statemanagement/shop_login_state.dart';
import 'package:salla/statemanagement/shop_state.dart';
import 'package:salla/widgets/default_form_field.dart';
import 'package:salla/widgets/default_text_button.dart';

class SettingsScreen extends StatelessWidget {
  static var nameController = TextEditingController();
  static var emailController = TextEditingController();
  static var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopState>(context);
    if (provider.loginModel.data!.name != null) {
      nameController.text = provider.loginModel.data!.name!;
    }
    if (provider.loginModel.data!.email != null) {
      emailController.text = provider.loginModel.data!.email!;
    }
    if (provider.loginModel.data!.phone != null) {
      phoneController.text = provider.loginModel.data!.phone!;
    }
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DefaultFormField(
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Name';
                }
              },
              controller: nameController,
              icon: Icon(Icons.person),
              labelText: 'Name',
            ),
            SizedBox(
              height: 20,
            ),
            DefaultFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your email';
                }
              },
              controller: emailController,
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
            SizedBox(
              height: 20,
            ),
            DefaultFormField(
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Phone';
                }
              },
              controller: phoneController,
              icon: Icon(Icons.phone),
              labelText: 'Phone',
            ),
            DefaultTextButton(
              text: 'Logout',
              onPressed: () {
                signOut(context);
                provider.clearStates();
                Provider.of<ShopLoginState>(context, listen: false).clear();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTextButton(
              text: 'Update',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await provider.updateUserData(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                  nameController.text = provider.loginModel.data!.name!;
                  emailController.text = provider.loginModel.data!.email!;
                  phoneController.text = provider.loginModel.data!.phone!;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
