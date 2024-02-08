import 'package:flutter/material.dart';
import 'package:recycle/features/recycle/components/naviate_recommend_button.dart';

class RecycleResultDialog extends StatelessWidget {
  const RecycleResultDialog({required this.kindOfRecycle, Key? key})
      : super(key: key);
  final String kindOfRecycle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      width: double.infinity,
      child: Column(
        children: [
          returnKindOfRecycle(kindOfRecycle),
          SizedBox(height: 20),
          returnRecycleTip('''
1. 물기를 제거한 후 배출
2. 라벨 제거
3. 플라스틱, 종이, 유리병 등으로 분리배출
4. 플라스틱, 종이, 유리병 등으로 분리배출
'''),
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
          Text(kindOfRecycle,
              style: TextStyle(
                fontSize: 14,
              )),
        ],
      ),
    );
  }

  Container returnRecycleTip(String recycleTip) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '분리수거 방법',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(recycleTip,
              style: TextStyle(
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}
