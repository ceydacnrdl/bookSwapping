import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookswa/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var chatDocs = snapshot.data!.docs;
        FirebaseAuth _auth = FirebaseAuth.instance;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MsgBubble(
                chatDocs[i]['text'],
                chatDocs[i]['userId'] == currentUser,
                key: ValueKey(chatDocs[i].id),
              ),
            );
          },
        );
      },
    );
  }
}
