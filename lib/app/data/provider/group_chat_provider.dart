import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdteam_demo_chat/app/data/models/models.dart';
import 'package:pdteam_demo_chat/app/data/provider/provider.dart';

class GroupChatProvider {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  Stream<List<Group>> getConversations() {
    final currentUser = UserProvider.getCurrentUser()!;
    final ref = store
        .collection('conversations')
        .where('members', arrayContains: currentUser.uid)
        .orderBy('last_message', descending: true);
    return ref.snapshots().transform(
        StreamTransformer.fromHandlers(handleData: _tranDocToConversations));
  }

  Future _tranDocToConversations(QuerySnapshot<Map<String, dynamic>> snapshot,
      EventSink<List<Group>> sink) async {
    final groups = <Group>[];
    snapshot.docs;
    for (final element in snapshot.docs) {
      final members = <MyUser>[];
      for (final u in List.from(element.get('members'))) {
        final user = await UserProvider().getUser(u);
        members.add(user);
      }
      final group = Group(
          uid: element.id,
          name: element.data()['name'] ?? '',
          lastMessage: element.data().containsKey('last_message')
              ? Map.from(element.get('last_message')).isNotEmpty
                  ? FirebaseMessage.fromMap(element.get('last_message'))
                  : null
              : null,
          members: members);
      groups.add(group);
    }
    sink.add(groups);
  }

  Future createGroupChat(List<String> userUIDs, String? grpName) async {
    final ref = store.collection('conversations');
    final doc = ref.doc();
    doc.set({
      'id': doc.id,
      'name': grpName ?? '',
      'last_message': Map.identity(),
    });
    doc.update({'members': userUIDs});
  }
}
