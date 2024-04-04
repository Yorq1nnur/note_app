import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/blocks/notes/notes_block.dart';
import 'package:note_app/blocks/notes/notes_event.dart';
import 'package:note_app/data/models/notes_model.dart';
import 'package:note_app/local_data_base/local_db.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import 'package:note_app/utils/styles/app_text_style.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.notesModel,
  });

  final NotesModel notesModel;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String title = '';

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
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                  ),
                  child: GlobalButtonHome(
                    () async {
                      await LocalDatabase.updateNote(
                        widget.notesModel.copyWith(
                          id: widget.notesModel.id,
                          noteText: title == ''
                              ? widget.notesModel.noteText
                              : _textController.text,
                          createdDate: title == ''
                              ? widget.notesModel.createdDate
                              : DateTime.now().toString(),
                        ),
                        widget.notesModel.id!,
                      );

                      if (context.mounted) {
                        context.read<NotesBloc>().add(GetNotesEvent());
                        Navigator.pop(context);
                      }
                    },
                    AppImages.save,
                  ),
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
                title = v;
                setState(() {});
              },
              onChanged: (v) {
                title = v;
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
