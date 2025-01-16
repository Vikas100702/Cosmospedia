import 'package:equatable/equatable.dart';

class ApodModel extends Equatable {
  final String date;
  final String explanation;
  final String title;
  final String url;
  final String? copyright;

  const ApodModel({
    required this.date,
    required this.explanation,
    required this.title,
    required this.url,
    this.copyright,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'] as String,
      explanation: json['explanation'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      copyright: json['copyright'] as String?,
    );
  }

  @override
  List<Object?> get props => [date, explanation, title, url, copyright];
}