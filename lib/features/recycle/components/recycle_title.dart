import 'package:flutter/material.dart';

class RecycleScreenTitle extends StatelessWidget {
  const RecycleScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0.25),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: const Text(
        '사진을 찍어 분리수거 방법과 재활용 팁을 확인해 보세요!',
        // 글자 스페이스 단위로 줄바꿈
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(9, 33, 0, 1),
          fontSize: 16.0,
        ),
      ),
    );
  }
}
