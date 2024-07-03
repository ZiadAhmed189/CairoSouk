import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/Api/api_service.dart';
import 'package:shop_app/features/home/presentation/views_model/shopcubit_cubit.dart';
import 'package:shop_app/features/login/presentation/views/login.dart';

import 'constant.dart';
import 'core/Api/bloc_observer.dart';
import 'core/Api/cache_helper.dart';
import 'features/home/presentation/views/HomeScreen.dart';
import 'features/onboarding/presentation/views/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  OnBoarding = CacheHelper.getData(key: "OnBoarding");
  token = CacheHelper.getData(key: "token");
  Widget? Screen;
  if (OnBoarding != null) {
    if (token != null) {
      Screen = HomePage();
    } else
      Screen = LoginScreen();
  } else {
    Screen = OnboardingScreen();
  }
  print(OnBoarding);
  print(token);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    screen: Screen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.screen,
  });

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopcubitCubit()
            ..GetCategories()
            ..GetHome(),
        ),
      ],
      child: MaterialApp(
        home: screen,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
