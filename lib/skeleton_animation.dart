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
  pulse,
  /// Wave animation (Work in progress)
  wave
}

/// Creates a simple skeleton animation
///
/// The default colors works great in light mode but you need to changes them for dark mode.
///
/// If you want it to look like text you can use [width] of 200,
/// a [height] of 12 and a [radius] of Radius.circular(6)
class Skeleton extends StatefulWidget {
  /// The background color for the skeleton
  final Color baseColor;

  /// The hightlight color for the skeleton
  final Color hightlightColor;

  /// The width of the skeleton
  final double width;

  /// The height of the skeleton
  final double height;

  /// The radius of the skeleton
  final Radius radius;

  /// Choose your style of animaion.
  /// The default is SkeletonAnimation.pulse
  final SkeletonAnimation animation;

  Skeleton(
      {
      // Use default colors
      this.baseColor,
      this.hightlightColor = const Color(0xFFF4F4F4),
      // Use default size
      this.width = 200.0,
      this.height = 60.0,
      // Use default radius
      this.radius = const Radius.circular(0),
      // Use the default animation
      this.animation = SkeletonAnimation.pulse});

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
    } else if (widget.animation == SkeletonAnimation.wave) {
      // Create the wave animation
      // TODO: Need to improve this animation
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
      )..addStatusListener((AnimationStatus status) {
          if (status != AnimationStatus.completed) {
            return;
          }

          // Restart the animation when done
          _controller.repeat();
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
    double _themeOpacity = Theme.of(context).brightness == Brightness.light ? 0.11 : 0.13;
    // Generate the correct color
    Color _baseColor = (widget.baseColor == null) ? Color.alphaBlend(_themeTextColor.withOpacity(_themeOpacity), Theme.of(context).scaffoldBackgroundColor) : widget.baseColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(widget.radius),
          // Import the correct animation
          color: (widget.animation == SkeletonAnimation.pulse)
              ? _baseColor.withOpacity(_controller.value) // Pulse
              : _baseColor, // None
          gradient: (widget.animation == SkeletonAnimation.wave)
              ? LinearGradient(
                  // Wave
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _baseColor,
                    widget.hightlightColor,
                    _baseColor,
                  ],
                  stops: [
                    // Animate using the controller value (0 - 1)
                    _generateValue(percentage: _controller.value, value: 0.35),
                    _generateValue(percentage: _controller.value, value: 0.5),
                    _generateValue(percentage: _controller.value, value: 0.65),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Generate the value for the loading animation
  double _generateValue({percentage: double, value: double}) {
    double tmp = (percentage * 1.3) - 0.65 + value;

    if (tmp < 0) {
      return 0;
    } else if (tmp > 1) {
      return 1;
    } else {
      return tmp;
    }
  }
}
