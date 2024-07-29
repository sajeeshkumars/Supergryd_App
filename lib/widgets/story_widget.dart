import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mynewpackage/model/super_gryd_story.dart';
import 'package:story/story.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_text.dart';

class StoryWidget extends StatelessWidget {
  final List<SuperGrydStory> storyData;
  const StoryWidget({super.key, required this.storyData});

  @override
  Widget build(BuildContext context) {
    if ((storyData.length) > 0) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: storyData.length,
          itemBuilder: (context, index) {
            return CircleDottedStoryWidget(stories: storyData, index: index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 20,
            );
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

class CircleDottedStoryWidget extends StatelessWidget {
  final double dimension;
  final int index;
  final List<SuperGrydStory> stories;
  const CircleDottedStoryWidget(
      {super.key,
      required this.stories,
      this.dimension = 150,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.square(
                dimension: dimension,
                child: CustomPaint(
                  painter: DottedBorder(
                    numberOfStories: stories[index].storyData!.length,
                    spaceLength: 10,
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: dimension - 20,
                width: dimension - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: InkWell(
                    onTap: () {
                      showStory(context, index: index, list: stories);
                    },
                    child: Image.network(stories[index].thumbUrl!)),
              ),
            ],
          ),
          if (stories[index].title != null)
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                CommonText(
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: stories[index].title!,
                ),
              ],
            ),
        ],
      ),
    );
  }

  void showStory(BuildContext context,
      {required int index, required List<SuperGrydStory> list}) {
    log("index is ${index}");
    if (index > 0) {
      list.removeRange(0, index);
    }
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: StoryPageView(
                backgroundColor: Colors.black,
                gestureItemBuilder: (context, pageInd, storyIndex) {
                  final storyUrl = list[pageInd].storyData![storyIndex];
                  if (storyUrl.url != null) {
                    return Center(
                      child: Container(
                        width: size.width - 120,
                        height: size.height,
                        child: InkWell(
                          onTap: () async {
                            final uri = Uri.parse(storyUrl.url ?? "");
                            final canLaunch = await canLaunchUrl(uri);
                            if (canLaunch) {
                              Navigator.pop(context);
                              await launchUrl(uri);
                            }
                          },
                          child: SizedBox(
                            width: size.width - 30,
                            height: size.height,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
                onPageLimitReached: () {
                  Navigator.pop(context);
                },
                itemBuilder: (context, pageIndex, storyIndex) {
                  final storyUrl = list[pageIndex].storyData![storyIndex];
                  return Stack(
                    alignment: storyUrl.imageUrl == null
                        ? Alignment.center
                        : AlignmentDirectional.topStart,
                    children: [
                      Positioned.fill(
                        child: Container(color: Colors.black),
                      ),
                      if (storyUrl.imageUrl != null)
                        Positioned.fill(
                          child: StoryImage(
                              key: ValueKey(storyUrl.imageUrl!),
                              imageProvider: NetworkImage(storyUrl.imageUrl!)),
                        ),
                      if (storyUrl.title != null)
                        Positioned(
                          bottom: storyUrl.imageUrl != null ? 12 : null,
                          width: size.width,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      storyUrl.title!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                storyLength: (int pageIndex) {
                  return list[pageIndex].storyData!.length;
                },
                pageLength: list.length,
              ),
            ),
          );
        });
  }
}

class DottedBorder extends CustomPainter {
  final Color seenColor;
  final Color unSeenColor;
  //number of stories
  final int numberOfStories;
  //length of the space arc (empty one)
  final int spaceLength;
  //start of the arc painting in degree(0-360)
  double startOfArcInDegree = 0;

  DottedBorder({
    required this.numberOfStories,
    this.spaceLength = 10,
    this.seenColor = Colors.green,
    this.unSeenColor = Colors.teal,
  });

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree) {
    return (degree * math.pi) / 180;
  }

  @override
  bool shouldRepaint(DottedBorder oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //circle angle is 360, remove all space arcs between the main story arc (the number of spaces(stories) times the  space length
    //then subtract the number from 360 to get ALL arcs length
    //then divide the ALL arcs length by number of Arc (number of stories) to get the exact length of one arc
    double arcLength =
        (360 - (numberOfStories * spaceLength)) / numberOfStories;

    //be careful here when arc is a negative number
    //that happens when the number of spaces is more than 360
    //feel free to use what logic you want to take care of that
    //note that numberOfStories should be limited too here
    if (arcLength <= 0) {
      arcLength = 360 / spaceLength - 1;
    }

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    //looping for number of stories to draw every story arc
    for (int i = 0; i < numberOfStories; i++) {
      //printing the arc
      canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(arcLength),
          false,
          Paint()
            //here you can compare your SEEN story index with the arc index to make it grey
            ..color = i == 0 || i == 1 ? seenColor : unSeenColor
            ..strokeWidth = 5.0
            ..style = PaintingStyle.stroke);

      //the logic of spaces between the arcs is to start the next arc after jumping the length of space
      startOfArcInDegree += arcLength + spaceLength;
    }
  }
}
