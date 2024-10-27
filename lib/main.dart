import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/screen/verification_screen.dart';
import 'package:food_delivery/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:food_delivery/features/cart/presentation/screen/cart_screen.dart';
import 'package:food_delivery/features/cart/presentation/widgets/cart_item.g.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_bloc.dart';
import 'package:food_delivery/features/home/persentation/screen/home_screen.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that widget binding is initialized
  await Hive.initFlutter(); // Initializes Hive

  // Open the box
  await Hive.openBox<Map<String, Object>>('cart');

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
        BlocProvider(create: (_) => ItemDetailBloc()),
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
        home: HomeScreen(),
      ),
    );
  }
}
