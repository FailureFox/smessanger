import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/bloc/register_bloc/register_state.dart';
import 'package:smessanger/src/bloc/register_bloc/register_status.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/models/roles.dart';
import 'package:smessanger/src/resources/domain/repositories/auth_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/file_repository.dart';
import 'package:smessanger/src/resources/domain/repositories/token_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  PageController controller = PageController();
  final AuthRepository repository;
  final FileRepository fileRepository;
  final FilePicker filePick;
  final TokenRepository tokenRepository;
  RegistrationBloc({
    required this.repository,
    required this.filePick,
    required this.tokenRepository,
    required this.fileRepository,
  }) : super(RegistrationState()) {
    //
    on<RegUIDLoadingEvent>((event, emit) => emit(state.copyWith(
          uid: event.uid,
          country: event.country,
          phoneNumber: event.phoneNumber,
        )));
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
                await fileRepository.uploadFile(avatar, 'images/${state.uid}');
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
    on<RegRegisterAccountEvent>((event, emit) {
      MyProfile profile = MyProfile(
          name: state.name,
          surname: state.surname,
          status: '',
          countryCode: state.country,
          uid: state.uid,
          roles: state.roles.map((e) => e.toString()).toList(),
          avatarUrl: state.avatarUrl,
          phoneNumber: state.phoneNumber,
          newsChannels: state.interestedNews);

      repository.createAccount(profile);
      tokenRepository.saveToken(profile.uid);
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
