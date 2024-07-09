import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var isPaused = false.obs;
  // var duration = ''.obs;
  // var position = ''.obs;
  final RxString position = "00:00".obs;
  final RxString duration = "00:00".obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  final RxList<AudioSource> playlist = <AudioSource>[].obs;
  final RxBool isShuffling = false.obs;
  final List<SongModel> songList = <SongModel>[].obs;
  @override
  void onInit() {
    super.onInit();

    audioPlayer.positionStream.listen((pos) {
      value.value = pos.inSeconds.toDouble();
      position.value = formatDuration(pos);
    });

    audioPlayer.durationStream.listen((dur) {
      if (dur != null) {
        max.value = dur.inSeconds.toDouble();
        duration.value = formatDuration(dur);
      }
    });

    audioPlayer.sequenceStateStream.listen((event) {
      if (event != null) {
        playIndex.value = event.currentIndex ?? 0;
      }
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  changeDurationToSeconds1(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void changeDurationToSeconds(int seconds) {
    final newPosition = Duration(seconds: seconds);
    audioPlayer.seek(newPosition);
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  void skipToNext() {
    if (playIndex.value + 1 < songList.length) {
      playSongFromPlaylist(playIndex.value + 1);
    } else {
      playSongFromPlaylist(0);
    }
  }

  void pauseSong() {
    audioPlayer.pause();
    isPlaying.value = false;
    isPaused.value = true;
  }

  void resumeSong() {
    audioPlayer.play();
    isPlaying.value = true;
    isPaused.value = false;
  }

  void stopSong() {
    audioPlayer.stop();
    isPlaying.value = false;
  }

  void skipToPrevious() {
    if (playIndex.value > 0) {
      playSongFromPlaylist(playIndex.value - 1);
    } else {
      playSongFromPlaylist(songList.length - 1);
    }
  }

  Future<void> playSongFromPlaylist1(int index) async {
    if (index >= 0 && index < playlist.length) {
      playIndex.value = index;
      try {
        await audioPlayer.setAudioSource(
          ConcatenatingAudioSource(children: playlist),
          initialIndex: index,
        );
        audioPlayer.play();
        isPlaying(true);
        isPaused.value = false;
        updatePosition();
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> playSongFromPlaylist(int index) async {
    if (index >= 0 && index < songList.length) {
      playIndex.value = index;
      try {
        final audioSources = songList
            .map((song) => AudioSource.uri(Uri.parse(song.uri!)))
            .toList();
        await audioPlayer.setAudioSource(
          ConcatenatingAudioSource(children: audioSources),
          initialIndex: index,
        );
        audioPlayer.play();
        isPlaying(true);
        isPaused.value = false;
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      isPaused(false);
      updatePosition();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void shufflePlaylist() {
    isShuffling.toggle();
    if (isShuffling.value) {
      audioPlayer.setShuffleModeEnabled(true);
    } else {
      audioPlayer.setShuffleModeEnabled(false);
    }
  }

  void playAll() {
    try {
      audioPlayer.setAudioSource(ConcatenatingAudioSource(children: playlist));
      audioPlayer.play();
      isPlaying(true);
      isPaused(false);
      updatePosition();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> setPlaylistFromQuery(List<SongModel> songs) async {
    playlist.clear();
    for (var song in songs) {
      playlist.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
  }

  void updateSongList(List<SongModel> songs) {
    songList.clear();
    songList.addAll(songs);
  }
}
