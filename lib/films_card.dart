import 'package:flutter/material.dart';

class FilmsCard extends StatelessWidget {
  final String title;
  final String director;
  final String image;
  final Color backgroundColor;

  const FilmsCard({
    super.key,
    required this.title,
    required this.director,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            'Director - $director',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: image.isNotEmpty
                ? Image.network(
                    image,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 200);
                    },
                  )
                : const Icon(
                    Icons.image_not_supported,
                    size: 200,
                  ), // Fallback for no image
          ),
        ],
      ),
    );
  }
}
