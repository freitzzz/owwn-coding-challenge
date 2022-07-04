import 'package:dartz/dartz.dart' show Left, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owwn_coding_challenge/blocs/blocs.dart';
import 'package:owwn_coding_challenge/data/data.dart';
import 'package:owwn_coding_challenge/models/models.dart';
import 'package:owwn_coding_challenge/presentation/presentation.dart';
import 'package:owwn_coding_challenge/presentation/routing/pages.dart';

class MockUsersRepository extends Mock implements UsersRepository {}

class FakeAppNavigator extends AppNavigator {
  final List<Page> pages;

  const FakeAppNavigator({
    required this.pages,
  });

  @override
  State<AppNavigator> createState() => FakeAppNavigatorState();
}

class FakeAppNavigatorState extends AppNavigatorState {
  @override
  Widget build(BuildContext context) {
    final arguments = this.arguments;

    final widget = this.widget as FakeAppNavigator;

    return Navigator(
      pages: [
        ...widget.pages,
        if (arguments is UserPageArguments)
          UserPage(
            arguments: arguments,
          ),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  void setNewRoute(PageArguments arguments) {}
}

Widget widgetUnderTest(final Widget widget) {
  return MaterialApp(
    home: widget,
    localizationsDelegates: const [
      AppLocalizations.delegate,
    ],
    locale: supportedLocales.first,
    supportedLocales: supportedLocales,
  );
}

void main() {
  final mockUsersRepository = MockUsersRepository();

  final testUsers = List.generate(
    6,
    (index) => User(
      email: 'email',
      id: 'id_$index',
      name: 'name',
      statistics: [],
      status: Status.active,
      gender: Gender.other,
    ),
  );

  testWidgets(
    'Users list loads the first page and fails on the second page',
    (WidgetTester tester) async {
      // Arrange

      const firstPage = 0;
      const secondPage = 1;
      const limit = limitPerUsersFetch;

      when(
        () => mockUsersRepository.users(
          page: firstPage,
          limit: limit,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Right(testUsers),
        ),
      );

      when(
        () => mockUsersRepository.users(
          page: secondPage,
          limit: limit,
        ),
      ).thenAnswer(
        (_) => Future.value(
          const Left(
            InvalidSessionAuthenticationError(
              stacktrace: StackTrace.empty,
            ),
          ),
        ),
      );

      final usersBloc = UsersBloc(
        usersRepository: mockUsersRepository,
      );

      await tester.pumpWidget(
        widgetUnderTest(
          BlocProvider.value(
            value: usersBloc,
            child: const UsersView(),
          ),
        ),
      );

      // Assert (this schedules a future, needs to be defined here as it is a stream that is being expected)

      expectLater(
        usersBloc.stream,
        emitsInOrder(
          [
            isA<FetchUsersSuccess>(),
            isA<FetchUsersFailure>(),
          ],
        ),
      );

      // Act

      usersBloc.add(
        FetchUsersEvent(),
      );

      await tester.pump();

      usersBloc.add(
        FetchUsersEvent(),
      );

      await tester.pump();
    },
  );

  testWidgets(
    'Tap on an item and change users name then pop and check if details are updated',
    (WidgetTester tester) async {
      // Arrange

      const page = 0;
      const limit = limitPerUsersFetch;

      final testUser = testUsers.first;

      when(
        () => mockUsersRepository.users(
          page: page,
          limit: limit,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Right(testUsers),
        ),
      );

      final usersBloc = UsersBloc(
        usersRepository: mockUsersRepository,
      );

      await tester.pumpWidget(
        widgetUnderTest(
          BlocProvider.value(
            value: usersBloc,
            child: FakeAppNavigator(
              pages: [
                UsersPage(),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      final userListTileFinder = find.byKey(
        Key('user_list_tile_${testUser.id}'),
      );

      await tester.tap(userListTileFinder);
    },
  );

  testWidgets(
    'Panning on the chart shows the currect value',
    (WidgetTester tester) async {
      // maybe a golden test can be applied here?
    },
  );
}
