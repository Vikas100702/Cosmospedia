import 'package:cosmospedia/blocs/home/home_bloc.dart';
import 'package:cosmospedia/blocs/home/home_event.dart';
import 'package:cosmospedia/blocs/home/home_state.dart';
import 'package:cosmospedia/l10n/app_localizations.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_drawer/app_drawer.dart';
import '../../components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'home_screen_widgets/custom_image_slider.dart';
import 'home_screen_widgets/custom_news_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Calculate responsive values
    final double appBarHeight = screenSize.height * 0.08;
    final double carouselHeight = screenSize.height * (isPortrait ? 0.3 : 0.5);

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.png"),
          )),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        appBar: const CustomAppBar(),
        drawer: const CustomAppDrawer(),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: const CircleBorder(),
            onPressed: () {},
            child: const Icon(
              Icons.home,
              color: Colors.black,
              size: 38,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<HomeBloc, HomeState>(
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
                return Center(
                  child: Text(
                    state.error ?? l10n!.error,
                    style: TextStyle(fontSize: screenSize.width * 0.04),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(RefreshHomeData());
                },
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        buildImageSlider(
                          context,
                          state.apodImages,
                          carouselHeight,
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
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
