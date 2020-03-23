import 'package:flutter/material.dart';

import 'package:routines/const.dart';

import 'package:routines/blocs/bloc_provider.dart';
import 'package:routines/blocs/routine_bloc.dart';

import 'package:routines/widgets/home/page.dart';
import 'package:routines/widgets/about/page.dart';
import 'package:routines/widgets/routine/edit_form.dart';
import 'package:routines/widgets/routine/list_page.dart';

void main() {
  return runApp(
    BlocProvider<RoutineBloc>(
      bloc: RoutineBloc(), // Add Bloc Here
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routines App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Const.ROUTE_ABOUT_PAGE: (context) => AboutPage(),
        Const.ROUTE_ROUTINE_LIST_PAGE: (context) => RoutineListPage(),
        Const.ROUTE_ROUTINE_EDIT_FORM: (context) =>
            RoutineEditForm(routine: ModalRoute.of(context).settings.arguments),
      },
      home: HomePage(title: 'Routines!'),
    );
  }
}
