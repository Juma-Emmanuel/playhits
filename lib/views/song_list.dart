import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playhits/controller/song_controller.dart';

class SongListScreen extends StatelessWidget {
  final SongController songController = Get.put(SongController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs'),
      ),
      body: Obx(() {
        if (songController.songs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: songController.songs.length,
          itemBuilder: (context, index) {
            final song = songController.songs[index];
            return ListTile(
              title: Text(song.title),
              onTap: () {
                // Handle song tap
              },
            );
          },
        );
      }),
    );
  }
}
