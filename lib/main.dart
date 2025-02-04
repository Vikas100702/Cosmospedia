import 'package:cosmospedia/app.dart';
import 'package:cosmospedia/blocs/sign_in/sign_in_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/home/home_bloc.dart';
import 'blocs/news/news_bloc.dart';
import 'data/repositories/apod_repositories.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Initialize Repositories
  final apodRepository = ApodRepository();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: apodRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              apodRepository: apodRepository,
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc(
              apodRepository: apodRepository,
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
