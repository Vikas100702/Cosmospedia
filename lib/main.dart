import 'package:cosmospedia/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/home/home_bloc.dart';
import 'blocs/news/news_bloc.dart';
import 'data/repositories/apod_repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Repositories
  final apodRepository = ApodRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            apodRepository: apodRepository,
          ),
        ),
        BlocProvider(
          create: (context) => NewsBloc(),
        ),

      ],
      child: const MyApp(),
    ),
  );
}
