import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/bloc/register_bloc/register_state.dart';
import 'package:smessanger/src/bloc/register_bloc/register_status.dart';
import 'package:smessanger/src/models/roles.dart';
import 'package:smessanger/src/resources/domain/repositories/firebase_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  PageController controller = PageController();
  final FireBaseRepository fRepostiry;
  final FilePicker filePick;
  RegistrationBloc({required this.fRepostiry, required this.filePick})
      : super(RegistrationState()) {
    //
    on<RegUIDLoadingEvent>(
        (event, emit) => emit(state.copyWith(uid: event.uid)));
    on<RegNameChangeEvent>(
        (event, emit) => emit(state.copyWith(name: event.name)));

    on<RegSurnameChangeEvent>(
        (event, emit) => emit(state.copyWith(surname: event.surname)));

    on<RegPinCodeChangeEvent>(
        (event, emit) => emit(state.copyWith(pinCode: event.pinCode)));

    on<RegAvatarSelectEvent>(
      (event, emit) async {
        try {
          final image = await filePick.pickFiles(type: FileType.image);

          if (image != null) {
            emit(state.copyWith(status: RegAvatarLoadingStatus()));
            final File avatar = File(image.files.single.path!);
            final String uploadedAvatar =
                await fRepostiry.uploadFile(avatar, 'images/${state.uid}');
            emit(state.copyWith(
                avatarUrl: uploadedAvatar, status: RegAvatarLoadedStatus()));
          }
        } catch (e) {
          state.copyWith(status: RegAvatarErrorStatus());
        }
      },
    );

    on<RegRoleSelectEvent>((event, emit) {
      final List<Roles> roles = [...state.roles, event.role];
      emit(state.copyWith(roles: roles));
    });

    on<RegRoleDeleteEvent>((event, emit) {
      List<Roles> roles = state.roles;
      roles.remove(event.role);
      emit(state.copyWith(roles: roles));
    });
  }
  nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  pervousePage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
