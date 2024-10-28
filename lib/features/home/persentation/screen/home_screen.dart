import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_bloc.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_event.dart';
import 'package:food_delivery/features/home/persentation/bloc/home_state.dart';
import 'package:food_delivery/features/home/persentation/widget/category_icon.dart';
import 'package:food_delivery/features/home/persentation/widget/restourant_card.dart';
import 'package:food_delivery/features/profile/persentation/screen/profile_page.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final drawerController = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: const ProfileScreen(),
        mainScreen: _buildMainScreen(context),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        menuBackgroundColor: Colors.grey.shade300,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.85,
      ),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"name": "Burger", "icon": "assets/icons/burger.png"},
      {"name": "Donut", "icon": "assets/icons/donuts.png"},
      {"name": "Pizza", "icon": "assets/icons/pizza.png"},
      {"name": "Mexican", "icon": "assets/icons/hotdog.png"},
      {"name": "Asian", "icon": "assets/icons/cheese.png"},
    ];

    return Scaffold(
      backgroundColor: AppColors.instance.white,
      appBar: AppBar(
        backgroundColor: AppColors.instance.white,
        surfaceTintColor: AppColors.instance.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: drawerController.toggleDrawer, 
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset('assets/icons/menu.svg',
                    height: 15, width: 15),
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Deliver to",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.instance.grey),
                    ),
                    SvgPicture.asset('assets/icons/arrow_down.svg'),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "4102 Pretty View Lane",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.instance.kPrimary),
                ),
              ],
            ),
          ],
        ),
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.png'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What would you like\nto order",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildSearchBar()),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/icons/filter.svg',
                            height: 26, width: 26),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              String selectedCategory =
                  state is CategorySelectedState ? state.selectedCategory : "";

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryIconWidget(
                        categoryName: category['name']!,
                        iconPath: category['icon']!,
                        isSelected: category['name'] == selectedCategory,
                        onSelected: () {
                          context
                              .read<HomeBloc>()
                              .add(SelectCategoryEvent(category['name']!));
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Restaurants',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.instance.kPrimary),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.instance.kPrimary,
                      size: 13,
                    ),
                  ],
                ),
              ],
            ),
            const FoodCardWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Find for food or restaurant...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }
}
