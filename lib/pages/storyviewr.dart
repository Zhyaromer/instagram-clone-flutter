import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram/model/stories.dart';

class Storyviewer extends StatefulWidget {
  const Storyviewer({super.key, required this.story, required this.index});

  final List<Stories> story;
  final int index;

  @override
  State<Storyviewer> createState() => _StoryviewerState();
}

class _StoryviewerState extends State<Storyviewer> {
  late PageController _pageController;
  int currentIndex = 0;
  double progress = 0.0;
  Timer? _timer;
  final int storyDuration = 10;
  late DateTime _startTime;

  void nextScreen() {
    if (currentIndex < widget.story.length - 1) {
      currentIndex++;
      _timer?.cancel();
      progress = 0.0;
      updateStatus();
      startProgress();
      _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void prevScreen() {
    if (currentIndex > 0) {
      currentIndex--;
      _timer?.cancel();
      progress = 0.0;
      startProgress();
      updateStatus();
      _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void startProgress() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final elapsed = DateTime.now().difference(_startTime).inMilliseconds;
      setState(() {
        progress = elapsed / (storyDuration * 1000);

        if (progress >= 1.0) {
          _timer?.cancel();
          nextScreen();
          progress = 0.0;
          startProgress();
        }
      });
    });
  }

  void updateStatus() {
    setState(() {
      widget.story[currentIndex].isWatched = false;
    });
  }

  void updateProgress() {
    setState(() {
      progress = progress + 0.01;

      if (progress >= 1.0) {
        _timer?.cancel();
        nextScreen();
        progress = 0.0;
        startProgress();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    startProgress();
    updateStatus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.story.length,
          itemBuilder: (context, index) {
            final storyView = widget.story[index];
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTapDown: (details) {
                          final width = MediaQuery.of(context).size.width;
                          if (details.globalPosition.dx < width / 2) {
                            prevScreen();
                          } else {
                            nextScreen();
                          }
                        },
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy > 10) {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.9,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(storyView.storieUrl), fit: BoxFit.cover),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 3,
                          width: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(color: Colors.grey[400]),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white24,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 20,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(backgroundImage: NetworkImage(storyView.storieUrl)),

                                const SizedBox(width: 10),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          storyView.username,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(width: 6),

                                        if (storyView.isVerified) ...[
                                          Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                            child: Icon(Icons.check, size: 6, color: Colors.black, weight: 10),
                                          ),
                                          const SizedBox(width: 10),
                                        ],

                                        Text(
                                          storyView.date,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                    if (storyView.song != '') ...[
                                      Row(
                                        children: [
                                          Icon(Icons.music_note, size: 14),
                                          Text(
                                            storyView.song,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),

                                          Icon(Icons.keyboard_arrow_right, size: 17),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(Icons.more_horiz, size: 25, color: Colors.white),

                                const SizedBox(width: 13),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close, size: 35, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Send Message...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),
                      StoryItem(story: storyView),
                      const SizedBox(width: 10),
                      const Icon(Icons.share, size: 30, color: Colors.white),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class StoryItem extends StatefulWidget {
  final Stories story;
  const StoryItem({super.key, required this.story});

  @override
  State<StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        size: 30,
        widget.story.isStoryLiked ? Icons.favorite : Icons.favorite_border,
        color: widget.story.isStoryLiked ? Colors.red : Colors.white,
      ),
      onPressed: () {
        setState(() {
          widget.story.isStoryLiked = !widget.story.isStoryLiked;
        });
      },
    );
  }
}
