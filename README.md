# skeleton_animation

![Pub Version](https://img.shields.io/pub/v/skeleton_animation)

Creates a simple skeleton animation that can be used on android, iOS and the web.

<p>
  <img src="https://github.com/wjtje/flutter-skeleton-animation/blob/master/screenshots/list-view.gif?raw=true"/>
</p>

# How to use

```dart
import 'package:skeleton_animation/skeleton_animation.dart';
```

```dart
Skeleton(
  width: 200,
  height: 12,
  radius: Radius.circular(6),
  animation: SkeletonAnimation.pulse
),
```