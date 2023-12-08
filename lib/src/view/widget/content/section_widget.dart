import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/section_content.dart';
import 'package:survey_kit/src/util/ui_utils.dart';
import 'package:survey_kit/src/view/widget/content/styled_text_widget.dart';

/// This widget is responsible for displaying the section content of a survey step.
class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.sectionContent,
  });

  final SectionContent sectionContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sectionContent.toList
          .map(
            (e) => StyledTextWidget(content: e),
          )
          .separate(verySmallVerticalSpacer)
          .toList(),
    );
  }
}

extension on Iterable<Widget> {
  Iterable<Widget> separate(Widget separator) {
    return [
      ...expand((element) => [element, separator]),
    ]..removeLast();
  }
}
