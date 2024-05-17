// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_mock/core/injector.dart';
import 'package:flutter_dropdown_mock/core/utils/app_colors.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/shared/bezier_container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cubit = sl<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                Positioned(
                  top:
                      -MediaQuery.of(context).size.height * Constants.size_0_15,
                  right:
                      -MediaQuery.of(context).size.width * Constants.size_0_4,
                  child: const BezierContainer(
                    gradientColors: AppColors.defaultGradientColors,
                  ),
                ),
                if (state is HomeStatesLoaded) getLoadedSateWidgets(state),
                if (state is HomeLoading)
                  Dialog.fullscreen(
                    backgroundColor:
                        AppColors.black.withOpacity(Constants.size_0_4),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getLoadedSateWidgets(HomeStatesLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          const Text(
            Constants.welcomeMessage,
            style: TextStyle(
              fontSize: Constants.size_32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            Constants.completeProfile,
            style: TextStyle(
              fontSize: Constants.size_20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: Constants.size_20,
          ),
          DropdownButtonFormField<Place>(
            isDense: true,
            isExpanded: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.radius_12),
              ),
              contentPadding: EdgeInsets.all(Constants.padding_16),
            ),
            value: state.countrySelection,
            hint: const Text(Constants.selectCountry),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: state.countries?.map((Place items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.value ?? ''),
              );
            }).toList(),
            onChanged: (value) {
              cubit.selectCountry(value);
            },
          ),
          const SizedBox(
            height: Constants.size_10,
          ),
          DropdownButtonFormField<Place>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.radius_12),
              ),
              contentPadding: EdgeInsets.all(Constants.padding_16),
            ),
            value: state.stateSelection,
            hint: const Text(Constants.selectState),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: state.states?.map((Place items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.value ?? ''),
              );
            }).toList(),
            onChanged: (ewValue) {
              cubit.selectState(ewValue);
            },
          ),
        ],
      ),
    );
  }
}
