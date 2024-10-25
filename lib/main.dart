import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_bloc.dart';
import 'package:food_delivery/features/home/persentation/screen/home_screen.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_bloc.dart';
import 'package:food_delivery/features/restaurant_page/persentation/bloc/restaurant_bloc.dart';

void main() {
  runApp(const MyApp());
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
        BlocProvider(create: (_) => RestaurantBloc())
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
