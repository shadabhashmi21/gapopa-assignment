import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gapopa_assignment/cubit/home_cubit.dart';
import 'package:gapopa_assignment/repository/home_repository.dart';
import 'package:gapopa_assignment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: 'Gapopa Assignment',
        theme: ThemeData(
          useMaterial3: true, // Enables Material 3 design for the app.
        ),
        // Provides [HomeCubit] to the widget tree.
        home: BlocProvider<HomeCubit>(
          create: (final _) => HomeCubit(HomeRepository()),
          child: HomeScreen(),
        ),
      );
}
