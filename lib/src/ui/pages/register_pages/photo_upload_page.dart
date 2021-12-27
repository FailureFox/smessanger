import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_status.dart';

class PhotoUploadPage extends StatelessWidget {
  const PhotoUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload a photo', style: Theme.of(context).textTheme.headline1),
          Center(
            child: CircleAvatar(
              backgroundColor: Theme.of(context).backgroundColor,
              radius: MediaQuery.of(context).size.width / 6,
              backgroundImage: 1 == 2 ? null : NetworkImage('url'),
              child: 1 == 2
                  ? IconButton(
                      color: Theme.of(context).iconTheme.color,
                      splashRadius: 0.1,
                      iconSize: MediaQuery.of(context).size.width / 7,
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo_rounded))
                  : 1 == 2
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : null,
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width / 8,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: 1 == 2 ? null : () {}, child: const Text('Next')))
        ],
      ),
    );
  }
}
