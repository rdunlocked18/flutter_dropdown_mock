import 'package:flutter/material.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            selectedCountry?.value ?? '',
          ),
        ],
      ),
    );
  }
}
