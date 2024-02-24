import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:recycle/controller/gemeini_controller.dart';
import 'package:recycle/features/recycle/components/naviate_recommend_button.dart';

class RecycleResultDialog extends StatefulWidget {
  RecycleResultDialog({required this.kindOfRecycle, Key? key})
      : super(key: key);
  final String kindOfRecycle;

  @override
  State<RecycleResultDialog> createState() => _RecycleResultDialogState();
}

class _RecycleResultDialogState extends State<RecycleResultDialog> {
  String answer = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      width: double.infinity,
      child: Column(
        children: [
          returnKindOfRecycle(widget.kindOfRecycle),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: returnRecycleTip(widget.kindOfRecycle),
            ),
          ),
          SizedBox(height: 20),
          NavigateRecommendButton(),
        ],
      ),
    );
  }

  Container returnKindOfRecycle(String kindOfRecycle) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '종류',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            kindOfRecycle,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder returnRecycleTip(String recycleKind) {
    return StreamBuilder<GenerateContentResponse>(
      stream: GeminiController.to
          .generateText('How can i properly recycle $recycleKind?'),
      builder: (BuildContext context,
          AsyncSnapshot<GenerateContentResponse> snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Center(child: Text('${snapshot.error}')),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data?.text != null) {
            answer += snapshot.data!.text as String;
          }

          String text = answer; // 'text' 대신 실제 텍스트 데이터에 접근하는 방법 사용

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '분리배출 팁',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          );
        } else {
          return Container(
            child: Center(
              child: Text('No data available'),
            ),
          );
        }
      },
    );
  }
}
