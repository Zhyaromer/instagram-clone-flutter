import 'package:flutter/material.dart';
import 'package:instagram/model/posts.dart';
import 'package:instagram/model/stories.dart';

final List<Color> instagramGradient = [
  Color(0xFFFEDA75), // yellow
  Color(0xFFFA7E1E), // orange
  Color(0xFFD62976), // pink
  Color(0xFF962FBF), // purple
  Color(0xFF4F5BD5), // blue
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_field
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
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
                                        return Scaffold(
                                          body: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.of(context).size.height * 0.9,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(story.storieUrl),
                                                        fit: BoxFit.cover,
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
                                                        borderRadius: BorderRadiusGeometry.circular(8),
                                                        child: LinearProgressIndicator(
                                                          value: 0.1,
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
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(story.storieUrl),
                                                            ),

                                                            const SizedBox(width: 10),

                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      story.username,
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),

                                                                    const SizedBox(width: 6),

                                                                    if (story.isVerified) ...[
                                                                      Container(
                                                                        padding: EdgeInsets.all(2),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: Icon(
                                                                          Icons.check,
                                                                          size: 6,
                                                                          color: Colors.black,
                                                                          weight: 10,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 10),
                                                                    ],

                                                                    Text(
                                                                      story.date,
                                                                      style: TextStyle(
                                                                        color: Colors.white.withOpacity(0.7),
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w500,
                                                                        letterSpacing: 0.2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                if (story.song != '') ...[
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.music_note, size: 14),
                                                                      Text(
                                                                        story.song,
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

                                                            Icon(Icons.close, size: 35, color: Colors.white),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: instagramGradient,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
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
                return Container(
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
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],

                                const SizedBox(width: 12),

                                Icon(Icons.more_horiz, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: post.images.length,
                          itemBuilder: (context, index) {
                            final e = post.images[index];
                            return Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    image: DecorationImage(image: NetworkImage(e.UrlImage), fit: BoxFit.cover),
                                  ),
                                ),

                                if (images.length > 1) ...[
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text('${index + 1}/${images.length}', style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                postActions(
                                  Icon(Icons.favorite_border),
                                  Icon(Icons.favorite),
                                  post.likes,
                                  post.isLiked,
                                ),
                                const SizedBox(width: 12),
                                postActions(Icon(Icons.comment), null, post.comments, false),
                                const SizedBox(width: 12),
                                postActions(Icon(Icons.repeat), Icon(Icons.repeat_one), post.reposts, post.isReposted),
                                const SizedBox(width: 12),
                                postActions(Icon(Icons.send), null, post.share, false),
                              ],
                            ),

                            Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_outline),
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
  return Row(children: [?state ? newIcon : icon, const SizedBox(width: 6), Text(number.toString())]);
}

class ExpandableCaption extends StatefulWidget {
  final String username;
  final String caption;

  const ExpandableCaption({super.key, required this.username, required this.caption});

  @override
  State<ExpandableCaption> createState() => _ExpandableCaptionState();
}

class _ExpandableCaptionState extends State<ExpandableCaption> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: [
            TextSpan(
              text: '${widget.username} ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
            ),
            TextSpan(
              text: widget.caption.length > 50
                  ? isExpanded
                        ? widget.caption
                        : widget.caption.substring(0, 50)
                  : widget.caption,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            if (!isExpanded && widget.caption.length > 50)
              TextSpan(
                text: ' ... more',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
