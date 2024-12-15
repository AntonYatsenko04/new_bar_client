import 'package:flutter/material.dart';

abstract class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  const AppColorsTheme({
    required this.informationButtonBackground,
    required this.background,
    required this.profileBackground,
    required this.primary,
    required this.error,
    required this.activeIndicator,
    required this.separator,
    required this.transparent,
    required this.gradient,
    required this.toastSuccessForeground,
    required this.shadow,
    required this.informationToastBackground,
    required this.textColor,
    required this.textHint,
    required this.textSecondary,
    required this.secondaryButtonBackground,
    required this.secondaryButtonActiveBackground,
    required this.secondaryButtonDisabledBackground,
    required this.secondaryButtonForeground,
    required this.secondaryButtonDisabledForeground,
    required this.outlinedButtonForeground,
    required this.outlinedButtonPressedForeground,
    required this.outlinedButtonDisabledForeground,
    required this.textButtonForeground,
    required this.textButtonPressedColor,
    required this.textButtonDisabledColor,
    required this.textButtonOverlay,
    required this.filledButtonBackground,
    required this.filledButtonForeground,
    required this.filledButtonActiveBackground,
    required this.filledButtonDisabledBackground,
    required this.dialogBackground,
    required this.dialogContentText,
    required this.profileUserIconBackground,
    required this.profileGuestIconBackground,
    required this.profileSecondaryText,
    required this.toastForeground,
    required this.toastSuccessBackground,
    required this.toastErrorBackground,
    required this.toastErrorForeground,
    required this.bottomBarBackground,
    required this.bottomBarShadow,
    required this.bottomBarTabIcon,
    required this.bottomBarTabIconBackground,
    required this.bottomBarTabActiveIcon,
    required this.bottomBarTabActiveIconBackground,
    required this.onboardingTextContent,
    required this.filledTextFieldBackground,
    required this.questionnaireSelected,
    required this.questionnaireNotSelected,
    required this.questionnaireOptionText,
    required this.photoBackground,
    required this.linearProgressIndicatorForeground,
    required this.linearProgressIndicatorBackground,
    required this.homeDiagnosisButtonBackground,
    required this.homeDiagnosisButtonPressed,
    required this.homeDiagnosisButtonDisabled,
    required this.homeDiagnosisButtonForeground,
    required this.homeDiagnosisButtonPressedForeground,
    required this.homeDiagnosisButtonDisabledForeground,
    required this.diagnosisMainCardText,
    required this.diagnosisMainCardSecondary,
    required this.diagnosisMainCardPrimary,
    required this.diagnosisCardText,
    required this.diagnosisCardSecondaryText,
    required this.diagnosisCardBackground,
    required this.diagnosisCardShadow,
    required this.resultDisclaimerText,
    required this.diagnosisDetailsSectionTitle,
    required this.diagnosisDetailsClinicsItemTitle,
    required this.diagnosisDetailsTextButton,
    required this.myDiagnosesFilterBackground,
    required this.myDiagnosesDateFieldBorder,
    required this.myDiagnosesDateRangeBackground,
  });

  // Common
  final Color background;
  final Color primary;
  final Color error;
  final Color shadow;
  final Color activeIndicator;
  final Color separator;
  final Color transparent;
  final List<Color> gradient;

  // Information
  final Color informationButtonBackground;
  final Color informationToastBackground;

  // Text
  final Color textColor;
  final Color textHint;
  final Color textSecondary;

  // Secondary button
  final Color secondaryButtonBackground;
  final Color secondaryButtonActiveBackground;
  final Color secondaryButtonDisabledBackground;
  final Color secondaryButtonForeground;
  final Color secondaryButtonDisabledForeground;

  // Outlined button
  final Color outlinedButtonForeground;
  final Color outlinedButtonPressedForeground;
  final Color outlinedButtonDisabledForeground;

  // Text button
  final Color textButtonForeground;
  final Color textButtonPressedColor;
  final Color textButtonDisabledColor;
  final Color textButtonOverlay;

  // Filled button
  final Color filledButtonBackground;
  final Color filledButtonForeground;
  final Color filledButtonActiveBackground;
  final Color filledButtonDisabledBackground;

  // Dialog
  final Color dialogBackground;
  final Color dialogContentText;

  // Profile
  final Color profileBackground;
  final Color profileUserIconBackground;
  final Color profileGuestIconBackground;
  final Color profileSecondaryText;

  // Toast
  final Color toastForeground;
  final Color toastSuccessBackground;
  final Color toastSuccessForeground;
  final Color toastErrorBackground;
  final Color toastErrorForeground;

  // Bottom bar
  final Color bottomBarBackground;
  final Color bottomBarShadow;
  final Color bottomBarTabIcon;
  final Color bottomBarTabIconBackground;
  final Color bottomBarTabActiveIcon;
  final Color bottomBarTabActiveIconBackground;

  // Onboarding
  final Color onboardingTextContent;

  // Filled text field
  final Color filledTextFieldBackground;

  // Questionnaire
  final Color questionnaireSelected;
  final Color questionnaireNotSelected;
  final Color questionnaireOptionText;

  // Photo upload
  final Color photoBackground;

  // Linear progress indicator
  final Color linearProgressIndicatorForeground;
  final Color linearProgressIndicatorBackground;

  // Home diagnosis button
  final Color homeDiagnosisButtonBackground;
  final Color homeDiagnosisButtonPressed;
  final Color homeDiagnosisButtonDisabled;
  final Color homeDiagnosisButtonForeground;
  final Color homeDiagnosisButtonPressedForeground;
  final Color homeDiagnosisButtonDisabledForeground;

  // Diagnosis main card
  final Color diagnosisMainCardText;
  final Color diagnosisMainCardSecondary;
  final Color diagnosisMainCardPrimary;

  // Diagnosis card
  final Color diagnosisCardText;
  final Color diagnosisCardSecondaryText;
  final Color diagnosisCardBackground;
  final Color diagnosisCardShadow;

  // Result
  final Color resultDisclaimerText;

  // Diagnosis details
  final Color diagnosisDetailsSectionTitle;
  final Color diagnosisDetailsClinicsItemTitle;
  final Color diagnosisDetailsTextButton;

  // My diagnoses
  final Color myDiagnosesFilterBackground;
  final Color myDiagnosesDateFieldBorder;
  final Color myDiagnosesDateRangeBackground;

  @override
  ThemeExtension<AppColorsTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    covariant ThemeExtension<AppColorsTheme>? other,
    double t,
  ) {
    return this;
  }
}
