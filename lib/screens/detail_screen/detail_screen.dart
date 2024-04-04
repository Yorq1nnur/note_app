import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/global_widgets/home_button.dart';
import 'package:note_app/utils/colors/app_colors.dart';
import 'package:note_app/utils/images/app_images.dart';
import 'package:note_app/utils/styles/app_text_style.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
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
                    () {},
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
                      style: AppTextStyle.interBold.copyWith(
                        color: AppColors.c9A9A9A,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: _textController,
                      maxLines: 100,
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
