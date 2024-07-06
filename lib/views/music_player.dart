import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:playhits/controller/player_controller.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key, required this.data});
  final List<SongModel> data;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    var controller = Get.find<PlayerController>();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/headset.jpg",
              ),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            // width: screenWidth,
            // height: screenheight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                  const Color(0xFF31314F).withOpacity(1),
                  const Color(0xFF31314F).withOpacity(1)
                ])),
            child: Container(
              width: screenWidth,
              height: screenheight,
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 45, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(CupertinoIcons.back,
                            color: Colors.white, size: 30),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.more_vert,
                            color: Colors.white, size: 30),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 23, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Container(
                                width: screenWidth * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[controller.playIndex.value]
                                          .displayNameWOExt,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data[controller.playIndex.value]
                                          .artist
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                  size: 35,
                                ))
                          ],
                        ),
                      ),
                      Obx(
                        () => Column(
                          children: [
                            Slider(
                              min: 0 // const Duration(seconds: 0)
                              //     .inSeconds
                              //     .toDouble()
                              ,
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller
                                    .changeDurationToSeconds(newValue.toInt());
                                // newValue = newValue;
                              },
                              activeColor: Colors.white,
                              inactiveColor: Colors.white54,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.position.value,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    controller.duration.value,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (controller.playIndex.value == 0) {
                                    controller.playSong(
                                        data[data.length - 1].uri,
                                        data.length - 1);
                                  } else {
                                    controller.playSong(
                                        data[controller.playIndex.value - 1]
                                            .uri,
                                        controller.playIndex.value - 1);
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.backward_end_fill,
                                  color: Colors.white,
                                  size: 32,
                                )),
                            Obx(
                              () => CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
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
                                              color: Color(
                                                0xFF31314f,
                                              ),
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.play_arrow_rounded,
                                              color: Color(
                                                0xFF31314f,
                                              ),
                                              size: 20,
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
                                  CupertinoIcons.forward_end_fill,
                                  color: Colors.white,
                                  size: 32,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
