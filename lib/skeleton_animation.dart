///
/// author: Wouter van der wal <wouter.wal@outlook.com>
/// github: https://github.com/wjtje
///

library skeleton_animation;

import 'package:flutter/material.dart';

/// Different animations for the skeleton object
///
/// Default is the pulse animation
enum SkeletonAnimation {
  /// Static color
  none,

  /// Simple fadeing animation
  pulse
}

/// Different styles of the skeleton
enum SkeletonStyle {
  /// A simple box
  box,

  /// A simple circle
  circle,

  /// A box with rounded corners
  text
}

/// Creates a simple skeleton animation
///
/// The default colors works great in light mode but you need to changes them for dark mode.
///
/// If you want it to look like text you can use [width] of 200,
/// a [height] of 12 and a [radius] of Radius.circular(6)
class Skeleton extends StatefulWidget {
  /// The text color
  final Color textColor;

  /// The background color of the parrent
  ///
  /// If this is empty the skeleton will use the default white (or dark) background.
  /// But if you are using a diffent color background please set this to the correct colour to make sure the animation is displaying currently.

  final Color parentBackgroundColor;

  /// The width of the skeleton
  final double width;

  /// The height of the skeleton
  ///
  /// Height is ignored if the [style] is SkeletonStyle.circle
  final double height;

  /// Choose your style of animaion.
  /// The default is SkeletonAnimation.pulse
  final SkeletonAnimation animation;

  /// Choose your look of the skeleton
  /// The default is SkeletonStyle.box
  final SkeletonStyle style;

  Skeleton(
      {
      // Use default colors
      this.textColor,
      this.parentBackgroundColor,
      // Use default size
      this.width = 200.0,
      this.height = 60.0,
      // Use the default animation
      this.animation = SkeletonAnimation.pulse,
      // Use the default style
      this.style = SkeletonStyle.box});

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Create the correct animation
    if (widget.animation == SkeletonAnimation.pulse) {
      // Create the pulse animation
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 750),
        reverseDuration: Duration(milliseconds: 750),
        lowerBound: .4,
        upperBound: 1,
      )..addStatusListener((AnimationStatus status) {
          // Create a loop
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        });

      // Start the animation
      _controller.forward();
    } else {
      // Create a dummy animation
      _controller = AnimationController(
        vsync: this,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the correct text color and calculate the correct opcity
    Color _themeTextColor = Theme.of(context).textTheme.bodyText1.color;
    double _themeOpacity =
        Theme.of(context).brightness == Brightness.light ? 0.11 : 0.13;
    Color _parrentBackground = widget.parentBackgroundColor ??
        Theme.of(context).scaffoldBackgroundColor;
    // Generate the correct color
    Color _baseColor = Color.alphaBlend(
        // Use the correct color
        widget.textColor ?? _themeTextColor.withOpacity(_themeOpacity),
        _parrentBackground);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        // Get the correct with and height
        width: widget.width,
        height: (widget.style == SkeletonStyle.circle)
            ? widget.width
            : widget.height,
        decoration: BoxDecoration(
          // Choose the correct border radius
          // box: none
          // text: 4
          // circle: widget.width / 2
          borderRadius: (widget.style == SkeletonStyle.box)
              ? BorderRadius.zero
              : (widget.style == SkeletonStyle.text)
                  ? BorderRadius.all(Radius.circular(4))
                  : BorderRadius.all(Radius.circular(widget.width / 2)),
          // Load the correct animation
          color: (widget.animation == SkeletonAnimation.pulse)
              ? _baseColor.withOpacity(_controller.value) // Pulse
              : _baseColor, // None
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
