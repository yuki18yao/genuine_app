import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genuine_app/widgets/journal/input_journal.dart';
import 'package:genuine_app/widgets/journal/journal_card.dart';

class JournalList extends ConsumerWidget {
  const JournalList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Method to display the InputJournal screen once clicked
    onInputJournal() {
      Navigator.push(context, InputJournal.route());
    }

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

        return Stack(alignment: Alignment.bottomRight, children: [
          ListView.builder(
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
              
              final otherJournal = index + 1 < loadedJournals.length
                  ? loadedJournals[index + 1].data()
                  : null;

              final currentJournalUserId = journal['uid'];
              final otherJournalUserId =
                  otherJournal != null ? otherJournal['uid'] : null;

              if (otherJournal == null) {
                return null;
              } else if (currentJournalUserId == otherJournalUserId) {
                return JournalCard.text(
                  nickname: journal['nickname'],
                  text: journal['text'],
                  link: journal['link'],
                  uid: journal['uid'],
                  createdTime: journal['createdTime'],
                  //commentIds: journal['commentIds'],
                  journalId: journal['journalId'],
                  userImage: journal['userImage'],
                );
              } else {
                return JournalCard.text(
                  nickname: otherJournal['nickname'],
                  text: otherJournal['text'],
                  link: otherJournal['link'],
                  uid: otherJournal['uid'],
                  createdTime: otherJournal['createdTime'],
                  //commentIds: journal['commentIds'],
                  journalId: otherJournal['journalId'],
                  userImage: otherJournal['userImage'],
                );
              }
              /*
              return JournalCard.text(
                  nickname: journal['nickname'],
                  text: journal['text'],
                  link: journal['link'],
                  uid: journal['uid'],
                  createdTime: journal['createdTime'],
                  //commentIds: journal['commentIds'],
                  journalId: journal['journalId'],
                  userImage: journal['userImage'],
                );*/
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              onPressed: onInputJournal,
              backgroundColor: const Color(0xff067d68),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          )
        ]);
      },
    );
  }
}
