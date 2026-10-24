import 'package:flutter/material.dart';

enum AiGymSvgIconName {
  workoutDumbbell, domainGlobe, warningAlert, shieldOtp, sparklesAi,
  mailCode, cameraCoach, smtpServer, keyToken, checkVerified,
}

class AiGymSvgIcon extends StatelessWidget {
  const AiGymSvgIcon(this.name, {super.key, this.size = 24, this.color});
  final AiGymSvgIconName name;
  final double size;
  final Color? color;
  IconData get _icon => switch (name) {
    AiGymSvgIconName.workoutDumbbell => Icons.fitness_center,
    AiGymSvgIconName.domainGlobe => Icons.language,
    AiGymSvgIconName.warningAlert => Icons.warning_amber_rounded,
    AiGymSvgIconName.shieldOtp => Icons.shield_outlined,
    AiGymSvgIconName.sparklesAi => Icons.auto_awesome,
    AiGymSvgIconName.mailCode => Icons.mark_email_read_outlined,
    AiGymSvgIconName.cameraCoach => Icons.camera_alt_outlined,
    AiGymSvgIconName.smtpServer => Icons.dns_outlined,
    AiGymSvgIconName.keyToken => Icons.key_outlined,
    AiGymSvgIconName.checkVerified => Icons.verified_outlined,
  };
  @override Widget build(BuildContext context) => Icon(_icon, size: size, color: color);
}

class AiGymSvgOtpHeroBadge extends StatelessWidget {
  const AiGymSvgOtpHeroBadge({super.key, required this.primaryColor, required this.secondaryColor, this.size = 72});
  final Color primaryColor;
  final Color secondaryColor;
  final double size;
  @override Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
    child: Icon(Icons.shield_outlined, color: Colors.white, size: size * .52),
  );
}

