// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/profile_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthDatasources authDatasources;
  ProfileBloc(
    this.authDatasources,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final result = await authDatasources.getProfile();
        emit(ProfileLoaded(profile: result));
      } catch (e) {
        emit(ProfileError(message: 'Network Problem ${e.toString()}'));
      }
    });
  }
}
