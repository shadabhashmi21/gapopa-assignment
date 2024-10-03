import 'package:flutter/material.dart';
import 'package:gapopa_assignment/resources/app_images.dart' as app_images;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (final context, final constraints) {
          const itemWidth = 200;
          final crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: 20,
            itemBuilder: (final BuildContext context, final int index) => _ImageGrid(
              image: 'https://fostereducation.co.in/wp-content/uploads/2022/08/image.jpg', // Add your image URL here
              likesCount: 120,
              viewsCount: 300,
            ),
          );
        },
      ),
    );
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({required this.image, required this.likesCount, required this.viewsCount});

  final String image;
  final int likesCount;
  final int viewsCount;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 3,
    child: Column(
      children: [
        FadeInImage(
          placeholder: AssetImage(app_images.placeholder),
          image: NetworkImage(image),
          imageErrorBuilder: (final context, final error, final stackTrace) => Image.asset(
            app_images.placeholder,
            height: 120,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Likes: $likesCount',
          style: TextStyle(fontSize: 15),
        ),
        Text(
          'Views: $viewsCount',
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}
