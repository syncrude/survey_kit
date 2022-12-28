// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextContent _$TextContentFromJson(Map<String, dynamic> json) => TextContent(
      id: json['id'] as String,
      text: json['text'] as String,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']) ??
          TextAlign.center,
    );

Map<String, dynamic> _$TextContentToJson(TextContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'fontSize': instance.fontSize,
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
