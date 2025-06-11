import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class UserAvatarName extends StatelessWidget {
  final String name;
  final String? avatarPath; // puede ser null, usar imagen local por ahora

  const UserAvatarName({
    super.key,
    required this.name,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = Responsive.getScreenType(context);
    final isMobile = screenType == ScreenType.mobilePortrait;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: avatarPath != null
              ? AssetImage(avatarPath!)
              : const AssetImage('assets/default_user.png'),
        ),
        if (!isMobile) ...[
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ],
    );
  }
}
