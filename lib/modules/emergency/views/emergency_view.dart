import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/themes/themes.dart';
import '../../../core/ai_local/ai_local.dart';
import '../../../core/ai_local/widgets/ai_bottom_sheet.dart';

/// Emergency Mode Screen - Fitur unggulan SAFECORE
/// Layar penuh, teks besar, satu langkah per layar, navigasi sederhana
class EmergencyView extends StatefulWidget {
  final String? emergencyId;

  const EmergencyView({super.key, this.emergencyId});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  final AiController aiController = Get.find<AiController>();
  int currentStepIndex = 0;

  // MARK: Protocol Data

  late final EmergencyProtocol protocol;

  @override
  void initState() {
    super.initState();
    // Load protocol based on ID, fallback to earthquake
    protocol = _getProtocol(widget.emergencyId ?? 'earthquake');
  }

  EmergencyProtocol _getProtocol(String id) {
    if (id == 'earthquake') {
      return EmergencyProtocol(
        title: 'DARURAT GEMPA',
        steps: [
          EmergencyStep(
            instruction: 'TETAP TENANG.\nJangan panik dan jangan berlari keluar.',
            icon: FontAwesomeIcons.circleExclamation,
          ),
          EmergencyStep(
            instruction: 'DROP!\nBerlutut di tangan dan lutut Anda.',
            icon: FontAwesomeIcons.personWalking,
          ),
          EmergencyStep(
            instruction: 'COVER!\nLindungi kepala dan leher di bawah meja yang kokoh.',
            icon: FontAwesomeIcons.houseUser,
          ),
          EmergencyStep(
            instruction: 'HOLD ON!\nPegangan pada kaki meja sampai getaran berhenti.',
            icon: FontAwesomeIcons.handBackFist,
          ),
          EmergencyStep(
            instruction: 'JAUHI JENDELA!\nHindari kaca, lampu gantung, atau benda yang bisa jatuh.',
            icon: FontAwesomeIcons.rectangleXmark,
          ),
          EmergencyStep(
            instruction: 'TUNGGU AMAN.\nSetelah getaran berhenti, evakuasi melalui tangga.',
            icon: FontAwesomeIcons.stairs,
          ),
        ],
        completionMessage: 'Anda telah menyelesaikan langkah darurat awal. Tetap waspada gempa susulan.',
      );
    }
    // Fallback simple protocol
    return EmergencyProtocol(
      title: 'DARURAT',
      steps: [
        EmergencyStep(
          instruction: 'Pastikan lingkungan sekitar Anda aman.',
          icon: FontAwesomeIcons.eye,
        ),
        EmergencyStep(
          instruction: 'Hubungi layanan darurat jika diperlukan.',
          icon: Icons.error, // Placeholder: Original was FaIconData, replaced with IconData. Adjust as needed.
        ),
      ],
      completionMessage: 'Tetap tenang dan tunggu bantuan.',
    );
  }

  // MARK: Logic

  void _nextStep() {
    if (currentStepIndex < protocol.steps.length - 1) {
      setState(() {
        currentStepIndex++;
      });
    } else {
      _finish();
    }
  }

  void _previousStep() {
    if (currentStepIndex > 0) {
      setState(() {
        currentStepIndex--;
      });
    }
  }

  void _finish() {
    Get.back();
    Get.snackbar(
      'Protokol Selesai',
      protocol.completionMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successGreen,
      colorText: AppColors.lightText,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final step = protocol.steps[currentStepIndex];
    final isLastStep = currentStepIndex == protocol.steps.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header: Title & Step Indicator
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  AppText.body2(
                    protocol.title,
                    color: AppColors.emergencyRed,
                    emphasized: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      protocol.steps.length,
                      (index) => Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index <= currentStepIndex
                              ? AppColors.emergencyRed
                              : AppColors.darkSurfaceVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppText.body3(
                    'Langkah ${currentStepIndex + 1} dari ${protocol.steps.length}',
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
            ),

            // Content: Large Instruction & Icon
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (step.icon != null) ...[
                      FaIcon(
                        step.icon,
                        size: 100,
                        color: AppColors.lightText,
                      ),
                      const SizedBox(height: 48),
                    ],
                    AppText.h2(
                      step.instruction,
                      textAlign: TextAlign.center,
                      color: AppColors.lightText,
                    ),
                  ],
                ),
              ),
            ),

            // AI Helper Button (Secondary)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextButton.icon(
                onPressed: () {
                  aiController.setAiContext(
                    disasterType: widget.emergencyId ?? 'earthquake',
                    currentStep: currentStepIndex + 1,
                    totalSteps: protocol.steps.length,
                    currentStepInstruction: step.instruction,
                  );
                  Get.bottomSheet<String>(
                    AiBottomSheet(
                      autoLoadModel: true,
                    ),
                    backgroundColor: const Color(0xFF2C2C2E),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                  );
                },
                icon: FaIcon(FontAwesomeIcons.robot, size: 16),
                label: const Text('Bantuan AI'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.infoBlue,
                ),
              ),
            ),

            // Navigation Buttons (Primary)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (currentStepIndex > 0)
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: AppButton(
                          text: 'KEMBALI',
                          onPressed: _previousStep,
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.secondaryText,
                          outlineColor: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 2,
                    child: AppButton(
                      text: isLastStep ? 'SELESAI' : 'LANJUT',
                      onPressed: _nextStep,
                      backgroundColor: isLastStep ? AppColors.successGreen : AppColors.emergencyRed,
                      textColor: AppColors.lightText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MARK: Models

class EmergencyProtocol {
  final String title;
  final List<EmergencyStep> steps;
  final String completionMessage;

  const EmergencyProtocol({
    required this.title,
    required this.steps,
    required this.completionMessage,
  });
}

class EmergencyStep {
  final String instruction;
  final dynamic icon; // Changed to dynamic to accept FaIconData and IconData

  const EmergencyStep({
    required this.instruction,
    this.icon,
  });
}

