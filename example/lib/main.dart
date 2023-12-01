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
  List<StoryButtonData> storyButtonDataList = [];

  List<String> storyList = [
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  final List<String> segmentList = [
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/214574/pexels-photo-214574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  @override
  void initState() {
    super.initState();

    storyTimelineController.addAll(List.filled(storyList.length, StoryTimelineController()));
    _generateStoryButtonDataList();
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
            buttonDatas: [...storyButtonDataList],
          ),
        ],
      ),
    );
  }

  _generateStoryButtonDataList() {
    final durationList = List.generate(storyList.length, (index) => Duration(milliseconds: 10000));

    for (int i = 0; i < storyList.length; i++) {
      storyButtonDataList.add(
        StoryButtonData(
          storyController: storyTimelineController[i],
          allStoryWatched: i > 0,
          currentSegmentIndex: 0,
          backgroundImage: segmentList,
          isWatched: (int storyIndex) => print('segment index $storyIndex'),
          buttonDecoration: _buildButtonDecoration(storyList[0]),
          child: _buildButtonChild('user $i'),
          storyPages: [...segmentList.map((e) => _createDummyPage(text: '$i Want to buy a new car? Get our loan for the rest of your life!'))],
          bottomBar: [...segmentList.map((e) => _buildMessageBar(activeIndex: i))],
          topBar: [
            ...segmentList.map(
              (e) => Stack(
                children: [
                  Positioned(
                    right: 60,
                    top: 36,
                    child: InkWell(
                      onTap: () {
                        final currentIndex = storyTimelineController[0].currentIndex();
                        storyTimelineController[currentIndex].deleteStory();
                        storyTimelineController.removeAt(currentIndex);
                        storyList.removeAt(currentIndex);
                        storyButtonDataList.removeAt(currentIndex);
                        print(currentIndex);
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.red,
                        child: Text('User Remove'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
          segmentDuration: durationList,
        ),
      );
    }

    // return List.generate(storyList.length, (index) {
    //   final durationList = List.generate(storyList.length, (index) => Duration(milliseconds: 10000));

    //   return StoryButtonData(
    //     storyController: storyTimelineController[index],
    //     allStoryWatched: index > 0,
    //     currentSegmentIndex: 0,
    //     backgroundImage: segmentList,
    //     isWatched: (int storyIndex) => print(storyIndex),
    //     buttonDecoration: _buildButtonDecoration(storyList[0]),
    //     child: _buildButtonChild('user $index'),
    //     storyPages: [...segmentList.map((e) => _createDummyPage(text: '$index Want to buy a new car? Get our loan for the rest of your life!'))],
    //     bottomBar: [...segmentList.map((e) => _buildMessageBar(activeIndex: index))],
    //     topBar: [
    //       ...segmentList.map(
    //         (e) => Stack(
    //           children: [
    //             Positioned(
    //               right: 60,
    //               top: 36,
    //               child: InkWell(
    //                 onTap: () {
    //                   storyTimelineController[index].deleteStory(index);
    //                   storyTimelineController.removeAt(index);
    //                   storyList.removeAt(index);
    //                 },
    //                 child: Container(
    //                   color: Colors.red,
    //                   child: Text('User Remove'),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //     segmentDuration: durationList,
    //   );
    // });

    return storyButtonDataList;
  }

  Widget _createDummyPage({
    required String text,
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
                  storyTimelineController[activeIndex].deleteSegment(context, segmentList.length);
                  segmentList.removeAt(activeIndex);

                  if ((segmentList.length - 1) == 0) {
                    final currentIndex = storyTimelineController[0].currentIndex();
                    storyTimelineController[currentIndex].deleteStory();
                    storyTimelineController.removeAt(currentIndex);
                    storyList.removeAt(currentIndex);
                    storyButtonDataList.removeAt(currentIndex);
                  }
                  setState(() {});
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
