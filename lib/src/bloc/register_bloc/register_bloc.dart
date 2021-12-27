import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/register_bloc/register_event.dart';
import 'package:smessanger/src/bloc/register_bloc/register_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState()) {
    on((event, emit) => null);
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