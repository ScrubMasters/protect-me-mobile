import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protect_me_mobile/models/message.dart';
import 'package:protect_me_mobile/models/user.dart';

class ChatPage extends StatefulWidget {
  final User currentUser;

  ChatPage(this.currentUser);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  String text = "";
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.redAccent,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      }
    );
  } 

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    messages = snapshot.map((d) => Message.fromSnapshot(d)).toList();
    messages.sort((a, b) => b.date.difference(a.date).isNegative ? -1 : 1);
    messages = messages.where((a) => a.to.username == widget.currentUser.username || a.from.username == widget.currentUser.username).toList();
    return Column(
      children: <Widget>[
        Flexible(child: 
          ListView(
            reverse: messages.length != 0,
            children: messages.map((data) => _buildListItem(context, data)).toList(),
          ),
        ),
        (messages.length == 0 ? Container(
          margin: EdgeInsets.only(bottom: 350),
          child: Text("Empty chat", style: TextStyle(fontSize: 30, color: Colors.grey),),
        ): Container()),
        _buildInput()
      ],
    );
    
  }

  Widget _buildListItem(BuildContext context, Message msg) {
    return Padding(
     key: ValueKey(msg.message),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: InkWell(
       borderRadius: BorderRadius.all(Radius.circular(10)),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: msg.from.username == widget.currentUser.username ? Color.fromARGB(100, 252, 143, 151) : Color.fromARGB(100, 164, 229, 107),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: msg.from.username == widget.currentUser.username ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: msg.from.username == widget.currentUser.username ? _myMessage(msg) : _otherMessage(msg),
          )
        ),
      ),
   );
  }

  Widget _msgContent(Message msg, bool mine) {
    return Column(
      mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: mine? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(mine ? "Me" : msg.from.username, textAlign: TextAlign.left, style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),)
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            child:Text(msg.message, style: TextStyle(fontSize: 20, ),),
          ) 
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(_formatDate(msg.date), style: TextStyle(color: Colors.grey),)
        ),
      ],
    );
  }

  Widget _messageAvatar(Message msg, bool mine) {
    return  Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            msg.from.avatar,
          )
        )
      ),
    );
  }

  List<Widget> _myMessage(msg) {
    return <Widget>[
      _msgContent(msg, true),
      _messageAvatar(msg, true),
    ];
  }

  List<Widget> _otherMessage(msg) {
    return <Widget>[
      _messageAvatar(msg, false),
      _msgContent(msg, false),
    ];
  }

  Widget _buildInput() {

    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child:Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Message..."
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a message';
                  } else {
                    text = value;
                  }
                },
              ),
            ),
            Flexible(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(20), 
                    child: Icon(Icons.send, size: 20),
                  ),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      User to = messages.firstWhere((m) => m.from.username != widget.currentUser.username).from;
                      print(to);
                      if(to == null) return;
                      print(to.username);
                      Firestore.instance.collection('messages').add({
                        "to": to.toJson(),
                        "from": widget.currentUser.toJson(),
                        "message": text,
                        "createdAt": DateTime.now().millisecondsSinceEpoch
                      }).then((_) {
                        _formKey.currentState.reset();
                        text = "";
                      });
                    }
                  },
                )
              ),
          ],
        ),
      )
    );
  }

  String _formatDate(DateTime date) {
    String minutes = date.minute.toString();
    if(minutes.length == 1)
      minutes = "0" + minutes;

    String hours = date.hour.toString();
    if(hours.length == 1)
      hours = "0" + hours;

    return "$hours:$minutes";
  }
}