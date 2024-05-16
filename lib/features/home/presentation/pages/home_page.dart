import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_mock/core/injector.dart';
import 'package:flutter_dropdown_mock/features/home/data/models/place.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = sl<HomeCubit>();
  Place? selectedCountry;
  Place? selectedState;

  @override
  void initState() {
    bloc.loadCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: bloc,
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
                if (state is HomeStatesLoaded) getLoadedSateWidgets(state),
                if (state is HomeLoading)
                  Dialog.fullscreen(
                    backgroundColor: Colors.black.withOpacity(0.4),
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            value: state.stateSelection,
            hint: const Text('Select State'),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: state.states?.map((Place items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.value ?? ''),
                  );
                }).toList() ??
                [],
            onChanged: (ewValue) {
              bloc.selectState(ewValue as Place);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            value: state.countrySelection,
            hint: const Text('Select Country'),
            icon: const Icon(Icons.keyboard_arrow_down),
            padding: const EdgeInsets.all(4),
            items: state.countries?.map((Place items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.value ?? ''),
              );
            }).toList(),
            onChanged: (value) {
              bloc.selectCountry(value as Place);
            },
          ),
        ],
      ),
    );
  }
}
