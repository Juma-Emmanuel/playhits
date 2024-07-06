import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playhits/consts/colors.dart';
import 'package:playhits/consts/text_style.dart';
import 'package:playhits/controller/player_controller.dart';
import 'package:get/get.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  Player({super.key, required this.data});
  final PlayerController controller = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: 700,
            child: Column(
              children: [
                Obx(
                  () => Expanded(
                      child: Container(
                    height: 300,
                    width: 300,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 48,
                        color: whiteColor,
                      ),
                    ),
                  )),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  child: Obx(
                    () => Column(
                      children: [
                        Text(
                          controller.songList[controller.playIndex.value]
                              .displayNameWOExt,
                          // data[controller.playIndex.value].displayNameWOExt,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textStyles(size: 20, color: bgDarkColor),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          // controller.songList[controller.playIndex.value]
                          data[controller.playIndex.value].artist.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textStyles(size: 20, color: bgDarkColor),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                controller.position.value,
                                style: textStyles(color: bgDarkColor),
                              ),
                              Expanded(
                                  child: Slider(
                                      thumbColor: sliderColor,
                                      inactiveColor: bgColor,
                                      min: const Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: controller.max.value,
                                      value: controller.value.value,
                                      onChanged: (newValue) {
                                        controller.changeDurationToSeconds(
                                            newValue.toInt());
                                        newValue = newValue;
                                      })),
                              Text(
                                controller.duration.value,
                                style: textStyles(color: bgDarkColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (controller.playIndex.value == 0) {
                                  controller.playSong(data[data.length - 1].uri,
                                      data.length - 1);
                                } else {
                                  controller.playSong(
                                      data[controller.playIndex.value - 1].uri,
                                      controller.playIndex.value - 1);
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 40,
                              ),
                            ),
                            Obx(
                              () => CircleAvatar(
                                radius: 35,
                                backgroundColor: bgDarkColor,
                                child: Transform.scale(
                                  scale: 2.5,
                                  child: IconButton(
                                      onPressed: () {
                                        if (controller.isPlaying.value) {
                                          controller.audioPlayer.pause();
                                          controller.isPlaying(false);
                                        } else {
                                          controller.audioPlayer.play();
                                          controller.isPlaying(true);
                                        }
                                      },
                                      icon: controller.isPlaying.value
                                          ? const Icon(
                                              Icons.pause,
                                              color: whiteColor,
                                            )
                                          : const Icon(
                                              Icons.play_arrow_rounded,
                                              color: whiteColor,
                                            )),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (controller.playIndex.value + 1 ==
                                      data.length) {
                                    controller.playSong(data[0].uri, 0);
                                  } else {
                                    controller.playSong(
                                        data[controller.playIndex.value + 1]
                                            .uri,
                                        controller.playIndex.value + 1);
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  size: 40,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
