import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_mock/core/injector.dart';
import 'package:flutter_dropdown_mock/core/utils/app_colors.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/pages/profile_page.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/widgets/common_dropdown.dart';

import '../../../../core/shared/bezier_container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cubit = sl<HomeCubit>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit,
      listener: (context, state) async {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(Constants.padding_16),
            ),
          );
        }
        if (state is HomeStatesLoaded && state.isValid) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                selectedCountry: state.stateSelection,
                selectedState: state.countrySelection,
              ),
            ),
          );
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
                if (state is HomeError)
                  Center(
                    child: TextButton.icon(
                      label: const Text(Constants.retry),
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        cubit.loadCountries();
                      },
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
          bottomNavigationBar: InkWell(
            onTap: () {
              cubit.submitClicked(formKey);
            },
            child: Container(
              height: Constants.size_72,
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Constants.radius_12),
                  topRight: Radius.circular(Constants.radius_12),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constants.submit,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: Constants.size_20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: AppColors.white,
                      size: Constants.size_32,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getLoadedSateWidgets(HomeStatesLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(Constants.padding_16),
      child: Form(
        key: formKey,
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
              height: Constants.size_5,
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
            CommonDropdown(
              items: state.countries ?? [],
              onChanged: (ewValue) {
                cubit.selectCountry(ewValue);
              },
              selection: state.countrySelection,
              hint: Constants.selectCountry,
              errorMessage: "${Constants.please} ${Constants.selectCountry}",
            ),
            const SizedBox(
              height: Constants.size_10,
            ),
            CommonDropdown(
              items: state.states ?? [],
              onChanged: (ewValue) {
                cubit.selectState(ewValue);
              },
              selection: state.stateSelection,
              hint: Constants.selectState,
              errorMessage: "${Constants.please} ${Constants.selectState}",
            ),
          ],
        ),
      ),
    );
  }
}
