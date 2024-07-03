import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utilis/styles/textstyle.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopcubitCubit, ShopcubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Cairo Souk",
              style: Textstyle.defaultstyleboldBlack,
            ),
          ),
          body: ShopcubitCubit.get(context)
              .ScreenBody[ShopcubitCubit.get(context).indexscreen],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepOrange,
            currentIndex: ShopcubitCubit.get(context).indexscreen,
            onTap: (index) {
              ShopcubitCubit.get(context).change_index_screen(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
            ],
          ),
        );
      },
    );
  }
}
