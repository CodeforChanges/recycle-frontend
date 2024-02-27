import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:recycle/features/recycle/components/recycle_tip_dialog.dart';
import 'package:recycle/utils/color_utils.dart';

class NavigateRecommendButton extends StatelessWidget {
  NavigateRecommendButton({required this.type, Key? key}) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClickHandler,
      child: Text(
        '추천 재활용 방법 보기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    );
  }

  void onClickHandler() async {
    print("type: $type");
    await PostController.to.getRecommendPosts(type);
    // close dialog
    navigator
        ?.popUntil((route) => !Get.isDialogOpen! && !Get.isBottomSheetOpen!);
    // navigate to recycle tim screen
    Get.defaultDialog(
      title: "추천 재활용 방법",
      content: RecycleTipDialog(),
    );
  }
}
