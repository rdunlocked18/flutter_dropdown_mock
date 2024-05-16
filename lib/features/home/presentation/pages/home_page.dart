import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_mock/core/injector.dart';
import 'package:flutter_dropdown_mock/features/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: sl<HomeCubit>(),
      listener: (context, state) {},
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text('Working'),
          ),
        );
      },
    );
  }
}
