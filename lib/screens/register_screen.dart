import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/components/components.dart';
import 'package:salla/network/local/cache_helper.dart';
import 'package:salla/screens/shop_screen.dart';
import 'package:salla/statemanagement/shop_login_state.dart';
import 'package:salla/widgets/default_form_field.dart';
import 'package:salla/widgets/default_text_button.dart';

import '../constants.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = 'register-screen';
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopLoginState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      'Registe r now to browse our offers',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DefaultFormField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      icon: Icon(Icons.person),
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.com'))
                          return 'Enter valid email';
                      },
                      icon: Icon(Icons.email_outlined),
                      labelText: 'Email Address',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter your phone number';
                        }
                      },
                      icon: Icon(Icons.phone),
                      labelText: 'Phone',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password is to short';
                        }
                      },
                      icon: Icon(Icons.lock_outline),
                      obscure: true,
                      labelText: 'Password',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var status = await provider.userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                            if (status) {
                              CacheHelper.saveData(
                                key: 'token',
                                value: provider.registerModel!.data!.token!,
                              ).then((value) {
                                //
                                token = provider.registerModel!.data!.token;
                                showToast(
                                    text: provider.registerModel!.message!,
                                    state: ToastState.SUCCESS,
                                    timeInSec: 1);
                                Navigator.of(context)
                                    .pushReplacementNamed(ShopScreen.route);
                              });
                            } else {
                              showToast(
                                text: provider.registerModel!.message!,
                                state: ToastState.ERROR,
                                timeInSec: 3,
                              );
                            }
                          }
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
