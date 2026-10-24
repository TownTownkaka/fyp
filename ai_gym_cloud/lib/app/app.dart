import 'package:flutter/material.dart';
import 'package:ai_gym_flutter/core/constants/app_config.dart';
import 'package:ai_gym_flutter/core/theme/glass_theme.dart';
import 'package:ai_gym_flutter/models/app_user.dart';
import 'package:ai_gym_flutter/screens/auth/auth_screen.dart';
import 'package:ai_gym_flutter/screens/auth/otp_verification_screen.dart';
import 'package:ai_gym_flutter/services/auth_service.dart';
import 'package:ai_gym_flutter/services/camera_detection_service.dart';
import 'package:ai_gym_flutter/services/database_service.dart';
import 'package:ai_gym_flutter/services/diagnostics_service.dart';
import 'package:ai_gym_flutter/services/notification_service.dart';
import 'package:ai_gym_flutter/services/preference_service.dart';

class AiGymCloudApp extends StatelessWidget {
  const AiGymCloudApp({
    super.key,
    required this.config,
    required this.prefs,
    required this.diagnostics,
    required this.notifications,
    required this.authService,
    required this.dbService,
    required this.cameraService,
  });

  final AppConfig config;
  final PreferenceService prefs;
  final DiagnosticsService diagnostics;
  final NotificationService notifications;
  final AuthService authService;
  final DatabaseService dbService;
  final CameraDetectionService cameraService;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([prefs, authService]),
      builder: (context, _) {
        final light = GlassTheme.buildTheme(brightness: Brightness.light, glassEnabled: prefs.glassThemeEnabled);
        final dark = GlassTheme.buildTheme(brightness: Brightness.dark, glassEnabled: prefs.glassThemeEnabled);
        return MaterialApp(
          title: 'AI Gym Cloud',
          debugShowCheckedModeBanner: false,
          theme: light,
          darkTheme: dark,
          themeMode: prefs.themeMode,
          locale: Locale(prefs.languageCode),
          home: _home(),
        );
      },
    );
  }

  Widget _home() {
    final user = authService.currentUser;
    if (user.stage == AuthFlowStage.awaitingEmailOtp) {
      return OtpVerificationScreen(authService: authService, prefs: prefs);
    }
    if (user.stage == AuthFlowStage.unauthenticated) {
      return AuthScreen(config: config, authService: authService, prefs: prefs);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Gym Cloud'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => authService.signOut(allSessions: false),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fitness_center, size: 64),
              const SizedBox(height: 16),
              Text('Welcome, ${user.displayName.isEmpty ? 'Athlete' : user.displayName}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(user.isGuest ? 'Guest mode' : user.email),
            ],
          ),
        ),
      ),
    );
  }
}

