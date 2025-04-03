import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../l10n/app_localizations.dart';
import '../../components/image_slider/custom_image_slider.dart';
import 'home_screen_widgets/custom_news_list.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the existing home screen content
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.initial) {
          context.read<HomeBloc>().add(LoadHomeData());
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == HomeStatus.loading) {
          return const Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                Text("Loading"),
              ],
            ),
          );
        }
        if (state.status == HomeStatus.failure) {
          final l10n = AppLocalizations.of(context);
          return Center(
            child: Text(
              state.error ?? l10n!.error,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(RefreshHomeData());
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    buildImageSlider(
                      context,
                      state.apodImages,
                      MediaQuery.of(context).size.height *
                          (MediaQuery.of(context).orientation == Orientation.portrait ? 0.3 : 0.5),
                      constraints,
                    ),
                    buildNewsList(
                      context,
                      state.newsItems,
                      constraints,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
