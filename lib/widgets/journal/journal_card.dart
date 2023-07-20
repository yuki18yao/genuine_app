import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JournalCard extends StatelessWidget {
  final String text;
  final String nickname;
  final String? link;
  final List<String>? imageLinks;
  final String uid;
  //final JournalType journalType;
  final Timestamp createdTime;
  //final List<String>? commentIds;
  final String journalId;
  final String userImage;

  final bool isImageJournal;

  const JournalCard.text({
    super.key,
    required this.nickname,
    required this.text,
    this.link,
    required this.uid,
    required this.createdTime,
    //this.commentIds,
    required this.journalId,
    required this.userImage,
  })  : isImageJournal = false,
        imageLinks = null;

  const JournalCard.image({
    super.key,
    required this.nickname,
    required this.text,
    this.link,
    required this.imageLinks,
    required this.uid,
    required this.createdTime,
    //this.commentIds,
    required this.journalId,
    required this.userImage,
  }) : isImageJournal = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                radius: 30,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(
                          nickname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      /*
                      Text(
                          createdTime,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),*/
                    ],
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        //const Divider(color: Color.fromARGB(255, 196, 195, 195),),
      ],
    );
  }
}
