import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/home/home_event.dart';
import '../../../blocs/home/home_state.dart';
import '../../../data/models/apod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/image_slider/custom_image_slider.dart';
import 'home_screen_widgets/custom_news_list.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize data loading when widget is first built
    context.read<HomeBloc>().add(LoadHomeData());

    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Create a GlobalKey for the Scaffold
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // This is the existing home screen content
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          scaffoldKey: scaffoldKey,
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              l10n!.appName,
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            /*if (state.status == HomeStatus.initial) {
              context.read<HomeBloc>().add(LoadHomeData());
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == HomeStatus.loading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading"),
                  ],
                ),
              );
            }*/
            if (state.status == HomeStatus.loading &&
                state.apodImages.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              );
            }

            // Show cached data even if we're loading new data during refresh

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(RefreshHomeData());
              },
              /*child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        buildImageSlider(
                          context,
                          _prepareApodDataForSlider(state.apodImages),
                          MediaQuery.of(context).size.height *
                              (MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 0.3
                                  : 0.5),
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
              ),*/
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    if (state.apodImages.isNotEmpty)
                      buildImageSlider(
                        context,
                        _prepareApodDataForSlider(state.apodImages),
                        MediaQuery.of(context).size.height *
                            (isPortrait ? 0.3 : 0.5),
                        BoxConstraints(maxWidth: screenSize.width),
                      ),
                    if (state.newsItems.isNotEmpty)
                      buildNewsList(
                        context,
                        state.newsItems,
                        BoxConstraints(maxWidth: screenSize.width),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Map<String, String>> _prepareApodDataForSlider(
      List<ApodModel> apodImages) {
    return apodImages.map((apod) {
      return {
        'url': apod.url,
        'title': apod.title,
        'date': apod.date,
        'description': apod.explanation,
      };
    }).toList();
  }
}
