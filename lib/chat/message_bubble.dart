import 'package:flutter/material.dart';

class MsgBubble extends StatefulWidget {
  final String msg;
  bool isMe;
  final Key key;
  MsgBubble(this.msg, this.isMe, {required this.key});

  @override
  _MsgBubbleState createState() => _MsgBubbleState();
}

class _MsgBubbleState extends State<MsgBubble> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: widget.isMe
                    ? Colors.grey[300]
                    : Theme.of(context).accentColor,
                borderRadius: widget.isMe
                    ? BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
              ),
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.msg,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isMe ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
