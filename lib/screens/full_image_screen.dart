import 'package:flutter/material.dart';
import 'package:gapopa_assignment/resources/app_images.dart' as app_images;

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({required this.imageLink, super.key});

  final String? imageLink;

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: FadeInImage(
          fit: BoxFit.fitWidth,
          width: double.infinity,
          placeholder: AssetImage(app_images.placeholder),
          image: NetworkImage(imageLink ?? ''),
          imageErrorBuilder: (final context, final error, final stackTrace) => Flexible(
            child: Image.asset(app_images.placeholder),
          ),
        ),
      );
}
