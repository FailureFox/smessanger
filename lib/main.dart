import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_event.dart';
import 'package:smessanger/src/bloc/app_bloc/app_state.dart';
import 'package:smessanger/src/bloc/app_bloc/app_status.dart';
import 'package:smessanger/src/ui/screens/auth_screen.dart';
import 'package:smessanger/src/ui/screens/home_screen.dart';
import 'injections.dart' as rep;
import 'package:smessanger/src/ui/styles/theme.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await rep.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (_) => rep.sl.call<AppBloc>(), child: const _MyApp());
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AppBloc>().add(AppThemeLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        title: 'Messanger',
        home: state.status == AppStatus.unlogged
            ? const AuthScreen()
            : state.status == AppStatus.initial
                ? const WaitingScreen()
                : const HomeScreen(),
      );
    });
  }
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Pure.',
              style: Theme.of(context).textTheme.headline1,
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
              child: const Text('Powered by FailureFox'),
            )
          ],
        ),
      ),
    );
  }
}
