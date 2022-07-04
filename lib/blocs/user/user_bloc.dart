import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;

  late TextEditingController emailTextEditingController;

  late TextEditingController nameTextEditingController;

  User user;

  UserBloc({
    required this.usersRepository,
    required this.user,
  }) : super(
          UserInitial(
            user: user,
            emailTextEditingController: TextEditingController(
              text: user.email,
            ),
            nameTextEditingController: TextEditingController(
              text: user.name,
            ),
          ),
        ) {
    nameTextEditingController = state.nameTextEditingController;
    nameTextEditingController.addListener(_onUserNameChanged);

    emailTextEditingController = state.emailTextEditingController;
    emailTextEditingController.addListener(_onUserEmailChanged);

    on<UserUpdateEvent>(
      (event, emit) {
        if (nameTextEditingController.text != user.name ||
            emailTextEditingController.text != user.email) {
          emit(
            UserEditInProgress(
              nameTextEditingController: nameTextEditingController,
              emailTextEditingController: emailTextEditingController,
              user: user.copyWith(
                name: nameTextEditingController.text,
              ),
            ),
          );
        } else {
          emit(
            UserInitial(
              emailTextEditingController: emailTextEditingController,
              nameTextEditingController: nameTextEditingController,
              user: user,
            ),
          );
        }
      },
    );

    on<UserSaveEvent>(
      (event, emit) async {
        emit(
          UserSaveInProgress(
            emailTextEditingController: emailTextEditingController,
            nameTextEditingController: nameTextEditingController,
            user: state.user,
          ),
        );

        final updatedUser = user.copyWith(
          email: emailTextEditingController.text,
          name: nameTextEditingController.text,
        );

        final result = await usersRepository.update(
          user: user,
        );

        emit(
          result.fold(
            (l) => UserSaveFailure(
              emailTextEditingController: emailTextEditingController,
              nameTextEditingController: nameTextEditingController,
              user: state.user,
            ),
            (r) {
              user = updatedUser;

              return UserSaveSuccess(
                emailTextEditingController: emailTextEditingController,
                nameTextEditingController: nameTextEditingController,
                user: user,
              );
            },
          ),
        );
      },
    );
  }

  void _onUserNameChanged() {
    add(UserUpdateEvent());
  }

  void _onUserEmailChanged() {
    add(UserUpdateEvent());
  }

  @override
  Future<void> close() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();

    return super.close();
  }
}
