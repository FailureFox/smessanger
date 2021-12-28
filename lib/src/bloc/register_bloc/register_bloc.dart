import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/bloc/register_bloc/register_state.dart';
import 'package:smessanger/src/bloc/register_bloc/register_status.dart';
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













    // //userInitialSetupPage
    // //name-surname
    // on<AuthInitialUserSetupLoading>((event, emit) {
    //   final mystate = state as AuthPhoneVerifyState;
    //   emit(AuthUserInitialSetupState(
    //     countryCode: mystate.selectedCountry.name,
    //     phoneNumber: mystate.phoneNumber,
    //   ));
    // });
    // on<AuthNameChangeEvent>((event, emit) {
    //   emit((state as AuthUserInitialSetupState).copyWIth(name: event.name));
    // });
    // on<AuthSurnameChangeEvent>((event, emit) {
    //   emit((state as AuthUserInitialSetupState)
    //       .copyWIth(surname: event.surname));
    // });
    // //photo
    // on<AuthPhotoSelectEvent>((event, emit) async {
    //   try {
    //     final file = await FilePicker.platform.pickFiles(allowMultiple: false);
    //     if (file != null) {
    //       final fileType = file.files.single.extension;
    //       if (fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg') {
    //         emit((state as AuthUserInitialSetupState)
    //             .copyWIth(status: AuthStatus.loading));
    //         File photo = File(file.files.single.path!);
    //         final String avatar =
    //             await firebase.uploadFile(photo, 'images/$myUID/');
    //         final downloadUrl = await firebase.getDownloadUrl(avatar);
    //         emit((state as AuthUserInitialSetupState).copyWIth(
    //           avatar: avatar,
    //           avatarDownloadUrl: downloadUrl,
    //           status: AuthStatus.loaded,
    //         ));
    //       } else {
    //         emit((state as AuthUserInitialSetupState).copyWIth(
    //           status: AuthStatus.error,
    //         ));
    //       }
    //     }
    //   } catch (e) {
    //     emit((state as AuthUserInitialSetupState).copyWIth(
    //       status: AuthStatus.error,
    //     ));
    //   }
    // });
    // on<AuthSetupPinChangeEvent>((event, emit) {
    //   emit((state as AuthUserInitialSetupState).copyWIth(pin: event.pin));
    // });