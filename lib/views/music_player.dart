import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:playhits/consts/colors.dart';
import 'package:playhits/controller/player_controller.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({
    super.key,
  });

  final PlayerController controller = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
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
              width: screenWidth(context),
              height: screenHeight(context),
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
                                width: screenWidth(context) * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth(context) * 0.75,
                                      height: 50,
                                      child: Marquee(
                                        text: controller
                                            .songList[
                                                controller.playIndex.value]
                                            .displayNameWOExt,
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        scrollAxis: Axis.horizontal,
                                        blankSpace: 20.0,
                                        velocity: 50.0,
                                        startPadding: 10.0,
                                        accelerationDuration:
                                            const Duration(seconds: 1),
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration:
                                            const Duration(milliseconds: 500),
                                        decelerationCurve: Curves.easeOut,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller
                                          .songList[controller.playIndex.value]
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
                                onPressed: () {
                                  controller.shufflePlaylist();
                                },
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
                              min: 0,
                              max: controller.max.value,
                              value: controller.value.value,
                              onChanged: (newValue) {
                                controller
                                    .changeDurationToSeconds(newValue.toInt());
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
                                  controller.skipToPrevious();
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
                                          controller.pauseSong();
                                        } else {
                                          controller.resumeSong();
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
                                  controller.skipToNext();
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
