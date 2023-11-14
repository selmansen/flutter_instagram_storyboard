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

  Widget _createDummyPage({
    required String text,
    required String imageName,
    bool addBottomBar = true,
  }) {
    return StoryPageScaffold(
      bottomNavigationBar: addBottomBar
          ? SizedBox(
              width: double.infinity,
              height: kBottomNavigationBarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            _borderRadius,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imageName,
            ),
            fit: BoxFit.cover,
          ),
        ),
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
                allStoryWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration('https://wallpapercave.com/wp/wp4848993.jpg'),
                child: _buildButtonChild('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                ],
                segmentDuration: const Duration(seconds: 10),
              ),
              StoryButtonData(
                allStoryWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.blue,
                buttonDecoration: _buildButtonDecoration('https://wallpapercave.com/wp/wp4848993.jpg'),
                borderDecoration: _buildBorderDecoration(const Color.fromARGB(255, 134, 119, 95)),
                child: _buildButtonChild('Travel whereever'),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                    addBottomBar: false,
                  ),
                ],
                segmentDuration: const Duration(seconds: 10),
              ),
              StoryButtonData(
                allStoryWatched: (int storyIndex) => print(storyIndex),
                timelineBackgroundColor: Colors.orange,
                borderDecoration: _buildBorderDecoration(Colors.orange),
                buttonDecoration: _buildButtonDecoration('https://wallpapercave.com/wp/wp4848993.jpg'),
                child: _buildButtonChild('Buy a house anywhere'),
                storyPages: [
                  _createDummyPage(
                    text: 'You cannot buy a house. Live with it',
                    imageName: 'https://wallpapercave.com/wp/wp4848993.jpg',
                  ),
                ],
                segmentDuration: const Duration(seconds: 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
