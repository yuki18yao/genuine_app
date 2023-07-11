import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:genuine_app/core/enums/journal_type_enum.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalControllerProvider =
    StateNotifierProvider<JournalController, bool>((ref) {
  return JournalController(
    ref: ref,
  );
});

class JournalController extends StateNotifier<bool> {
  final Ref _ref;
  final user = FirebaseAuth.instance.currentUser!;

  JournalController({
    required Ref ref,
  })  : _ref = ref,
        super(false);

  void shareJournal({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      const SnackBar(content: Text('Please enter text'));
      return;
    }

    if (images.isNotEmpty) {
      _shareImageJournal(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextJournal(
        text: text,
        context: context,
      );
    }
  }

  void _shareImageJournal({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    String link = _getLinkFromText(text);
    List<String> imageLinks = [];

    final storageRef =
        FirebaseStorage.instance
        .ref()
        .child('journal_images');
        //.child('${user.uid}.jpg');

    for (File image in images) {
      storageRef.child('${user.uid}.jpg').putFile(image);
      imageLinks.add(await storageRef.getDownloadURL());
    }
    
    // Retrieving the user data from the FirebaseFirestore 'users' collection
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Storing the journal data into the FirebaseFirestore
    FirebaseFirestore.instance.collection('journal').add(
      {
        'text': text,
        'link': link,
        'imageLinks': imageLinks,
        'uid': user.uid,
        'nickname': userData.data()!['nickname'],
        'userImage': userData.data()!['image_url'],
        'journalType': 'image',
        'createdTime': DateTime.now(),
        'commentIds': [],
        'journalId': '',
      },
    );
    state = false;
  }

  void _shareTextJournal({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    String link = _getLinkFromText(text);
    // Retrieving the user data from the FirebaseFirestore 'users' collection
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Storing the journal data into the FirebaseFirestore
    FirebaseFirestore.instance.collection('journal').add(
      {
        'text': text,
        'link': link,
        'imageLinks': [],
        'uid': user.uid,
        'nickname': userData.data()!['nickname'],
        'userImage': userData.data()!['image_url'],
        'journalType': 'text',
        'createdTime': DateTime.now(),
        'commentIds': [],
        'journalId': '',
      },
    );
    state = false;
  }

  /// A method to extract link from the input text
  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }
}
