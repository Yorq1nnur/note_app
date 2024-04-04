import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import '../blocks/notes/notes_block.dart';
import '../blocks/notes/notes_state.dart';
import '../data/models/notes_model.dart';
import '../local_data_base/local_db.dart';
import '../utils/styles/app_text_style.dart';

class GlobalScreen extends StatelessWidget {
  const GlobalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.c252525,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.c252525,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.c252525,
          title: Text(
            'Notes',
            style: AppTextStyle.interBold.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 40.sp,
            ),
          ),
          actions: [
            GlobalButtonHome(
              () {},
              AppImages.search,
            ),
            SizedBox(
              width: 20.w,
            ),
            GlobalButtonHome(
              () {},
              AppImages.info,
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
        body: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
          if (state is NotesErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.empty,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  "Create your first note !",
                  style: AppTextStyle.interBold.copyWith(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            );
          } else if (state is NotesSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 40.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  state.notesList.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 170.h,
                              ),
                              Image.asset(AppImages.rafiki),
                              Text(
                                "Create your first note !",
                                style: TextStyle(
                                  fontSize: 20.w,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                state.notesList.length,
                                (index) => Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 21.h, horizontal: 45.w),
                                  margin: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.w),
                                    color: _randomColor(),
                                  ),
                                  child: Text(
                                    state.notesList[index].noteText,
                                    style: TextStyle(
                                      fontSize: 25.w,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          }
          return const SizedBox();
        }),
        floatingActionButton: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                .4,
              ),
              blurRadius: 10.r,
              offset: Offset(-5.w, 5.w),
            )
          ]),
          child: FloatingActionButton(
            backgroundColor: AppColors.c252525,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 48.w,
              ),
            ),
            onPressed: () {
              LocalDatabase.insertNote(
                NotesModel(
                  noteText: 'noteText',
                  createdDate: 'createdDate',
                  noteColor: '0xFFFFFFFF',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Color _randomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
