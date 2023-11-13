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
  final ScrollController scrollController;
  final bool allStoryUploaded;

  const StoryListView({
    Key? key,
    required this.buttonDatas,
    this.buttonSpacing = 14,
    this.paddingLeft = 16.0,
    this.listHeight = 126.0,
    this.paddingRight = 16.0,
    this.paddingTop = 0,
    this.paddingBottom = 16.0,
    this.physics,
    this.pageTransform,
    this.buttonWidth = 70.0,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    required this.scrollController,
    this.allStoryUploaded = true,
  }) : super(key: key);

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   widget.scrollController.addListener(() {
    //     if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent && widget.allStoryUploaded) {
    //       setState(() {});
    //       print('state updated');
    //     }
    //   });
    // });
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
          storyListScrollController: widget.scrollController,
        ),
        duration: buttonData.pageAnimationDuration,
      ),
    );
  }

  @override
  void dispose() {
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
          controller: widget.scrollController,
          physics: widget.physics,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, int index) {
            final isLast = index == buttonDatas.length - 1;
            final isFirst = index == 0;
            if (index < buttonDatas.length) {
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
                    storyListViewController: widget.scrollController,
                    onPressed: _onButtonPressed,
                  ),
                ),
              );
            } else {
              return widget.allStoryUploaded
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SizedBox();
            }
          },
          itemCount: buttonDatas.length + 1,
        ),
      ),
    );
  }
}
