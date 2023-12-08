import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/util/extension.dart';
import 'package:survey_kit/survey_kit.dart';

/// This widget is used to display the content of a [Step].
class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
    required this.content,
    this.center = true,
    this.padding = const EdgeInsets.all(16),
  });
  final List<Content> content;
  final bool center;
  final EdgeInsets padding;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    final contentView = Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.content
            .map(
              (e) => e.createWidget(),
            )
            .withSeparator(
              const _Separator(
                height: 14,
              ),
            )
            .toList(),
      ),
    );

    return widget.center ? Center(child: contentView) : contentView;
  }
}

/// This widget is used to display a seperator between two widgets in the content
class _Separator extends StatelessWidget {
  const _Separator({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
