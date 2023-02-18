// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      number: json['number'] as int,
      name: json['name'] as String,
      text: json['text'] as String,
      category: json['category'] as String,
      dateTimeCreate: json['dateTimeCreate'] as String,
      dateTimeEdit: json['dateTimeEdit'] as String,
      deleted: json['deleted'] == null ? false : true,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'text': instance.text,
      'category': instance.category,
      'dateTimeCreate': instance.dateTimeCreate,
      'dateTimeEdit': instance.dateTimeEdit,
      'deleted': instance.deleted,
    };
