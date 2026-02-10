import 'package:flutter/material.dart';
import 'package:instagram/model/stories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text(
          'Instagram',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final story = storyData[index];
                    return Container(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(
                                color: Colors.orange,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                  image: NetworkImage(story.imageUrl),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {
                                    Container(color: Colors.red);
                                  },
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            story.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: storyData.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
