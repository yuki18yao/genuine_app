import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget {
  final String text;
  final String? link;
  final List<String>? imageLinks;
  final String uid;
  //final JournalType journalType;
  final DateTime createdTime;
  final List<String>? commentIds;
  final String journalId;
  final String userImage;

  const JournalCard({
    super.key,
    required this.text,
    this.link,
    this.imageLinks,
    required this.uid,
    required this.createdTime,
    this.commentIds,
    required this.journalId,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
