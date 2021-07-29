import 'package:flutter_test/flutter_test.dart';
import 'package:fade_shimmer/fade_shimmer.dart';

void main() {
  testWidgets('FadeShimmer.round() can be constructed',
      (WidgetTester tester) async {
    final widget = FadeShimmer.round(
      size: 60,
      fadeTheme: FadeTheme.dark,
      millisecondsDelay: 0,
    );
    expect(widget, isA<FadeShimmer>());
  });
}
