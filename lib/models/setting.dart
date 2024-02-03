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
  final String route;

  Menu({
    required this.menu,
    required this.route,
  });
}

List<Setting> settings = [
  Setting(
    title: "일반",
    menus: [
      Menu(
        menu: "내 정보",
        route: '내 정보',
      ),
      Menu(
        menu: "공지사항",
        route: '공지사항',
      ),
      Menu(
        menu: "로그아웃",
        route: '로그아웃',
      ),
      Menu(
        menu: "회원탈퇴",
        route: '회원탈퇴',
      ),
    ],
  ),
  Setting(
    title: "내 활동",
    menus: [
      Menu(
        menu: "내가 쓴 글",
        route: '/setting/createdPost',
      ),
      Menu(
        menu: "내가 쓴 댓글",
        route: '내가 쓴 댓글',
      ),
      Menu(
        menu: "좋아요 누른 글",
        route: '좋아요 누른 글',
      ),
      Menu(
        menu: "리트윗한 글",
        route: '리트윗한 글',
      ),
    ],
  ),
  Setting(
    title: "문의 및 알림",
    menus: [
      Menu(
        menu: "알림 설정",
        route: '알림 설정',
      ),
      Menu(
        menu: "고객센터",
        route: '고객센터',
      ),
      Menu(
        menu: "약관 및 정책",
        route: '약관 및 정책',
      ),
      Menu(
        menu: "현재 버전 0.0.1",
        route: '현재 버전 0.0.1',
      ),
    ],
  ),
];
