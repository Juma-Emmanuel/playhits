import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:playhits/song.dart';

class SongController extends GetxController {
  var songs = <Song>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      final directory = await getExternalStorageDirectory();
      final songFiles = await _listFiles(directory!);
      songs.addAll(songFiles
          .map(
              (file) => Song(title: file.path.split('/').last, path: file.path))
          .toList());
    }
  }

  Future<List<File>> _listFiles(Directory dir) async {
    final List<File> files = [];
    final List<FileSystemEntity> entities =
        await dir.list(recursive: true).toList();
    for (FileSystemEntity entity in entities) {
      if (entity is File && _isAudioFile(entity.path)) {
        files.add(entity);
      }
    }
    return files;
  }

  bool _isAudioFile(String path) {
    final extension = path.split('.').last;
    return ['mp3', 'wav', 'm4a'].contains(extension);
  }
}
