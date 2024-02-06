import 'package:get/get.dart';
import 'package:recycle/controller/auth_service.dart';

class Setting {
  final String title;
  final List<Menu> menus;

  const Setting({
    required this.title,
    required this.menus,
  });
}

class Menu {
  final String menu;
  final String Function() onPress;

  Menu({
    required this.menu,
    required this.onPress,
  });
}

List<Setting> settings = [
  Setting(
    title: "일반",
    menus: [
      Menu(
        menu: "내 정보",
        onPress: () => '내 정보',
      ),
      Menu(
        menu: "공지사항",
        onPress: () => '공지사항',
      ),
      Menu(
        menu: "로그아웃",
        onPress: () {
          AuthService.to.signOut();
          return '로그아웃';
        },
      ),
      Menu(
        menu: "회원탈퇴",
        onPress: () => '회원탈퇴',
      ),
    ],
  ),
  Setting(
    title: "내 활동",
    menus: [
      Menu(
          menu: "내가 쓴 글",
          onPress: () {
            Get.toNamed('/setting/createdPost');
            return '내가 쓴 글';
          }),
      Menu(
        menu: "내가 쓴 댓글",
        onPress: () => '내가 쓴 댓글',
      ),
      Menu(
        menu: "좋아요 누른 글",
        onPress: () => '좋아요 누른 글',
      ),
      Menu(
        menu: "리트윗한 글",
        onPress: () => '리트윗한 글',
      ),
    ],
  ),
  Setting(
    title: "문의 및 알림",
    menus: [
      Menu(
        menu: "알림 설정",
        onPress: () => '알림 설정',
      ),
      Menu(
        menu: "고객센터",
        onPress: () => '고객센터',
      ),
      Menu(
        menu: "약관 및 정책",
        onPress: () => '약관 및 정책',
      ),
      Menu(
        menu: "현재 버전 0.0.1",
        onPress: () => '현재 버전 0.0.1',
      ),
    ],
  ),
];
