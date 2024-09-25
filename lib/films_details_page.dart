import 'package:flutter/material.dart';
import 'package:movies_app/downlaod_provider.dart';
import 'package:provider/provider.dart';

class FilmsDetailsPage extends StatefulWidget {
  final Map<String, dynamic> films;
  const FilmsDetailsPage({super.key, required this.films});

  @override
  _FilmsDetailsPageState createState() => _FilmsDetailsPageState();
}

class _FilmsDetailsPageState extends State<FilmsDetailsPage> {
  void onTap() {
    Provider.of<DownlaodProvider>(context, listen: false).addFilms(
      {
        'title': widget.films['name'] ?? 'Unknown title',
        'imageUrl': widget.films['image'] != null
            ? widget.films['image']['medium']
            : '',
        'director': widget.films['network'] != null
            ? widget.films['network']['name']
            : 'Unknown director',
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Movie added to Downloads'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              // Title
              Text(
                widget.films['name'] ?? 'Unknown title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              // Image
              widget.films['image'] != null
                  ? Image.network(
                      widget.films['image']['medium'],
                      height: MediaQuery.of(context).size.height *
                          0.4, // Responsive height
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Image not available'),
                    )
                  : const Text('Image not available'),
              const Spacer(),
              Text(
                '@summary-${widget.films['summary'] != null ? widget.films['summary'].substring(0, 70) : 'Unknown summary'}...',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  // Show full summary in a dialog or navigate to a new page
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Full Summary'),
                      content: Text(
                        widget.films['summary'] ?? 'Unknown summary',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                child: const Text('Read more'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 10, color: Colors.blue),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height *
                    0.2, // Responsive height
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 247, 249, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@Director-${widget.films['network'] != null ? widget.films['network']['name'] : 'Unknown director'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 50),
                      ),
                      child: const Text(
                        'Add to downloads',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
