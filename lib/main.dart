import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/presentation/screen/cart_screen.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_bloc.dart';
import 'package:food_delivery/features/home/persentation/screen/home_screen.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_bloc.dart';
import 'package:food_delivery/features/welcome/presentation/screen/splash_screen.dart';
import 'package:food_delivery/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('cartBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => DetailBloc()),
        BlocProvider(create: (_) => RestaurantBloc()),
        BlocProvider(create: (_) => CartBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoom Drawer Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
