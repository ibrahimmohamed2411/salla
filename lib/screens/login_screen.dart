import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:salla/components/components.dart';
import 'package:salla/network/local/cache_helper.dart';
import 'package:salla/widgets/default_text_button.dart';
import 'package:salla/screens/register_screen.dart';
import 'package:salla/screens/shop_screen.dart';
import 'package:salla/statemanagement/shop_login_state.dart';

class LoginScreen extends StatelessWidget {
  static const String route = 'login-screen';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopLoginState>(context, listen: false);
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      'login now to browse our offers',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customTextFormField(
                      controller: emailController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.com'))
                          return 'Enter valid email';
                      },
                      label: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customTextFormField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password is to short';
                        }
                      },
                      label: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isObscure: true,
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
                            var status = await provider.userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            if (status) {
                              CacheHelper.saveData(
                                key: 'token',
                                value: provider.loginModel!.data!.token!,
                              ).then((value) {
                                showToast(
                                    text: provider.loginModel!.message!,
                                    state: ToastState.SUCCESS,
                                    timeInSec: 1);
                                Navigator.of(context)
                                    .pushReplacementNamed(ShopScreen.route);
                              });
                            } else {
                              showToast(
                                  text: provider.loginModel!.message!,
                                  state: ToastState.ERROR,
                                  timeInSec: 4);
                            }
                          }
                        },
                        child: Text('LOGIN'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have any account ?',
                        ),
                        DefaultTextButton(
                          text: 'Register',
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.route);
                          },
                        ),
                      ],
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

  Widget customTextFormField({
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
    required String label,
    required IconData prefixIcon,
    bool isObscure = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(),
      ),
    );
  }
}
