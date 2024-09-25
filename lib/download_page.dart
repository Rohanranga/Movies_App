import "package:flutter/material.dart";
import "package:movies_app/downlaod_provider.dart";
import "package:provider/provider.dart";

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final downloads = context.watch<DownlaodProvider>().download;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloaded movies '),
      ),
      body: ListView.builder(
        itemCount: downloads.length,
        itemBuilder: (context, index) {
          final downloadItem = downloads[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(downloadItem['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete ${downloadItem['title']} ?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        'Are you sure you want to delete ${downloadItem['title']} ',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<DownlaodProvider>()
                                .removefilms(downloadItem);

                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              downloadItem['title'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(downloadItem['director'].toString()),
          );
        },
      ),
    );
  }
}
