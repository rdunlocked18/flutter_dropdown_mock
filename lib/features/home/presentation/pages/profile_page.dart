import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_mock/core/shared/bezier_container_widget.dart';
import 'package:flutter_dropdown_mock/core/utils/app_colors.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/pages/home_page.dart';

class ProfilePage extends StatelessWidget {
  final Place? selectedCountry;
  final Place? selectedState;
  const ProfilePage({
    super.key,
    required this.selectedCountry,
    required this.selectedState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIn(
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height * Constants.size_0_15,
              right: -MediaQuery.of(context).size.width * Constants.size_0_4,
              child: const BezierContainer(
                gradientColors: AppColors.defaultGradientColors,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kToolbarHeight + Constants.size_32,
              ),
              child: Column(
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: Constants.radius_60,
                      backgroundImage: NetworkImage(
                        Constants.profileUrl,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.size_32),
                  Center(
                    child: Text(
                      Constants.yourSelectedCountry,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: Constants.size_10),
                  Center(
                    child: Text(
                      selectedCountry?.value ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: Constants.size_20),
                  Center(
                    child: Text(
                      Constants.yourSelectedState,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: Constants.size_10),
                  Center(
                    child: Text(
                      selectedState?.value ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: Constants.size_32),
                  Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      label: const Text(Constants.reselectPlace),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
