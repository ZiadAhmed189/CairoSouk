import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/core/Api/cache_helper.dart';
import 'package:shop_app/core/utilis/styles/custom_flutter_toast.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';
import 'package:shop_app/features/Register/views/RegisterScreen.dart';
import 'package:shop_app/features/login/presentation/view_model/login_cubit.dart';

import '../../../../core/utilis/components/default_bottom.dart';
import '../../../../core/utilis/components/default_text_form.dart';
import '../../../home/presentation/views/HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailcon = TextEditingController();
  var passcon = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginModel.status!) {
              showToast(
                  text: state.loginModel!.message!, state: ToastStates.SUCCESS);
              token = state.loginModel.data!.token;
              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                print(token);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              });
            } else {
              showToast(
                  text: state.loginModel!.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: formkey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Textstyle.defaultstyleboldBlack
                                .copyWith(fontSize: 24),
                          ),
                          Text(
                            "Login now to browse our hot offers ",
                            style: Textstyle.defaultstylenormal
                                .copyWith(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextForm(
                            title: "Email Address",
                            controller: emailcon,
                            pref: Icon(Icons.email),
                            validator: (value) {
                              return "The Email is Required";
                            },
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          DefaultTextForm(
                              validator: (value) {
                                return "The Password is Required";
                              },
                              obsecure: !LoginCubit.get(context).obsecure,
                              title: "Password",
                              controller: passcon,
                              pref: Icon(Icons.lock),
                              suffix: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context).changeicon();
                                  },
                                  icon:
                                      LoginCubit.get(context).obsecure == false
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off))),
                          SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoginLoading,
                              builder: (context) => DefaultButton(
                                    title: "Login",
                                    onPressed: () {
                                      LoginCubit.get(context).userLogin(
                                          email: emailcon.text,
                                          password: passcon.text);
                                    },
                                  ),
                              fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: Kprimarycolor,
                                    ),
                                  )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have Account ?!",
                                style: Textstyle.defaultstylebold,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: Text(
                                    "Register Now ",
                                    style: Textstyle.defaultstyleboldBlack,
                                  ))
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
        },
      ),
    );
  }
}
