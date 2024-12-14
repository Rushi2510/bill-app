import 'package:bill_app/constants/colors.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;

  const GradientAppBar({super.key, this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
     titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
  color: AppColors.white,
),

      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff72c6ef), Color(0xff004e8f)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: title,
      actions: actions,
      leading: leading,
      backgroundColor: Colors.transparent, // Ensures the gradient shows
      actionsIconTheme: IconThemeData(color: AppColors.white),
      iconTheme:IconThemeData(color: AppColors.white), 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}