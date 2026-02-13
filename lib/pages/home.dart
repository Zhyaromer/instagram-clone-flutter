import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/comments.dart';
import 'package:instagram/model/imageposts.dart';
import 'package:instagram/model/posts.dart';
import 'package:instagram/model/stories.dart';
import 'package:instagram/pages/storyviewr.dart';
import 'package:instagram/ui/ExpandableCaption.dart';

final List<Color> instagramGradient = [
  Color(0xFFFEDA75),
  Color(0xFFFA7E1E),
  Color(0xFFD62976),
  Color(0xFF962FBF),
  Color(0xFF4F5BD5),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double sheetHeight = 0.7;
  final minHeight = 0.4;
  final maxHeight = 0.95;

  void openComments(String postid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            void close() => Navigator.of(context).pop();

            return GestureDetector(
              behavior: HitTestBehavior.translucent,

              onVerticalDragUpdate: (details) {
                sheetHeight -= details.delta.dy / MediaQuery.of(context).size.height;

                sheetHeight = sheetHeight.clamp(minHeight, maxHeight);
                setState(() {});
              },

              onVerticalDragEnd: (details) {
                final velocity = details.primaryVelocity ?? 0;

                if (velocity > 900) {
                  close();
                  return;
                }

                if (sheetHeight <= minHeight + 0.05) {
                  close();
                  return;
                }

                if (sheetHeight < 0.65) {
                  sheetHeight = 0.6;
                } else {
                  sheetHeight = 0.9;
                }

                setState(() {});
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  height: MediaQuery.of(context).size.height * sheetHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      Container(
                        width: 42,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        child: Text(
                          'Comments',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: filterCommentsByPostId(postid).length,
                          itemBuilder: (_, i) {
                            final comment = filterCommentsByPostId(postid)[i];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(backgroundImage: NetworkImage(comment.imageUrl)),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              comment.username,
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),

                                            const SizedBox(width: 2),

                                            if (comment.isVerified) ...[
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                                child: Icon(Icons.check, size: 6, color: Colors.black, weight: 10),
                                              ),
                                              const SizedBox(width: 2),
                                            ],

                                            Text(
                                              comment.date,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.7),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 4),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    comment.content,
                                                    style: TextStyle(
                                                      color: Colors.white.withOpacity(0.9),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),

                                                  const SizedBox(height: 8),

                                                  Text(
                                                    'Reply',
                                                    style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: 0.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 10),

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      comment.toggleLike();
                                                    });
                                                  },
                                                  child: Icon(
                                                    comment.isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                                    size: 20,
                                                    color: comment.isLiked ? Colors.red : Colors.white,
                                                  ),
                                                ),
                                                if (comment.likes > 0) ...[
                                                  Opacity(
                                                    opacity: 0.7,
                                                    child: Text(
                                                      comment.likes.toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    storyData.sort((a, b) => (a.isWatched ? 1 : 0) - (b.isWatched ? 1 : 0));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text(
          'Instagram',
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Icon(Icons.add, size: 28, color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.favorite_border, size: 25, color: Colors.white),
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 115,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: storyData.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage('https://picsum.photos/200'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                      child: Icon(Icons.add, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Your Story',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final story = storyData[index - 1];
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Storyviewer(story: storyData, index: (index - 1));
                                      },
                                    ),
                                  );
                                },

                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: !story.isWatched
                                        ? SweepGradient(
                                            colors: [...instagramGradient, instagramGradient.first],
                                            startAngle: 0.0,
                                            endAngle: 6.28319,
                                            transform: const GradientRotation(-0.8),
                                          )
                                        : null,
                                    color: story.isWatched ? Colors.grey[600] : Colors.orange,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage(story.imageUrl), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                story.username.length > 15 ? "${story.username.substring(0, 12)}..." : story.username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: mockPosts.length,
              itemBuilder: (context, index) {
                final post = mockPosts[index];
                final images = post.images;
                return SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    image: DecorationImage(image: NetworkImage(post.pageCover), fit: BoxFit.cover),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                if (post.music.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        post.music,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ] else
                                  Text(
                                    post.username,
                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                              ],
                            ),

                            Row(
                              children: [
                                if (!post.isFollowed) ...[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        post.isFollowed = !post.isFollowed;
                                      });
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(SnackBar(content: Text('${post.username} followed')));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                const SizedBox(width: 12),

                                Icon(Icons.more_vert, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      PostImages(images: images),

                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (post.isLiked) {
                                        post.likes = post.likes - 1;
                                      } else {
                                        post.likes = post.likes + 1;
                                      }
                                      post.isLiked = !post.isLiked;
                                    });
                                  },
                                  child: postActions(
                                    Icon(CupertinoIcons.heart),
                                    Icon(CupertinoIcons.heart_fill, color: Colors.red),
                                    post.likes,
                                    post.isLiked,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    openComments(post.id);
                                  },
                                  child: postActions(Icon(CupertinoIcons.chat_bubble), null, post.comments, false),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (post.isReposted) {
                                        post.reposts = post.reposts - 1;
                                      } else {
                                        post.reposts = post.reposts + 1;
                                      }
                                      post.isReposted = !post.isReposted;
                                    });
                                  },
                                  child: postActions(
                                    Icon(CupertinoIcons.arrow_2_squarepath),
                                    Icon(CupertinoIcons.arrow_2_circlepath_circle_fill),
                                    post.reposts,
                                    post.isReposted,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                postActions(Icon(CupertinoIcons.paperplane), null, post.share, false),
                              ],
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  post.isSaved = !post.isSaved;
                                });
                              },
                              child: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_outline),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ExpandableCaption(username: post.username, caption: post.caption),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            post.timeAgo,
                            style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget postActions(Icon icon, Icon? newIcon, int number, bool state) {
  return Row(
    children: [
      ?state ? newIcon : icon,
      const SizedBox(width: 4),
      Text(
        number.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

class PostImages extends StatefulWidget {
  final List<Imageposts> images;
  const PostImages({super.key, required this.images});

  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(widget.images[index].UrlImage, fit: BoxFit.cover);
                },
              ),

              if (widget.images.length > 1)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    width: 45,
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '${currentIndex + 1}/${widget.images.length}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        if (widget.images.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  height: 6,
                  width: (currentIndex == index) ? 20 : 8,
                  decoration: BoxDecoration(
                    color: index == currentIndex ? Colors.white : Colors.grey[700],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
