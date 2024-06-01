import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> logIn(String email, String password) async {
    try {
      emit(LoginLoading());
      await authRepo.logIn(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
