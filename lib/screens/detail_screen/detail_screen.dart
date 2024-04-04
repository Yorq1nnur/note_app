import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/data/models/notes_model.dart';
import 'package:note_app/screens/edit_note/edit_note_screen.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import 'package:note_app/utils/styles/app_text_style.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.notesModel,
  });

  final NotesModel notesModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = widget.notesModel.noteText;
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
                    () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            notesModel: widget.notesModel,
                          ),
                        ),
                      );
                    },
                    AppImages.edit,
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
                      maxLines: 100000,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
