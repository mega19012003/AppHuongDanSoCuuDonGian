import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final Function(int) onMenuItemTap; // Callback để thay đổi màn hình

  const SideMenu({
    Key? key,
    required this.onMenuItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => onMenuItemTap(0),
          ),
          DrawerListTile(
            title: "Bài viết",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onMenuItemTap(1),
          ),
          DrawerListTile(
            title: "Người dùng",
            svgSrc: "assets/icons/menu_task.svg",
            press: () => onMenuItemTap(2),
          ),
          /*DrawerListTile(
            title: "Bình luận và đánh giá",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () => onMenuItemTap(3),
          ),
          DrawerListTile(
            title: "Logout",
            svgSrc: "assets/icons/menu_store.svg",
            press: () => onMenuItemTap(4),
          ),*/
          /*DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () => onMenuItemTap(5),
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () => onMenuItemTap(6),
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => onMenuItemTap(7),
          ),*/
        ],
      ),
    );
  }
}


class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
