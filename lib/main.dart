import 'package:cosmospedia/app.dart';
import 'package:cosmospedia/blocs/asteroids/asteroids_bloc.dart';
import 'package:cosmospedia/blocs/favorites/favorites_bloc.dart';
import 'package:cosmospedia/blocs/rover_manifest/rover_manifest_bloc.dart';
import 'package:cosmospedia/blocs/sign_in/sign_in_bloc.dart';
import 'package:cosmospedia/blocs/space_weather/cme/cme_bloc.dart';
import 'package:cosmospedia/blocs/space_weather/gst/gst_bloc.dart';
import 'package:cosmospedia/data/repositories/asteroids/asteroids_repository.dart';
import 'package:cosmospedia/data/repositories/mars/rover_manifest_repository.dart';
import 'package:cosmospedia/data/repositories/space_weather/cme_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/home/home_bloc.dart';
import 'blocs/news/news_bloc.dart';
import 'blocs/rover/rover_bloc.dart';
import 'data/repositories/apod_repositories.dart';
import 'data/repositories/mars/rover_repositories.dart';
import 'data/repositories/space_weather/gst_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Initialize Repositories
  final apodRepository = ApodRepository();
  final roverRepository = RoverRepository();
  final asteroidRepository = AsteroidsRepository();
  final cmeRepository = CMERepository();
  final gstRepository = GstRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: apodRepository),
        RepositoryProvider.value(value: roverRepository),
        RepositoryProvider.value(value: asteroidRepository),
        RepositoryProvider.value(value: cmeRepository),
        RepositoryProvider.value(value: gstRepository),
        RepositoryProvider(
          create: (_) => RoverManifestRepository(),
        ),
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
          BlocProvider(
            create: (context) => RoverBloc(
              roverRepository: roverRepository,
            ),
          ),
          BlocProvider(
            create: (context) => RoverManifestBloc(
              roverManifestRepository: context.read<RoverManifestRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc(),
          ),
          BlocProvider(
            create: (context) => AsteroidsBloc(
              asteroidsRepository: context.read<AsteroidsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CMEBloc(
              cmeRepository: context.read<CMERepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => GstBloc(
              gstRepository: context.read<GstRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}