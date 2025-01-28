import 'package:cosmospedia/blocs/news/news_bloc.dart';
import 'package:cosmospedia/data/models/apod.dart';
import 'package:cosmospedia/ui/screens/news_screen/screen_news_widget/news_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class News extends StatelessWidget {
  final ApodModel apod;

  const News({super.key, required this.apod});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(LoadNewsEvent(apod)),
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              Text("Initial State", style: TextStyle(color: Colors.white),);
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              // final apodNews = state.apodNews;

              return SingleChildScrollView(
                child: CustomNewsCard(
                  /*title: apodNews.title,
                  date: apodNews.date,
                  explanation: apodNews.explanation,
                  imageUrl: apodNews.url,
                  copyright: apodNews.copyright!,*/
                  title: state.apodNews.title,
                  date: state.apodNews.date,
                  explanation: state.apodNews.explanation,
                  imageUrl: state.apodNews.url,
                  copyright: state.apodNews.copyright??'',
                ),
              );
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
