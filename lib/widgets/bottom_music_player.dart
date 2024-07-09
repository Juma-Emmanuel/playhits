import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playhits/consts/colors.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:playhits/views/music_player.dart';
import 'package:marquee/marquee.dart';

class BottomMusicPlayerWidget extends StatelessWidget {
  const BottomMusicPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Obx(() {
      if (controller.isPlaying.value || controller.isPaused.value) {
        return GestureDetector(
          onTap: () {
            Get.to(() => MusicPlayer());
          },
          child: Container(
            height: screenHeight(context) * 0.09,
            color: Colors.black54,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                      height: 35,
                      width: 35,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.purple,
                        size: 30,
                      )),
                ),
                Expanded(
                  child: Marquee(
                    text: controller.songList[controller.playIndex.value].title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (controller.isPlaying.value) {
                        controller.pauseSong();
                      } else {
                        controller.resumeSong();
                      }
                    },
                    icon: controller.isPlaying.value
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                IconButton(
                    onPressed: () {
                      controller.stopSong();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
