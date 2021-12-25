import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:smessanger/src/bloc/auth_bloc/auth_bloc_export.dart';

class PhotoUploadPage extends StatelessWidget {
  const PhotoUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        final myState = state as AuthUserInitialSetupState;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload a photo',
                style: Theme.of(context).textTheme.headline1),
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                radius: MediaQuery.of(context).size.width / 7,
                backgroundImage: state.avatar == ''
                    ? null
                    : AssetImage('assets/larry/hello.png'),
                child: IconButton(
                    color: Theme.of(context).iconTheme.color,
                    splashRadius: 0.1,
                    iconSize: MediaQuery.of(context).size.width / 9,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthPhotoSelectEvent());
                    },
                    icon: const Icon(Icons.add_a_photo_rounded)),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.width / 8,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: state.avatar == '' ? null : () {},
                    child: const Text('Next')))
          ],
        );
      }),
    );
  }
}
