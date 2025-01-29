/*
import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:cosmospedia/ui/screens/news_screen/screen_news_widget/news_screen_appBar_leading_widget.dart';
import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosmospedia/blocs/news/news_bloc.dart';
import 'package:cosmospedia/data/models/apod.dart';
import 'dart:ui';

import '../../../l10n/app_localizations.dart';

class News extends StatelessWidget {
  final ApodModel apod;

  const News({super.key, required this.apod});

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
          if (state.status == NewsStatus.initial) {
            context.read<NewsBloc>().add(LoadNewsData());
            return const Center(child: CircularProgressIndicator());
            // return _buildLoadingState();
          } else if (state.status == NewsStatus.loading) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Loading"),
                ],
              ),
            );
            // return _buildLoadedState(context, state);
          } else if (state.status == NewsStatus.failure) {
            return Center(
              child: Text(
                state.error ?? l10n!.error,
                style: TextStyle(fontSize: SizeConfig.devicePixelRatio(4)),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<NewsBloc>().add(RefreshNewsData());
            },
            child: _buildLoadedState(context, state.newsItems),
          );
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, List<ApodModel> news) {
    if (news.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noNewsAvailable,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      itemCount: news.length,
        itemBuilder: (context, index) {
        final newsDetail  = news[index];
          return Stack(
            children: [
              // Full-screen image
              Image.network(
              newsDetail.url,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.95),
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              ),

              // Scrollable content
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Space for AppBar
                    const SizedBox(height: kToolbarHeight + 20),

                    // Title section with blur effect
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsDetail.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.cyanAccent,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        DateTime.parse(newsDetail.date)
                                            .toString()
                                            .substring(0, 10),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Main content with blur effect
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsDetail.explanation,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    height: 1.8,
                                    letterSpacing: 0.3,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                if (newsDetail.copyright != null &&
                                   newsDetail.copyright!.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  Text(
                                    '© ${newsDetail.copyright}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 24),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.cyanAccent.withOpacity(0.4),
                                          Colors.blueAccent.withOpacity(0.4),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Explore Universe',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.rocket_launch,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

  */
/*Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
          const SizedBox(height: 16),
          const Text(
            "Failed to load cosmic content",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }*//*

}
*/

import 'package:cosmospedia/ui/screens/news_screen/screen_news_widget/news_screen_appBar_leading_widget.dart';
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
    final screenSize = MediaQuery.of(context).size;

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
            /*return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: screenSize.height * 0.4,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      state.apod!.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          state.apod!.hdurl ?? state.apod!.url,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              state.apod!.date,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenSize.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                        if (state.apod!.copyright != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.copyright, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                state.apod!.copyright!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenSize.width * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        Text(
                          state.apod!.explanation,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );*/
          }
          return const SizedBox();
        },
      ),
    );
  }
}
