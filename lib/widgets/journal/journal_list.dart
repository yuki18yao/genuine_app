import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalList extends ConsumerWidget {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('journal')
          .orderBy(
            'createdTime',
            descending: false,
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
            itemCount: loadedJournals.length,
            itemBuilder: (context, index) => Text(
                  loadedJournals[index].data()['text'],
                ));
      },
    );
  }
}
