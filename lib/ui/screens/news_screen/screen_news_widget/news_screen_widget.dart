import 'package:cosmospedia/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomNewsCard extends StatelessWidget {
  final String title;
  final String date;
  final String explanation;
  final String imageUrl;
  final String copyright;

  const CustomNewsCard({
    super.key,
    required this.title,
    required this.date,
    required this.explanation,
    required this.imageUrl,
    required this.copyright,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final DateTime date = DateTime.parse(this.date);
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(4),
        vertical: SizeConfig.height(1),
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.width(2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Gradient Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(SizeConfig.width(2)),
                ),
                child: Image.network(
                  imageUrl,
                  height: SizeConfig.height(25),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      Text(
                        "Loading Progress is null",
                        style: TextStyle(color: Colors.white),
                      );
                      return child;
                    }
                    return Container(
                      height: SizeConfig.height(25),
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(1),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.width(4.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (copyright.isNotEmpty) ...[
                        SizedBox(height: SizeConfig.height(1)),
                        Text(
                          '\u00a9 ${copyright.toString()}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: SizeConfig.width(3.2),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
            ],
          ),
          //Content Section
          Padding(
            padding: EdgeInsets.all(
              SizeConfig.width(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: SizeConfig.devicePixelRatio(16),
                    ),
                    SizedBox(width: SizeConfig.width(1)),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.width(3.2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(1.5)),
                Text(
                  explanation,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    // color: Colors.grey,
                    fontSize: SizeConfig.width(3.8),
                    height: SizeConfig.height(0.2),
                  ),
                  // overflow: TextOverflow.ellipsis  ,
                ),
                SizedBox(height: SizeConfig.height(1.5)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: SizeConfig.width(3.8),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
