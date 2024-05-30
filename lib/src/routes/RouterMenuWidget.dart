import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title, 
    required this.icon, 
    required this.onPress, 
    required this.endIcon, 
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.withOpacity(0.1)
        ),
        child: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title, 
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500
        ),
      ),
      trailing:endIcon? Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1)
        ),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          color: Colors.grey,
          size: 18,
        ),
      ) : null,
    );
  }
}
