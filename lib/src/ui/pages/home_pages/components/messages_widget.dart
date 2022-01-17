import 'package:flutter/material.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({
    Key? key,
    required this.animation,
    required this.message,
    required this.userModel,
  }) : super(key: key);
  final Animation<double> animation;
  final MessageModel message;

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    bool isNotMy = message.from == userModel.uid;
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        mainAxisAlignment:
            isNotMy ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          isNotMy
              ? CircleAvatar(
                  backgroundImage: NetworkImage(userModel.avatarUrl!))
              : const SizedBox(),
          Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            color: isNotMy
                ? Theme.of(context).backgroundColor
                : Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isNotMy
                    ? Text(
                        userModel.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    : const SizedBox(),
                Text(
                  message.message,
                  style: isNotMy
                      ? Theme.of(context).textTheme.bodyText2
                      : TextStyle(color: Theme.of(context).backgroundColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
