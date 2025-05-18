import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fade_shimmer/fade_shimmer.dart';

/// Tests for the FadeShimmer package.
///
/// These tests focus on verifying the construction and properties of the FadeShimmer widget.
/// Note that we're not testing the actual rendering and animation behavior due to limitations
/// with testing timers in the Flutter test environment. The FadeShimmer widget uses a static
/// timer that can't be easily mocked in tests.

void main() {
  group('FadeShimmer Construction Tests', () {
    testWidgets('FadeShimmer.round() can be constructed',
        (WidgetTester tester) async {
      final widget = FadeShimmer.round(
        size: 60,
        fadeTheme: FadeTheme.dark,
        millisecondsDelay: 0,
      );
      expect(widget, isA<FadeShimmer>());

      // Verify properties
      expect(widget.width, 60);
      expect(widget.height, 60);
      expect(widget.radius, 30); // size / 2
      expect(widget.fadeTheme, FadeTheme.dark);
      expect(widget.millisecondsDelay, 0);
    });

    testWidgets('FadeShimmer.round() with custom colors can be constructed',
        (WidgetTester tester) async {
      final Color highlightColor = Color(0xFFFFFFFF);
      final Color baseColor = Color(0xFFCCCCCC);

      final widget = FadeShimmer.round(
        size: 60,
        highlightColor: highlightColor,
        baseColor: baseColor,
        millisecondsDelay: 200,
      );

      expect(widget, isA<FadeShimmer>());
      expect(widget.width, 60);
      expect(widget.height, 60);
      expect(widget.radius, 30);
      expect(widget.highlightColor, highlightColor);
      expect(widget.baseColor, baseColor);
      expect(widget.fadeTheme, isNull);
      expect(widget.millisecondsDelay, 200);
    });

    testWidgets('FadeShimmer with custom colors can be constructed',
        (WidgetTester tester) async {
      final Color highlightColor = Color(0xFFFFFFFF);
      final Color baseColor = Color(0xFFCCCCCC);

      final widget = FadeShimmer(
        width: 100,
        height: 20,
        radius: 4,
        highlightColor: highlightColor,
        baseColor: baseColor,
      );

      expect(widget, isA<FadeShimmer>());
      expect(widget.highlightColor, highlightColor);
      expect(widget.baseColor, baseColor);
      expect(widget.fadeTheme, isNull);
      expect(widget.millisecondsDelay, 0); // Default value
      expect(widget.radius, 4);
    });

    testWidgets('FadeShimmer with light theme can be constructed',
        (WidgetTester tester) async {
      final widget = FadeShimmer(
        width: 100,
        height: 20,
        fadeTheme: FadeTheme.light,
      );

      expect(widget, isA<FadeShimmer>());
      expect(widget.fadeTheme, FadeTheme.light);
      expect(widget.width, 100);
      expect(widget.height, 20);
      expect(widget.radius, 0); // Default value
    });

    testWidgets('FadeShimmer with millisecondsDelay can be constructed',
        (WidgetTester tester) async {
      final widget = FadeShimmer(
        width: 100,
        height: 20,
        fadeTheme: FadeTheme.dark,
        millisecondsDelay: 500,
      );

      expect(widget, isA<FadeShimmer>());
      expect(widget.millisecondsDelay, 500);
      expect(widget.fadeTheme, FadeTheme.dark);
    });

    testWidgets('FadeShimmer with custom radius can be constructed',
        (WidgetTester tester) async {
      final widget = FadeShimmer(
        width: 200,
        height: 30,
        radius: 15,
        fadeTheme: FadeTheme.light,
      );

      expect(widget, isA<FadeShimmer>());
      expect(widget.radius, 15);
      expect(widget.width, 200);
      expect(widget.height, 30);
    });
  });

  // Note: We're skipping rendering tests due to timer issues in the test environment
  // The FadeShimmer widget uses a static timer that can't be easily mocked in tests

  group('FadeTheme Tests', () {
    test('FadeTheme enum has correct values', () {
      expect(FadeTheme.values.length, 2);
      expect(FadeTheme.values, contains(FadeTheme.light));
      expect(FadeTheme.values, contains(FadeTheme.dark));
    });
  });

  group('FadeShimmer Animation Duration Tests', () {
    test('Default animation duration is 1000 milliseconds', () {
      expect(FadeShimmer.animationDurationInMillisecond, 1000);
    });

    test('Animation duration can be changed', () {
      // Save original value to restore later
      final originalDuration = FadeShimmer.animationDurationInMillisecond;

      // Change the duration
      FadeShimmer.animationDurationInMillisecond = 2000;
      expect(FadeShimmer.animationDurationInMillisecond, 2000);

      // Restore original value
      FadeShimmer.animationDurationInMillisecond = originalDuration;
    });
  });

  group('FadeShimmer Assertion Tests', () {
    test('FadeShimmer throws assertion error when both fadeTheme and colors are null', () {
      expect(
        () => FadeShimmer(
          width: 100,
          height: 20,
          // No fadeTheme or colors provided
        ),
        throwsAssertionError,
      );
    });

    test('FadeShimmer does not throw when fadeTheme is provided', () {
      expect(
        () => FadeShimmer(
          width: 100,
          height: 20,
          fadeTheme: FadeTheme.light,
        ),
        isNot(throwsAssertionError),
      );
    });

    test('FadeShimmer does not throw when both colors are provided', () {
      expect(
        () => FadeShimmer(
          width: 100,
          height: 20,
          highlightColor: Colors.white,
          baseColor: Colors.grey,
        ),
        isNot(throwsAssertionError),
      );
    });
  });
}
