import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../repositories/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    try {
      emit(RegisterLoading());
      await authRepo.register(email, password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }
}