import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/colors/app_colors.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_bloc.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_event.dart';
import 'package:food_delivery/features/profile/persentation/bloc/profile_state.dart';
import 'package:food_delivery/features/profile/persentation/widget/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfileEvent()),
      child: Scaffold(
        backgroundColor: AppColors.instance.white,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage:
                              AssetImage('assets/images/person.png'),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                state.userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                state.email,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        ProfileMenuItem(
                          title: 'My Orders',
                          iconPath: 'assets/icons/document.svg',
                        ),
                        ProfileMenuItem(
                          title: 'My Profile',
                          iconPath: 'assets/icons/profile.svg',
                        ),
                        ProfileMenuItem(
                          title: 'Delivery Address',
                          iconPath: 'assets/icons/location.svg',
                        ),
                        ProfileMenuItem(
                          title: 'Payment Methods',
                          iconPath: 'assets/icons/wallet.svg',
                        ),
                        ProfileMenuItem(
                          title: 'Contact Us',
                          iconPath: 'assets/icons/message.svg',
                        ),
                        ProfileMenuItem(
                          title: 'Settings',
                          iconPath: 'assets/icons/settings.svg',
                        ),
                        ProfileMenuItem(
                          title: 'Helps & FAQs',
                          iconPath: 'assets/icons/helps.svg',
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/power.svg'),
                      label: Text(
                        "Log Out",
                        style: TextStyle(color: AppColors.instance.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.instance.kPrimary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
