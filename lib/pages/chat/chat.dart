import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_doctor_app/constant/constant.dart';

class ChatScreen extends StatefulWidget {
  final String name;

  const ChatScreen({Key key, @required this.name}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();
  DateTime now = DateTime.now();
  ScrollController _scrollController = new ScrollController();
  String amPm;
  final chatData = [
    {
      'role': 'me',
      'msg': 'I\'m feeling sick for 2 days.',
      'time': '9:38 AM',
      'read': 'unread'
    },
    {
      'role': 'sender',
      'msg': 'How can i help you?',
      'time': '9:37 AM',
      'read': 'read'
    },
    {'role': 'sender', 'msg': 'Hello', 'time': '9:36 AM', 'read': 'read'},
    {'role': 'me', 'msg': 'Hello Doctor', 'time': '9:35 AM', 'read': 'read'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          elevation: 1.0,
          title: Text(
            'Dr. ${widget.name}',
            style: appBarTitleTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: (chatData.length == 0)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      color: greyColor,
                      size: 70.0,
                    ),
                    heightSpace,
                    Text(
                      'No Messages',
                      style: greyNormalTextStyle,
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chatData.length,
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        final item = chatData[index];
                        return Container(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: (item['role'] == 'sender')
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: (item['role'] == 'sender')
                                        ? EdgeInsets.only(right: 100.0)
                                        : EdgeInsets.only(left: 100.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          (item['role'] == 'sender')
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(fixPadding),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: fixPadding),
                                          decoration: BoxDecoration(
                                            borderRadius: (item['role'] ==
                                                    'sender')
                                                ? BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                  )
                                                : BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(0.0),
                                                  ),
                                            color: (item['role'] == 'sender')
                                                ? Colors.grey[300]
                                                : primaryColor,
                                          ),
                                          child: Text(
                                            item['msg'],
                                            style: (item['role'] == 'sender')
                                                ? blackNormalTextStyle
                                                : whiteColorNormalTextStyle,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                (item['role'] == 'sender')
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              (item['role'] == 'sender')
                                                  ? Container()
                                                  : Icon(
                                                      (item['read'] == 'read')
                                                          ? Icons.done_all
                                                          : Icons.check,
                                                      color: Colors.blueAccent,
                                                      size: 14.0,
                                                    ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                item['time'],
                                                style: greySmallTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: width,
                    height: 70.0,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: TextField(
                              controller: msgController,
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                              cursorColor: whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Type a Message',
                                hintStyle: whiteColorSmallTextStyle,
                                contentPadding: EdgeInsets.only(left: 10.0),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            if (msgController.text != '') {
                              if (now.hour > 11) {
                                amPm = 'PM';
                              } else {
                                amPm = 'AM';
                              }
                              setState(() {
                                chatData.insert(0, {
                                  'role': 'me',
                                  'msg': msgController.text,
                                  'time': (now.hour > 12)
                                      ? '${now.hour - 12}:${now.minute} $amPm'
                                      : '${now.hour}:${now.minute} $amPm',
                                  'read': 'unread'
                                });
                                msgController.text = '';
                                _scrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                              });
                            }
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: greyColor.withOpacity(0.40),
                            ),
                            child: Icon(
                              Icons.send,
                              color: primaryColor,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
