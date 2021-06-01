import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdteam_demo_chat/app/data/models/models.dart';
import 'package:pdteam_demo_chat/app/data/provider/provider.dart';

class ChatProvider {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  Stream<List<Message>> getMessages(String uid) {
    final ref =
        store.collection('conversations').doc(uid).collection('messages');
    return ref
        .orderBy('created_at', descending: true)
        .snapshots()
        .transform(StreamTransformer.fromHandlers(
      handleData: (snapshot, sink) {
        final messages = <Message>[];
        snapshot.docs.forEach((element) {
          messages.add(Message.fromMap(element.data()));
        });
        sink.add(messages);
      },
    ));
  }

  Future<Stream<List<Group>>> getConversations() async {
    final currentUser = UserProvider.getCurrentUser();
    final l = await _getListGroup(currentUser!.uid);
    if (l.isEmpty) {
      return Stream.empty();
    }
    final ref = store.collection('conversations').where('id', whereIn: l);
    return ref.snapshots().transform(StreamTransformer.fromHandlers(
      handleData: (snapshot, sink) async {
        final groups = <Group>[];
        snapshot.docs.forEach((element) async {
          final members = <MyUser>[];
          List.from(element.get('members')).forEach((element) async {
            final user = await UserProvider().getUser(element);
            members.add(user);
          });
          final group = Group(
              uid: element.id,
              lastMessage: element.data().containsKey('last_message')
                  ? Message.fromMap(element.get('last_message'))
                  : null,
              members: members);
          groups.add(group);
        });
        sink.add(groups);
      },
    ));
  }

  Future sendMessage(String uid, Message message) async {
    final ref = store.collection('conversations').doc(uid);
    ref.update({'last_message': message.toMap()});
    ref.collection('messages').add(message.toMap());
  }

  Future createGroupChat(List<String> userUIDs) async {
    final ref = store.collection('conversations');
    final doc = ref.doc();
    doc.set({'id': doc.id});
    userUIDs.add(UserProvider.getCurrentUser()!.uid);
    userUIDs.forEach((element) async {
      final groups = await _getListGroup(element)
        ..add(doc.id);
      store.collection('user').doc(element).update({
        'groups': groups,
      });
    });
    doc.update({'members': userUIDs});
  }

  Future<List<String>> _getListGroup(String uid) async {
    final ref = store.collection('user');
    final data = await ref.doc(uid).get();
    final d = data.data();
    if (d == null) {
      return [];
    }
    if (d.containsKey('groups')) {
      return List<String>.from(data.get('groups'));
    } else {
      return [];
    }
  }
}
