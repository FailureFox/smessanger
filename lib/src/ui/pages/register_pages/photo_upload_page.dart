import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/bloc/register_bloc/register_state.dart';
import 'package:smessanger/src/bloc/register_bloc/register_status.dart';

class PhotoUploadPage extends StatelessWidget {
  const PhotoUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.read<RegistrationBloc>().pervousePage(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).hintColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload a photo',
                style: Theme.of(context).textTheme.headline1),
            const RegAvatarSelectWidget(),
            const RegAvatarSelectNextButton()
          ],
        ),
      ),
    );
  }
}

class RegAvatarSelectWidget extends StatelessWidget {
  const RegAvatarSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
        final myStatus = state.status;
        return CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          radius: MediaQuery.of(context).size.width / 6,
          backgroundImage: myStatus is RegAvatarLoadedStatus
              ? NetworkImage(state.avatarUrl)
              : null,
          child: myStatus is RegAvatarLoadingStatus
              ? const Center(child: CircularProgressIndicator())
              : myStatus is RegAvatarLoadedStatus
                  ? null
                  : IconButton(
                      color: Theme.of(context).iconTheme.color,
                      splashRadius: 0.1,
                      iconSize: MediaQuery.of(context).size.width / 7,
                      onPressed: () {
                        context
                            .read<RegistrationBloc>()
                            .add(RegAvatarSelectEvent());
                      },
                      icon: const Icon(Icons.add_a_photo_rounded),
                    ),
        );
      }),
    );
  }
}

class RegAvatarSelectNextButton extends StatelessWidget {
  const RegAvatarSelectNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 15,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.status is RegAvatarLoadedStatus
              ? () {
                  context.read<RegistrationBloc>().nextPage();
                }
              : null,
          child: const Text('Next'),
        ),
      );
    });
  }
}
