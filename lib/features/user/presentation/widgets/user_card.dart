import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/user.dart';
import '../pages/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: user.avatar,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const CircleAvatar(
                radius: 30,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 30,
              backgroundImage: imageProvider,
            ),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.email),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailPage(userId: user.id),
              ),
            );
          },
        ),
      ),
    );
  }
}