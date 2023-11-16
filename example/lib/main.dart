import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
  final _scrollController = ScrollController();
  final List<Duration> durations = [
    Duration(milliseconds: 5000),
    Duration(milliseconds: 10000),
    Duration(milliseconds: 5000),
    Duration(milliseconds: 3000),
    Duration(milliseconds: 10000),
  ];

  final List<String> storyBackgroundList = [
    'https://images.unsplash.com/photo-1622454742405-3a1be7a7b330?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1697724111104-7305ea739f8f?q=80&w=3167&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1690646885008-5cd2f5f0c3ea?q=80&w=3164&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1685308887863-b9eaac852cc0?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1680836660226-95e12183f858?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  Widget _createDummyPage({
    required String text,
    required String imageName,
  }) {
    return Stack(
      children: [
        Positioned(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ],
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

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(_borderRadius),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1,
        ),
      ),
    );
  }

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
            scrollController: _scrollController,
            listHeight: 96,
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
            buttonDatas: [
              StoryButtonData(
                // allStoryWatched: true,
                // currentSegmentIndex: 2,
                backgroundImage: storyBackgroundList,
                isWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration(storyBackgroundList[0]),
                child: _buildButtonChild('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[0],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[1],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[2],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[3],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[4],
                  ),
                ],
                segmentDuration: durations,
              ),
              StoryButtonData(
                // allStoryWatched: true,
                // currentSegmentIndex: 2,
                backgroundImage: storyBackgroundList,
                isWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration(storyBackgroundList[0]),
                child: _buildButtonChild('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[1],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[2],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[3],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[4],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[0],
                  ),
                ],
                segmentDuration: durations,
              ),
              StoryButtonData(
                // allStoryWatched: true,
                // currentSegmentIndex: 2,
                backgroundImage: storyBackgroundList,
                isWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration(storyBackgroundList[0]),
                child: _buildButtonChild('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[0],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[1],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[2],
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: storyBackgroundList[3],
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: storyBackgroundList[4],
                  ),
                ],
                segmentDuration: durations,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
