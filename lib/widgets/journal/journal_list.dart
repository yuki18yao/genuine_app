import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genuine_app/widgets/journal/journal_card.dart';

class JournalList extends ConsumerWidget {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('journal')
          .orderBy(
            'createdTime',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No posts found.'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedJournals = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 40,
            left: 13,
            right: 13,
          ),
          itemCount: loadedJournals.length,
          itemBuilder: (context, index) {
            //loadedJournals[index].data()['text'],
            final journal = loadedJournals[index].data();
            return JournalCard(
              text: journal['text'],
              link: journal['link'],
              imageLinks: journal['imageLinks'],
              uid: journal['uid'],
              createdTime: journal['createdTime'],
              commentIds: journal['commentIds'],
              journalId: journal['journalId'],
              userImage: journal['userImage'],
            );
          },
        );
      },
    );
  }
}
