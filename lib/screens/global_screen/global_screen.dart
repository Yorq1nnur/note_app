import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/detail_screen/detail_screen.dart';
import 'package:note_app/screens/search/search_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:note_app/blocks/notes/notes_event.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import '../../blocks/notes/notes_block.dart';
import '../../blocks/notes/notes_state.dart';
import '../../utils/styles/app_text_style.dart';
import '../add_note/add_note_screen.dart';

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
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesErrorState) {
            return Scaffold(
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
                toolbarHeight: 100.h,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                    child: GlobalButtonHome(
                      () {},
                      AppImages.search,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                    child: GlobalButtonHome(
                      () {},
                      AppImages.info,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
              body: Column(
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
              ),
              floatingActionButton: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      .4,
                    ),
                    blurRadius: 10.r,
                    offset: Offset(
                      -5.w,
                      5.w,
                    ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNoteScreen(),
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is NotesSuccessState) {
            List<String> searchNotes = [];
            for (int i = 0; i < state.notesList.length; i++) {
              searchNotes.add(state.notesList[i].noteText.toLowerCase());
            }
            return Scaffold(
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
                toolbarHeight: 100.h,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                    child: GlobalButtonHome(
                      () async {
                        final result = await showSearch(
                          context: context,
                          delegate:
                              MySearchDelegate(searchNotes, state.notesList),
                        );
                        if (result != null) {
                          debugPrint('Selected item: $result');
                        }
                      },
                      AppImages.search,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                    child: GlobalButtonHome(
                      () {},
                      AppImages.info,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            state.notesList.length,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                              ),
                              child: Ink(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    12.w,
                                  ),
                                  color: Color(
                                    int.parse(
                                      state.notesList[index].noteColor!,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                    12.r,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          notesModel: state.notesList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.red,
                                          title: Text(
                                            'WARNING!!!',
                                            style:
                                                AppTextStyle.interBold.copyWith(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          content: Text(
                                            'CONFIRM TO DELETE?',
                                            style:
                                                AppTextStyle.interBold.copyWith(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ZoomTapAnimation(
                                              onTap: () {
                                                context.read<NotesBloc>().add(
                                                      DeleteNotesEvent(
                                                        notesModel: state
                                                            .notesList[index],
                                                      ),
                                                    );
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.tealAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.r,
                                                  ),
                                                ),
                                                child: Text(
                                                  'YES',
                                                  style: AppTextStyle.interBold
                                                      .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ZoomTapAnimation(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.tealAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.r,
                                                  ),
                                                ),
                                                child: Text(
                                                  'NO',
                                                  style: AppTextStyle.interBold
                                                      .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 21.h,
                                        horizontal: 45.w,
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      .4,
                    ),
                    blurRadius: 10.r,
                    offset: Offset(
                      -5.w,
                      5.w,
                    ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNoteScreen(),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Scaffold(
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
              toolbarHeight: 100.h,
              actions: [
                Padding(
                  padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                  child: GlobalButtonHome(
                    () {},
                    AppImages.search,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                  child: GlobalButtonHome(
                    () {},
                    AppImages.info,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    .4,
                  ),
                  blurRadius: 10.r,
                  offset: Offset(
                    -5.w,
                    5.w,
                  ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNoteScreen(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
