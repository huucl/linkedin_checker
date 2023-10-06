import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.item, required this.stt,this.onTap});

  final LinkedinUserModel item;
  final int stt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (await canLaunchUrl(Uri.parse(item.url)) == true) {
          launchUrl(Uri.parse(item.url));
        }
      },
      onTap: () {

        onTap?.call();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#$stt',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: item.avatar,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
                placeholder: (
                  BuildContext context,
                  String url,
                ) {
                  return const Icon(Icons.person);
                },
                errorWidget: (_,__,___){
                  return CachedNetworkImage(imageUrl: 'https://media.licdn.com/dms/image/D4D0BAQH4TwiyEOT6Vg/company-logo_200_200/0/1686631084785?e=1704326400&v=beta&t=zkc8S6unhad3pfO2b34ilM5OFQsOQsg0spZSC_7ibPQ');
                } ,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                const SizedBox(width: 4),
                Text(Random().nextBool() == true ? '✅' : '🚫'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}