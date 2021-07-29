/// * author: quango
/// * email: quango2304@gmail.com

library fade_shimmer;

import 'dart:async';

import 'package:flutter/material.dart';

class FadeShimmer extends StatefulWidget {
  final Color? highlightColor;
  final Color? baseColor;
  final double radius;
  final double width;
  final double height;

  //delay time before update the color, use this to make loading items animate follow each other instead of parallel, check the example for demo.
  final int millisecondsDelay;

  const FadeShimmer(
      {Key? key,
      this.millisecondsDelay = 0,
      this.radius = 0,
      this.highlightColor,
      this.baseColor,
      required this.width,
      required this.height})
      : super(key: key);

  factory FadeShimmer.round({
    required double size,
    Color? highlightColor,
    int millisecondsDelay = 0,
    Color? baseColor,
  }) =>
      FadeShimmer(
        height: size,
        width: size,
        radius: size / 2,
        baseColor: baseColor,
        highlightColor: highlightColor,
        millisecondsDelay: millisecondsDelay,
      );

  @override
  _FadeShimmerState createState() => _FadeShimmerState();
}

class _FadeShimmerState extends State<FadeShimmer> {
  static final isHighLightStream =
      Stream<bool>.periodic(const Duration(seconds: 1), (x) => x % 2 == 0)
          .asBroadcastStream();
  bool isHighLight = true;
  late StreamSubscription sub;

  Color get themeHighLightColor {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Color(0xffF9F9FB);
      case Brightness.dark:
        return Color(0xff3A3E3F);
    }
  }

  Color get themeBaseColor {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Color(0xffE6E8EB);
      case Brightness.dark:
        return Color(0xff2A2C2E);
    }
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  void safeSetState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    sub = isHighLightStream.listen((_isHighLight) {
      if (widget.millisecondsDelay != 0) {
        Future.delayed(Duration(milliseconds: widget.millisecondsDelay), () {
          isHighLight = _isHighLight;
          safeSetState();
        });
      } else {
        isHighLight = _isHighLight;
        safeSetState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 1200),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: isHighLight
              ? widget.highlightColor ?? themeHighLightColor
              : widget.baseColor ?? themeBaseColor,
          borderRadius: BorderRadius.circular(widget.radius)),
    );
  }
}
