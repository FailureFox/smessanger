import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({
    Key? key,
    required this.animation,
    required this.message,
    required this.nextId,
    required this.userModel,
  }) : super(key: key);
  final Animation<double> animation;
  final MessageTextModel message;
  final String nextId;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    final bool nextMessageThis = nextId == message.from;
    bool isNotMy = message.from == userModel.uid;
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
      child: Row(
        mainAxisAlignment:
            isNotMy ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          isNotMy
              ? (!nextMessageThis
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(userModel.avatarUrl!))
                  : const SizedBox(width: 40))
              : const SizedBox(),
          GestureDetector(
            onLongPress: () {
              showDialog(context: context, builder: (context) => AlertDialog());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isNotMy
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: !isNotMy
                          ? const BorderRadius.only(
                              bottomLeft: radius,
                              topLeft: radius,
                              topRight: radius)
                          : const BorderRadius.only(
                              bottomRight: radius,
                              topLeft: radius,
                              topRight: radius)),
                  child: Text(
                    message.message,
                    style: isNotMy
                        ? Theme.of(context).textTheme.bodyText2
                        : TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                ),
                if (isNotMy && !nextMessageThis)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      userModel.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat("HH:mm").format(message.dateTime.toDate()),
                    style: const TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
