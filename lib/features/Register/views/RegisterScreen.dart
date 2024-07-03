import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utilis/components/default_text_form.dart';
import 'package:shop_app/core/utilis/styles/custom_flutter_toast.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';
import 'package:shop_app/features/Register/views_model/register_cubit.dart';
import 'package:shop_app/features/login/presentation/views/login.dart';

import '../../../core/utilis/components/default_bottom.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var namecon = TextEditingController();
  var emailcon = TextEditingController();
  var passwordcon = TextEditingController();
  var phonecon = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel!.status!) {
              showToast(
                  text: state.loginModel!.message!, state: ToastStates.SUCCESS);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    padding: const EdgeInsets.all(18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: Textstyle.defaultstyleboldBlack
                                .copyWith(fontSize: 24),
                          ),
                          Text(
                            "You Can to Register In APP ",
                            style: Textstyle.defaultstylenormalBlack
                                .copyWith(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The Name Is Required";
                                }
                              },
                              title: "Name",
                              controller: namecon,
                              pref: Icon(Icons.person)),
                          SizedBox(
                            height: 7,
                          ),
                          DefaultTextForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The Phone Is Required";
                                }
                              },
                              keyboardType: TextInputType.phone,
                              title: "Phone",
                              controller: phonecon,
                              pref: Icon(Icons.call)),
                          SizedBox(
                            height: 7,
                          ),
                          DefaultTextForm(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The Email Is Required";
                                }
                              },
                              title: "Email",
                              controller: emailcon,
                              pref: Icon(Icons.email)),
                          SizedBox(
                            height: 7,
                          ),
                          DefaultTextForm(
                              obsecure: !RegisterCubit.get(context).obsecure,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The Password Is Required";
                                }
                              },
                              suffix: InkWell(
                                  onTap: () {
                                    RegisterCubit.get(context).changeicon();
                                  },
                                  child: RegisterCubit.get(context).obsecure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              title: "Password",
                              controller: passwordcon,
                              pref: Icon(Icons.lock)),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).UserRegister(
                                    email: emailcon.text,
                                    password: passwordcon.text,
                                    phone: phonecon.text,
                                    name: namecon.text);
                              }
                            },
                            title: "Register",
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
