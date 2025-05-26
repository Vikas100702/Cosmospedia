import 'package:cosmospedia/ui/screens/news_screen/screen_news_widget/news_screen_appbar_leading_widget.dart';
import 'package:cosmospedia/ui/screens/news_screen/screen_news_widget/news_screen_load_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/news/news_bloc.dart';
import '../../../blocs/news/news_event.dart';
import '../../../blocs/news/news_state.dart';
import '../../../data/models/apod.dart';
import '../../../l10n/app_localizations.dart';
import '../../components/custom_app_bar/custom_app_bar.dart';

class NewsScreen extends StatelessWidget {
  final ApodModel apod;

  const NewsScreen({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    context.read<NewsBloc>().add(LoadNewsDetails(apod));
    return const NewsView();
  }
}

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: customAppBar(
        context: context,
        leading: newsAppBarLeadingWidget(context: context),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.status == NewsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NewsStatus.failure) {
            return Center(child: Text(state.error ?? l10n!.error));
          }
          if (state.status == NewsStatus.success && state.apod != null) {
            return buildLoadedState(
              context,
              state.apod!,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
