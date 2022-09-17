import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// A list tile for an article.
class NewsItem extends StatelessWidget {

  final String? title;
  final String? subtitle;
  final String? url;

  const NewsItem(
      {Key? key, this.title, this.subtitle, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var is_image = (url == "");
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
                      title!,
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
                      imageUrl: url!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                subtitle!,
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
