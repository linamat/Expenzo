import 'package:flutter/material.dart';
import 'package:expenzo/theme/export.dart';

class MainTabBarItem extends StatelessWidget {
  final TabController tabController;
  final String tabBarName;
  final int index;
  final double height;
  const MainTabBarItem({
    Key? key,
    required this.tabController,
    required this.tabBarName,
    required this.index,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tabController.animateTo(index);
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tabController.index == index
              ? white.withValues(alpha: 0.2)
              : transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(minWidth: 80),
        child: Text(
          tabBarName,
          style: TextStyle(color: primaryTextColor),
        ),
      ),
    );
  }
}
