import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/utils/colors/app_colors.dart';

import '../blocks/notes/notes_block.dart';
import '../blocks/notes/notes_event.dart';
import '../screens/global_screen/global_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotesBloc()..add(GetNotesEvent()),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        414,
        896,
      ),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.c252525,
            ),
            scaffoldBackgroundColor: AppColors.c252525,
            useMaterial3: false,
          ),
          home: const GlobalScreen(),
        );
      },
    );
  }
}
