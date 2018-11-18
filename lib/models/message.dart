import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:protect_me_mobile/models/user.dart';

class Message {
  final User to;
  final User from;
  final String message;
  final DateTime date;

  Message(this.to, this.from, this.message, this.date);

  Message.fromSnapshot(DocumentSnapshot snapshot)
    : this.from = User.fromDocument(snapshot["from"]), 
      this.to = User.fromDocument(snapshot["to"]),
      this.message = snapshot["message"],
      this.date = DateTime(snapshot["createdAt"]){ print(to.username + "-" + snapshot["createdAt"].toString()); }
}