import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// A list tile for an article.
class NewsItem extends StatelessWidget {
  const NewsItem({Key? key}) : super(key: key);

  // String get _formattedDurationInMinutes {
  //   final durationInMinutes = article.duration / 60;
  //   return '${durationInMinutes.toStringAsFixed(0)} mins';
  // }
  //
  // String get _formattedReleaseDate =>
  //     DateFormat('MMM d yyyy').format(article.releaseDate);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var is_image = true;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () async => _launchURL(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Title",
                      style: textTheme.subtitle1,
                    ),
                  ),
                  if (is_image = true != null)
                    const SizedBox(
                      width: 16,
                    ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "decription",
                style: textTheme.bodyText2,
              ),
              Text(
                "Date",
                style: textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final url = 'https://raywenderlich.com/redirect?uri=URL';
    if (Platform.isIOS || await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could\'nt launch the article\'s URL.'),
        ),
      );
    }
  }
}
