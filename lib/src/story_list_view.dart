import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

class StoryListView extends StatefulWidget {
  final List<StoryButtonData> buttonDatas;
  final double buttonSpacing;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final ScrollPhysics? physics;
  final IStoryPageTransform? pageTransform;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final double listHeight;
  final double buttonWidth;

  const StoryListView({
    Key? key,
    required this.buttonDatas,
    this.buttonSpacing = 14,
    this.paddingLeft = 16.0,
    this.listHeight = 126.0,
    this.paddingRight = 16.0,
    this.paddingTop = 16.0,
    this.paddingBottom = 16.0,
    this.physics,
    this.pageTransform,
    this.buttonWidth = 70.0,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
  }) : super(key: key);

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _onButtonPressed(StoryButtonData buttonData) {
    Navigator.of(context).push(
      StoryRoute(
        storyContainerSettings: StoryContainerSettings(
          buttonData: buttonData,
          tapPosition: buttonData.buttonCenterPosition!,
          curve: buttonData.pageAnimationCurve,
          allButtonDatas: widget.buttonDatas,
          pageTransform: widget.pageTransform,
          storyListScrollController: _scrollController,
        ),
        duration: buttonData.pageAnimationDuration,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonDatas = widget.buttonDatas.where((b) {
      return b.isVisibleCallback();
    }).toList();
    if (buttonDatas.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: widget.listHeight,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.paddingTop,
          bottom: widget.paddingBottom,
        ),
        child: ListView.builder(
          controller: _scrollController,
          physics: widget.physics,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, int index) {
            final isLast = index == buttonDatas.length - 1;
            final isFirst = index == 0;
            final buttonData = buttonDatas[index];
            return Padding(
              padding: EdgeInsets.only(
                left: isFirst ? widget.paddingLeft : 0.0,
                right: isLast ? widget.paddingRight : widget.buttonSpacing,
              ),
              child: SizedBox(
                width: widget.buttonWidth,
                child: StoryButton(
                  buttonData: buttonData,
                  allButtonDatas: buttonDatas,
                  pageTransform: widget.pageTransform,
                  storyListViewController: _scrollController,
                  onPressed: _onButtonPressed,
                ),
              ),
            );
          },
          itemCount: buttonDatas.length,
        ),
      ),
    );
  }
}
