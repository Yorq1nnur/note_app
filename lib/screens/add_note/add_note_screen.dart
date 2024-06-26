import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/blocks/notes/notes_block.dart';
import 'package:note_app/blocks/notes/notes_event.dart';
import 'package:note_app/data/models/notes_model.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import 'package:note_app/utils/styles/app_text_style.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                  ),
                  child: GlobalButtonHome(
                    () {
                      Navigator.pop(context);
                    },
                    AppImages.arrowBack,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25.h,
                      ),
                      child: GlobalButtonHome(
                        () {},
                        AppImages.eye,
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25.h,
                      ),
                      child: GlobalButtonHome(
                        () {
                          context.read<NotesBloc>().add(
                                InsertNotesEvent(
                                  noteModel: NotesModel(
                                    noteText: _textController.text,
                                    createdDate: DateTime.now().toString(),
                                  ),
                                ),
                              );
                          Navigator.pop(context);
                        },
                        AppImages.save,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextField(
                      enabled: false,
                      style: AppTextStyle.interBold.copyWith(
                        color: AppColors.c9A9A9A,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: _textController,
                      maxLines: 10000000,
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            TextField(
              style: AppTextStyle.interBold.copyWith(
                color: AppColors.c9A9A9A,
                fontSize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
              onSubmitted: (v) {
                setState(() {});
              },
              onChanged: (v) {
                setState(() {});
              },
              controller: _textController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.c252525)),
                  labelText: 'Type something...',
                  labelStyle: AppTextStyle.interBold.copyWith(
                    color: AppColors.c9A9A9A,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
