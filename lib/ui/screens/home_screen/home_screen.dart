import 'package:cosmospedia/blocs/home/home_bloc.dart';
import 'package:cosmospedia/blocs/home/home_event.dart';
import 'package:cosmospedia/blocs/home/home_state.dart';
import 'package:cosmospedia/l10n/app_localizations.dart';
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/size_config.dart';
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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // Calculate responsive values
    final double appBarHeight = screenSize.height * 0.08;
    final double carouselHeight = screenSize.height * (isPortrait ? 0.3 : 0.5);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
        )
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        appBar: const CustomAppBar(),

        /*appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            title: Text(
              l10n!.appName,
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: screenSize.width * 0.06,
                ),
                onPressed: () {
                  context.read<HomeBloc>().add(RefreshHomeData());
                },
                tooltip: l10n?.homeRefresh,
              ),
            ],
          ),
        ),*/
        drawer: const CustomAppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavigationBar(),
        /*bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "l10n!.home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "l10n!.explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "l10n!.profile",
            ),
          ],
          currentIndex: 0, // You'll need to manage this with state
          onTap: (index) {
            // Handle navigation here
          },
        ),*/

        body: SafeArea(
          bottom: false,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.initial) {
                context.read<HomeBloc>().add(LoadHomeData());
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == HomeStatus.loading) {
                return const Center(child: CircularProgressIndicator());
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
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
                  }
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
