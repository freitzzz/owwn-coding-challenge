import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User user;

  late TextEditingController nameTextEditingController;

  UserBloc({
    required this.user,
  }) : super(
          UserInitial(
            user: user,
            nameTextEditingController: TextEditingController(
              text: user.name,
            ),
          ),
        ) {
    nameTextEditingController = state.nameTextEditingController;
    nameTextEditingController.addListener(_onUserNameChanged);

    on<UserNameUpdated>(
      (event, emit) {
        if (nameTextEditingController.text != user.name) {
          emit(
            UserEditInProgress(
              nameTextEditingController: nameTextEditingController,
              user: user.copyWith(
                name: nameTextEditingController.text,
              ),
            ),
          );
        } else {
          emit(
            UserInitial(
              nameTextEditingController: nameTextEditingController,
              user: user,
            ),
          );
        }
      },
    );

    on<UserSaveEvent>(
      (event, emit) {
        emit(
          UserSaveInProgress(
            user: state.user,
            nameTextEditingController: nameTextEditingController,
          ),
        );
      },
    );
  }

  void _onUserNameChanged() {
    add(UserNameUpdated());
  }

  @override
  Future<void> close() {
    nameTextEditingController.dispose();

    return super.close();
  }
}
