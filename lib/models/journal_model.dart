// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:genuine_app/core/enums/journal_type_enum.dart';

@immutable
class Journal {
  final String text;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final JournalType journalType;
  final DateTime createdTime;
  final List<String> commentIds;
  final String journalId;
  const Journal({
    required this.text,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.journalType,
    required this.createdTime,
    required this.commentIds,
    required this.journalId,
  });

  Journal copyWith({
    String? text,
    String? link,
    List<String>? imageLinks,
    String? uid,
    JournalType? journalType,
    DateTime? createdTime,
    List<String>? commentIds,
    String? journalId,
  }) {
    return Journal(
      text: text ?? this.text,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      journalType: journalType ?? this.journalType,
      createdTime: createdTime ?? this.createdTime,
      commentIds: commentIds ?? this.commentIds,
      journalId: journalId ?? this.journalId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'link': link,
      'imageLinks': imageLinks,
      'uid': uid,
      'journalType': journalType.type,
      'createdTime': createdTime.millisecondsSinceEpoch,
      'commentIds': commentIds,
    };
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      text: map['text'] as String,
      link: map['link'] as String,
      imageLinks: List<String>.from(map['imageLinks'] as List<String>),
      uid: map['uid'] as String,
      journalType: (map['journalType'] as String).toJournalTypeEnum(),
      createdTime: DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
      commentIds: List<String>.from(map['commentIds'] as List<String>),
      journalId: map['\$journalId'] as String,
    );
  }

  @override
  String toString() {
    return 'Journal(text: $text, link: $link, imageLinks: $imageLinks, uid: $uid, journalType: $journalType, createdTime: $createdTime, commentIds: $commentIds, journalId: $journalId)';
  }

  @override
  bool operator ==(covariant Journal other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.text == text &&
      other.link == link &&
      listEquals(other.imageLinks, imageLinks) &&
      other.uid == uid &&
      other.journalType == journalType &&
      other.createdTime == createdTime &&
      listEquals(other.commentIds, commentIds) &&
      other.journalId == journalId;
  }

  @override
  int get hashCode {
    return text.hashCode ^
      link.hashCode ^
      imageLinks.hashCode ^
      uid.hashCode ^
      journalType.hashCode ^
      createdTime.hashCode ^
      commentIds.hashCode ^
      journalId.hashCode;
  }
}
