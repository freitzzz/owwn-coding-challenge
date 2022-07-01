import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coding Challenge',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.translate(
          offset: const Offset(0, -68),
          child: SizedBox.square(
            dimension: 136,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const SecondPage();
                  },
                ),
              ),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [.8, 1],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Press to start',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Column(
        children: users.map((user) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ThirdPage();
                },
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 1),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Text(user.name.substring(0, 1)),
                  ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.black),
                      child: Column(
                        children: [
                          Text(user.name),
                          Text(user.email),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = users.first;
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Text(user.name.substring(0, 1)),
            ),
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(user.name),
                  Text(user.email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Gender { male, female }

enum Status { active, inactive }

class User {
  final String name;
  final String email;
  final Gender gender;
  final Status status;
  final List<double> statistics;

  const User({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
    required this.statistics,
  });
}

List<User> users = const [
  User(
    name: 'Soheil',
    email: 'soheil@owwn.com',
    gender: Gender.male,
    status: Status.active,
    statistics: [],
  ),
  User(
    name: 'Daniel',
    email: 'daniel@owwn.com',
    gender: Gender.male,
    status: Status.active,
    statistics: [],
  ),
  User(
    name: 'Amir',
    email: 'amir@owwn.com',
    gender: Gender.male,
    status: Status.inactive,
    statistics: [],
  ),
  User(
    name: 'Umit',
    email: 'umit@owwn.com',
    gender: Gender.male,
    status: Status.inactive,
    statistics: [],
  ),
];
