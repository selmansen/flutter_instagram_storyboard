import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const StoryExamplePage(),
    );
  }
}

class StoryExamplePage extends StatefulWidget {
  const StoryExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StoryExamplePage> createState() => _StoryExamplePageState();
}

class _StoryExamplePageState extends State<StoryExamplePage> {
  static const double _borderRadius = 57.0;
  static const double _childHeight = 57.0;
  static const double _bottomSafeHeight = 90;
  final _scrollController = ScrollController();
  List<StoryTimelineController> storyTimelineController = [];
  List<Duration> durations = [];

  final List<String> storyBackgroundList = [
    'https://images.unsplash.com/photo-1622454742405-3a1be7a7b330?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1697724111104-7305ea739f8f?q=80&w=3167&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1690646885008-5cd2f5f0c3ea?q=80&w=3164&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1685308887863-b9eaac852cc0?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1680836660226-95e12183f858?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Story Example'),
      ),
      body: Column(
        children: [
          StoryListView(
            allStoryUploaded: false, // lazyload
            bottomSafeHeight: _bottomSafeHeight,
            scrollController: _scrollController,
            listHeight: 100,
            paddingTop: 16,
            pageTransform: const StoryPage3DTransform(),
            newStoryOnTap: () => print('new story'),
            newStoryTitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 13,
                  height: 1,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            buttonDatas: [..._generateStoryButtonDataList(storyBackgroundList.length)],
          ),
        ],
      ),
    );
  }

  List<StoryButtonData> _generateStoryButtonDataList(int n) {
    List<StoryButtonData> storyButtonDataList = [];

    for (int i = 0; i < n; i++) {
      storyTimelineController.add(StoryTimelineController());
      durations.add(Duration(milliseconds: 5000));
      storyButtonDataList.add(
        StoryButtonData(
          storyController: storyTimelineController[i],
          allStoryWatched: i > 0,
          currentSegmentIndex: 0,
          backgroundImage: storyBackgroundList,
          isWatched: (int storyIndex) => print(storyIndex),
          buttonDecoration: _buildButtonDecoration(storyBackgroundList[0]),
          child: _buildButtonChild('user $i'),
          storyPages: [
            ...storyBackgroundList.map((e) => _createDummyPage(
                  text: 'Want to buy a new car? Get our loan for the rest of your life!',
                  imageName: storyBackgroundList[i],
                )),
          ],
          bottomBar: [...storyBackgroundList.map((e) => _buildMessageBar(activeIndex: i))],
          segmentDuration: durations,
        ),
      );
    }

    return storyButtonDataList;
  }

  Widget _createDummyPage({
    required String text,
    required String imageName,
  }) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Text(text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBar({required int activeIndex}) {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    focusNode.addListener(() async {
      if (focusNode.hasFocus) {
        storyTimelineController[activeIndex].keyboardOpened();
      } else {
        storyTimelineController[activeIndex].keyboardClosed();
      }
    });

    return Container(
      height: _bottomSafeHeight,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      focusNode: focusNode,
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Text('Send', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  storyTimelineController[activeIndex].pause();
                },
                child: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  storyBackgroundList.removeAt(0);
                  storyTimelineController[activeIndex].deleteSegment(context);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonChild(String? text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: _childHeight,
          ),
          if (text != null)
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  BoxDecoration _buildButtonDecoration(String imageName) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadius),
      image: DecorationImage(
        image: NetworkImage(
          imageName,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
