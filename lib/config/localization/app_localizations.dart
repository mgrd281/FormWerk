import 'package:flutter/material.dart';

/// App localization support for German (primary) and Arabic (secondary)
/// This provides a runtime localization system that works alongside
/// Flutter's gen-l10n tooling.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('de'), // German – default
    Locale('ar'), // Arabic – RTL
  ];

  // ─── Lookup Map ─────────────────────────────────────────────
  static const Map<String, Map<String, String>> _localizedValues = {
    'de': _deValues,
    'ar': _arValues,
  };

  String _t(String key) => _localizedValues[locale.languageCode]?[key] ?? key;

  // ─── General ────────────────────────────────────────────────
  String get appName => _t('appName');
  String get ok => _t('ok');
  String get cancel => _t('cancel');
  String get save => _t('save');
  String get delete => _t('delete');
  String get edit => _t('edit');
  String get done => _t('done');
  String get next => _t('next');
  String get back => _t('back');
  String get skip => _t('skip');
  String get confirm => _t('confirm');
  String get close => _t('close');
  String get retry => _t('retry');
  String get loading => _t('loading');
  String get error => _t('error');
  String get success => _t('success');
  String get yes => _t('yes');
  String get no => _t('no');

  // ─── Splash ─────────────────────────────────────────────────
  String get splashSubtitle => _t('splashSubtitle');

  // ─── Onboarding ─────────────────────────────────────────────
  String get onboardingWelcomeTitle => _t('onboardingWelcomeTitle');
  String get onboardingWelcomeSubtitle => _t('onboardingWelcomeSubtitle');
  String get onboardingGoalTitle => _t('onboardingGoalTitle');
  String get onboardingGoalSubtitle => _t('onboardingGoalSubtitle');
  String get onboardingDetailsTitle => _t('onboardingDetailsTitle');
  String get onboardingDetailsSubtitle => _t('onboardingDetailsSubtitle');
  String get onboardingActivityTitle => _t('onboardingActivityTitle');
  String get onboardingActivitySubtitle => _t('onboardingActivitySubtitle');
  String get onboardingReadyTitle => _t('onboardingReadyTitle');
  String get onboardingReadySubtitle => _t('onboardingReadySubtitle');
  String get onboardingStart => _t('onboardingStart');

  // ─── Goals ──────────────────────────────────────────────────
  String get goalLose => _t('goalLose');
  String get goalMaintain => _t('goalMaintain');
  String get goalGain => _t('goalGain');

  // ─── Activity Levels ────────────────────────────────────────
  String get activitySedentary => _t('activitySedentary');
  String get activityLight => _t('activityLight');
  String get activityModerate => _t('activityModerate');
  String get activityActive => _t('activityActive');
  String get activityVeryActive => _t('activityVeryActive');

  // ─── Auth ───────────────────────────────────────────────────
  String get loginTitle => _t('loginTitle');
  String get loginSubtitle => _t('loginSubtitle');
  String get signupTitle => _t('signupTitle');
  String get signupSubtitle => _t('signupSubtitle');
  String get email => _t('email');
  String get password => _t('password');
  String get confirmPassword => _t('confirmPassword');
  String get forgotPassword => _t('forgotPassword');
  String get resetPassword => _t('resetPassword');
  String get login => _t('login');
  String get signup => _t('signup');
  String get loginWithGoogle => _t('loginWithGoogle');
  String get loginWithApple => _t('loginWithApple');
  String get continueAsGuest => _t('continueAsGuest');
  String get noAccount => _t('noAccount');
  String get haveAccount => _t('haveAccount');
  String get resetPasswordSent => _t('resetPasswordSent');
  String get emailRequired => _t('emailRequired');
  String get emailInvalid => _t('emailInvalid');
  String get passwordRequired => _t('passwordRequired');
  String get passwordTooShort => _t('passwordTooShort');
  String get passwordsDontMatch => _t('passwordsDontMatch');
  String get logout => _t('logout');
  String get logoutConfirm => _t('logoutConfirm');

  // ─── Home Dashboard ─────────────────────────────────────────
  String get homeTitle => _t('homeTitle');
  String get currentWeight => _t('currentWeight');
  String get targetWeight => _t('targetWeight');
  String get remaining => _t('remaining');
  String get bmi => _t('bmi');
  String get dailyCalories => _t('dailyCalories');
  String get consumed => _t('consumed');
  String get waterIntake => _t('waterIntake');
  String get workoutSummary => _t('workoutSummary');
  String get habitsProgress => _t('habitsProgress');
  String get weeklySnapshot => _t('weeklySnapshot');
  String get motivationalInsight => _t('motivationalInsight');
  String get addWeight => _t('addWeight');
  String get addMeal => _t('addMeal');
  String get addWater => _t('addWater');
  String get addWorkout => _t('addWorkout');
  String get addMeasurement => _t('addMeasurement');
  String get goodMorning => _t('goodMorning');
  String get goodAfternoon => _t('goodAfternoon');
  String get goodEvening => _t('goodEvening');
  String get todaySummary => _t('todaySummary');

  // ─── Weight ─────────────────────────────────────────────────
  String get weightLog => _t('weightLog');
  String get weightHistory => _t('weightHistory');
  String get weightCharts => _t('weightCharts');
  String get weightEntry => _t('weightEntry');
  String get weightDate => _t('weightDate');
  String get weightNote => _t('weightNote');
  String get weeklyAverage => _t('weeklyAverage');
  String get monthlyAverage => _t('monthlyAverage');
  String get progressPercentage => _t('progressPercentage');
  String get trendChart => _t('trendChart');
  String get targetProjection => _t('targetProjection');
  String get milestone => _t('milestone');
  String get deleteWeightConfirm => _t('deleteWeightConfirm');
  String get kg => _t('kg');
  String get lbs => _t('lbs');

  // ─── Measurements ───────────────────────────────────────────
  String get measurements => _t('measurements');
  String get addMeasurementTitle => _t('addMeasurementTitle');
  String get waist => _t('waist');
  String get chest => _t('chest');
  String get hips => _t('hips');
  String get arms => _t('arms');
  String get thighs => _t('thighs');
  String get neck => _t('neck');
  String get bodyFat => _t('bodyFat');
  String get cm => _t('cm');
  String get percent => _t('percent');
  String get measurementHistory => _t('measurementHistory');
  String get comparisonChart => _t('comparisonChart');
  String get changeIndicator => _t('changeIndicator');

  // ─── Meals ──────────────────────────────────────────────────
  String get meals => _t('meals');
  String get addMealTitle => _t('addMealTitle');
  String get breakfast => _t('breakfast');
  String get lunch => _t('lunch');
  String get dinner => _t('dinner');
  String get snacks => _t('snacks');
  String get mealName => _t('mealName');
  String get calories => _t('calories');
  String get protein => _t('protein');
  String get carbs => _t('carbs');
  String get fat => _t('fat');
  String get favoriteMeals => _t('favoriteMeals');
  String get customMeal => _t('customMeal');
  String get caloriesSummary => _t('caloriesSummary');
  String get macronutrients => _t('macronutrients');
  String get kcal => _t('kcal');
  String get g => _t('g');

  // ─── Water ──────────────────────────────────────────────────
  String get waterTracking => _t('waterTracking');
  String get addWaterTitle => _t('addWaterTitle');
  String get waterGoal => _t('waterGoal');
  String get ml => _t('ml');
  String get glass => _t('glass');
  String get glassOfWater => _t('glassOfWater');

  // ─── Workouts ───────────────────────────────────────────────
  String get workouts => _t('workouts');
  String get addWorkoutTitle => _t('addWorkoutTitle');
  String get walking => _t('walking');
  String get running => _t('running');
  String get strength => _t('strength');
  String get cycling => _t('cycling');
  String get homeWorkout => _t('homeWorkout');
  String get other => _t('other');
  String get duration => _t('duration');
  String get caloriesBurned => _t('caloriesBurned');
  String get workoutNotes => _t('workoutNotes');
  String get weeklySummary => _t('weeklySummary');
  String get minutes => _t('minutes');

  // ─── Habits ─────────────────────────────────────────────────
  String get habits => _t('habits');
  String get drinkWater => _t('drinkWater');
  String get walk => _t('walk');
  String get noSugaryDrinks => _t('noSugaryDrinks');
  String get sleepEarly => _t('sleepEarly');
  String get workoutHabit => _t('workoutHabit');
  String get streak => _t('streak');
  String get completionRate => _t('completionRate');
  String get days => _t('days');
  String get today => _t('today');
  String get completed => _t('completed');
  String get notCompleted => _t('notCompleted');

  // ─── Analytics ──────────────────────────────────────────────
  String get analytics => _t('analytics');
  String get weightTrend => _t('weightTrend');
  String get calorieTrend => _t('calorieTrend');
  String get waterTrend => _t('waterTrend');
  String get habitTrend => _t('habitTrend');
  String get weeklyReport => _t('weeklyReport');
  String get monthlyReport => _t('monthlyReport');
  String get goalForecast => _t('goalForecast');
  String get insights => _t('insights');

  // ─── Profile & Settings ─────────────────────────────────────
  String get profile => _t('profile');
  String get editProfile => _t('editProfile');
  String get settings => _t('settings');
  String get language => _t('language');
  String get theme => _t('theme');
  String get lightTheme => _t('lightTheme');
  String get darkTheme => _t('darkTheme');
  String get systemTheme => _t('systemTheme');
  String get notifications => _t('notifications');
  String get units => _t('units');
  String get metric => _t('metric');
  String get imperial => _t('imperial');
  String get about => _t('about');
  String get privacyPolicy => _t('privacyPolicy');
  String get termsConditions => _t('termsConditions');
  String get version => _t('version');
  String get german => _t('german');
  String get arabic => _t('arabic');
  String get gender => _t('gender');
  String get male => _t('male');
  String get female => _t('female');
  String get age => _t('age');
  String get height => _t('height');
  String get dietaryPreference => _t('dietaryPreference');
  String get reminderSettings => _t('reminderSettings');

  // ─── Notifications ──────────────────────────────────────────
  String get weightReminder => _t('weightReminder');
  String get waterReminder => _t('waterReminder');
  String get mealReminder => _t('mealReminder');
  String get workoutReminder => _t('workoutReminder');
  String get motivationReminder => _t('motivationReminder');
  String get streakReminder => _t('streakReminder');

  // ─── Insights ───────────────────────────────────────────────
  String get insightProgressing => _t('insightProgressing');
  String get insightPlateau => _t('insightPlateau');
  String get insightCloseTarget => _t('insightCloseTarget');
  String get insightStreakImproving => _t('insightStreakImproving');
  String get insightWaterLow => _t('insightWaterLow');

  // ─── BMI Categories ─────────────────────────────────────────
  String get bmiUnderweight => _t('bmiUnderweight');
  String get bmiNormal => _t('bmiNormal');
  String get bmiOverweight => _t('bmiOverweight');
  String get bmiObese => _t('bmiObese');

  // ─── Empty States ───────────────────────────────────────────
  String get noWeightsYet => _t('noWeightsYet');
  String get noMealsYet => _t('noMealsYet');
  String get noWorkoutsYet => _t('noWorkoutsYet');
  String get noMeasurementsYet => _t('noMeasurementsYet');
  String get noHabitsYet => _t('noHabitsYet');

  // ─── Navigation ─────────────────────────────────────────────
  String get navHome => _t('navHome');
  String get navProgress => _t('navProgress');
  String get navLog => _t('navLog');
  String get navHabits => _t('navHabits');
  String get navProfile => _t('navProfile');

  // ─── German Values ──────────────────────────────────────────
  static const Map<String, String> _deValues = {
    'appName': 'GewichtsKompass',
    'ok': 'OK',
    'cancel': 'Abbrechen',
    'save': 'Speichern',
    'delete': 'Löschen',
    'edit': 'Bearbeiten',
    'done': 'Fertig',
    'next': 'Weiter',
    'back': 'Zurück',
    'skip': 'Überspringen',
    'confirm': 'Bestätigen',
    'close': 'Schließen',
    'retry': 'Erneut versuchen',
    'loading': 'Laden...',
    'error': 'Fehler',
    'success': 'Erfolg',
    'yes': 'Ja',
    'no': 'Nein',
    'splashSubtitle': 'Dein Weg zu einem gesunden Gewicht',
    'onboardingWelcomeTitle': 'Willkommen bei GewichtsKompass',
    'onboardingWelcomeSubtitle': 'Dein persönlicher Begleiter für ein gesundes Gewicht. Verliere, halte oder erreiche dein Wohlfühlgewicht – elegant und motivierend.',
    'onboardingGoalTitle': 'Was ist dein Ziel?',
    'onboardingGoalSubtitle': 'Wähle dein persönliches Ziel. Wir passen alles optimal für dich an.',
    'onboardingDetailsTitle': 'Über dich',
    'onboardingDetailsSubtitle': 'Ein paar Angaben, damit wir dein Erlebnis personalisieren können.',
    'onboardingActivityTitle': 'Dein Aktivitätslevel',
    'onboardingActivitySubtitle': 'Wie aktiv bist du im Alltag?',
    'onboardingReadyTitle': 'Du bist bereit!',
    'onboardingReadySubtitle': 'Alles ist eingerichtet. Lass uns gemeinsam dein Ziel erreichen.',
    'onboardingStart': 'Loslegen',
    'goalLose': 'Abnehmen',
    'goalMaintain': 'Halten',
    'goalGain': 'Zunehmen',
    'activitySedentary': 'Sitzen',
    'activityLight': 'Leicht aktiv',
    'activityModerate': 'Mäßig aktiv',
    'activityActive': 'Aktiv',
    'activityVeryActive': 'Sehr aktiv',
    'loginTitle': 'Willkommen zurück',
    'loginSubtitle': 'Melde dich an, um fortzufahren',
    'signupTitle': 'Konto erstellen',
    'signupSubtitle': 'Starte deine Reise heute',
    'email': 'E-Mail',
    'password': 'Passwort',
    'confirmPassword': 'Passwort bestätigen',
    'forgotPassword': 'Passwort vergessen?',
    'resetPassword': 'Passwort zurücksetzen',
    'login': 'Anmelden',
    'signup': 'Registrieren',
    'loginWithGoogle': 'Mit Google anmelden',
    'loginWithApple': 'Mit Apple anmelden',
    'continueAsGuest': 'Als Gast fortfahren',
    'noAccount': 'Noch kein Konto?',
    'haveAccount': 'Bereits ein Konto?',
    'resetPasswordSent': 'E-Mail zum Zurücksetzen gesendet',
    'emailRequired': 'E-Mail ist erforderlich',
    'emailInvalid': 'Ungültige E-Mail-Adresse',
    'passwordRequired': 'Passwort ist erforderlich',
    'passwordTooShort': 'Passwort muss mind. 6 Zeichen haben',
    'passwordsDontMatch': 'Passwörter stimmen nicht überein',
    'logout': 'Abmelden',
    'logoutConfirm': 'Möchtest du dich wirklich abmelden?',
    'homeTitle': 'Übersicht',
    'currentWeight': 'Aktuelles Gewicht',
    'targetWeight': 'Zielgewicht',
    'remaining': 'Verbleibend',
    'bmi': 'BMI',
    'dailyCalories': 'Tägliche Kalorien',
    'consumed': 'Verzehrt',
    'waterIntake': 'Wasseraufnahme',
    'workoutSummary': 'Training',
    'habitsProgress': 'Gewohnheiten',
    'weeklySnapshot': 'Wochenübersicht',
    'motivationalInsight': 'Motivation',
    'addWeight': 'Gewicht',
    'addMeal': 'Mahlzeit',
    'addWater': 'Wasser',
    'addWorkout': 'Training',
    'addMeasurement': 'Messung',
    'goodMorning': 'Guten Morgen',
    'goodAfternoon': 'Guten Tag',
    'goodEvening': 'Guten Abend',
    'todaySummary': 'Heutige Übersicht',
    'weightLog': 'Gewicht eintragen',
    'weightHistory': 'Gewichtsverlauf',
    'weightCharts': 'Gewichtsdiagramme',
    'weightEntry': 'Gewichtseintrag',
    'weightDate': 'Datum',
    'weightNote': 'Notiz',
    'weeklyAverage': 'Wochendurchschnitt',
    'monthlyAverage': 'Monatsdurchschnitt',
    'progressPercentage': 'Fortschritt',
    'trendChart': 'Trenddiagramm',
    'targetProjection': 'Zielprojektion',
    'milestone': 'Meilenstein',
    'deleteWeightConfirm': 'Diesen Eintrag wirklich löschen?',
    'kg': 'kg',
    'lbs': 'lbs',
    'measurements': 'Körpermessungen',
    'addMeasurementTitle': 'Messung hinzufügen',
    'waist': 'Taille',
    'chest': 'Brust',
    'hips': 'Hüfte',
    'arms': 'Arme',
    'thighs': 'Oberschenkel',
    'neck': 'Hals',
    'bodyFat': 'Körperfett',
    'cm': 'cm',
    'percent': '%',
    'measurementHistory': 'Messungsverlauf',
    'comparisonChart': 'Vergleichsdiagramm',
    'changeIndicator': 'Änderung',
    'meals': 'Mahlzeiten',
    'addMealTitle': 'Mahlzeit hinzufügen',
    'breakfast': 'Frühstück',
    'lunch': 'Mittagessen',
    'dinner': 'Abendessen',
    'snacks': 'Snacks',
    'mealName': 'Name der Mahlzeit',
    'calories': 'Kalorien',
    'protein': 'Protein',
    'carbs': 'Kohlenhydrate',
    'fat': 'Fett',
    'favoriteMeals': 'Lieblingsmahlzeiten',
    'customMeal': 'Eigene Mahlzeit',
    'caloriesSummary': 'Kalorienübersicht',
    'macronutrients': 'Makronährstoffe',
    'kcal': 'kcal',
    'g': 'g',
    'waterTracking': 'Wassertracking',
    'addWaterTitle': 'Wasser hinzufügen',
    'waterGoal': 'Wasserziel',
    'ml': 'ml',
    'glass': 'Glas',
    'glassOfWater': 'Glas Wasser',
    'workouts': 'Workouts',
    'addWorkoutTitle': 'Workout hinzufügen',
    'walking': 'Gehen',
    'running': 'Laufen',
    'strength': 'Krafttraining',
    'cycling': 'Radfahren',
    'homeWorkout': 'Heimtraining',
    'other': 'Sonstiges',
    'duration': 'Dauer',
    'caloriesBurned': 'Kalorien verbrannt',
    'workoutNotes': 'Notizen',
    'weeklySummary': 'Wochenzusammenfassung',
    'minutes': 'Minuten',
    'habits': 'Gewohnheiten',
    'drinkWater': 'Wasser trinken',
    'walk': 'Spazieren',
    'noSugaryDrinks': 'Keine zuckerhaltigen Getränke',
    'sleepEarly': 'Früh schlafen',
    'workoutHabit': 'Trainieren',
    'streak': 'Serie',
    'completionRate': 'Erfüllungsrate',
    'days': 'Tage',
    'today': 'Heute',
    'completed': 'Erledigt',
    'notCompleted': 'Nicht erledigt',
    'analytics': 'Analytik',
    'weightTrend': 'Gewichtstrend',
    'calorieTrend': 'Kalorientrend',
    'waterTrend': 'Wassertrend',
    'habitTrend': 'Gewohnheitentrend',
    'weeklyReport': 'Wochenbericht',
    'monthlyReport': 'Monatsbericht',
    'goalForecast': 'Zielprognose',
    'insights': 'Einblicke',
    'profile': 'Profil',
    'editProfile': 'Profil bearbeiten',
    'settings': 'Einstellungen',
    'language': 'Sprache',
    'theme': 'Design',
    'lightTheme': 'Hell',
    'darkTheme': 'Dunkel',
    'systemTheme': 'System',
    'notifications': 'Benachrichtigungen',
    'units': 'Einheiten',
    'metric': 'Metrisch',
    'imperial': 'Imperial',
    'about': 'Über',
    'privacyPolicy': 'Datenschutz',
    'termsConditions': 'AGB',
    'version': 'Version',
    'german': 'Deutsch',
    'arabic': 'العربية',
    'gender': 'Geschlecht',
    'male': 'Männlich',
    'female': 'Weiblich',
    'age': 'Alter',
    'height': 'Größe',
    'dietaryPreference': 'Ernährungsweise',
    'reminderSettings': 'Erinnerungen',
    'weightReminder': 'Gewichtserinnerung',
    'waterReminder': 'Wassererinnerung',
    'mealReminder': 'Mahlzeiterinnerung',
    'workoutReminder': 'Trainingserinnerung',
    'motivationReminder': 'Motivationserinnerung',
    'streakReminder': 'Serien-Erinnerung',
    'insightProgressing': 'Du machst stetig Fortschritte!',
    'insightPlateau': 'Dein Gewicht stagniert zuletzt.',
    'insightCloseTarget': 'Du bist nah an deinem Ziel!',
    'insightStreakImproving': 'Deine Serie verbessert sich!',
    'insightWaterLow': 'Deine Wasseraufnahme ist unter dem Ziel.',
    'bmiUnderweight': 'Untergewicht',
    'bmiNormal': 'Normalgewicht',
    'bmiOverweight': 'Übergewicht',
    'bmiObese': 'Adipositas',
    'noWeightsYet': 'Noch keine Gewichtseinträge',
    'noMealsYet': 'Noch keine Mahlzeiten eingetragen',
    'noWorkoutsYet': 'Noch keine Workouts eingetragen',
    'noMeasurementsYet': 'Noch keine Messungen eingetragen',
    'noHabitsYet': 'Noch keine Gewohnheiten angelegt',
    'navHome': 'Start',
    'navProgress': 'Verlauf',
    'navLog': 'Eintragen',
    'navHabits': 'Gewohnheiten',
    'navProfile': 'Profil',
  };

  // ─── Arabic Values ──────────────────────────────────────────
  static const Map<String, String> _arValues = {
    'appName': 'بوصلة الوزن',
    'ok': 'حسناً',
    'cancel': 'إلغاء',
    'save': 'حفظ',
    'delete': 'حذف',
    'edit': 'تعديل',
    'done': 'تم',
    'next': 'التالي',
    'back': 'رجوع',
    'skip': 'تخطي',
    'confirm': 'تأكيد',
    'close': 'إغلاق',
    'retry': 'إعادة المحاولة',
    'loading': 'جاري التحميل...',
    'error': 'خطأ',
    'success': 'نجاح',
    'yes': 'نعم',
    'no': 'لا',
    'splashSubtitle': 'طريقك نحو وزن صحي',
    'onboardingWelcomeTitle': 'مرحباً بك في بوصلة الوزن',
    'onboardingWelcomeSubtitle': 'رفيقك الشخصي نحو وزن صحي. اخسر، حافظ أو حقق وزنك المثالي – بأناقة وتحفيز.',
    'onboardingGoalTitle': 'ما هدفك؟',
    'onboardingGoalSubtitle': 'اختر هدفك الشخصي. سنقوم بتخصيص كل شيء لك.',
    'onboardingDetailsTitle': 'عنك',
    'onboardingDetailsSubtitle': 'بعض المعلومات لتخصيص تجربتك.',
    'onboardingActivityTitle': 'مستوى نشاطك',
    'onboardingActivitySubtitle': 'ما مدى نشاطك في حياتك اليومية؟',
    'onboardingReadyTitle': 'أنت جاهز!',
    'onboardingReadySubtitle': 'كل شيء جاهز. لنصل إلى هدفك معاً.',
    'onboardingStart': 'لنبدأ',
    'goalLose': 'خسارة الوزن',
    'goalMaintain': 'الحفاظ',
    'goalGain': 'زيادة الوزن',
    'activitySedentary': 'قليل الحركة',
    'activityLight': 'نشاط خفيف',
    'activityModerate': 'نشاط معتدل',
    'activityActive': 'نشيط',
    'activityVeryActive': 'نشيط جداً',
    'loginTitle': 'مرحباً بعودتك',
    'loginSubtitle': 'سجّل الدخول للمتابعة',
    'signupTitle': 'إنشاء حساب',
    'signupSubtitle': 'ابدأ رحلتك اليوم',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'confirmPassword': 'تأكيد كلمة المرور',
    'forgotPassword': 'نسيت كلمة المرور؟',
    'resetPassword': 'إعادة تعيين كلمة المرور',
    'login': 'تسجيل الدخول',
    'signup': 'إنشاء حساب',
    'loginWithGoogle': 'تسجيل الدخول بحساب Google',
    'loginWithApple': 'تسجيل الدخول بحساب Apple',
    'continueAsGuest': 'المتابعة كضيف',
    'noAccount': 'ليس لديك حساب؟',
    'haveAccount': 'لديك حساب بالفعل؟',
    'resetPasswordSent': 'تم إرسال بريد إعادة التعيين',
    'emailRequired': 'البريد الإلكتروني مطلوب',
    'emailInvalid': 'بريد إلكتروني غير صالح',
    'passwordRequired': 'كلمة المرور مطلوبة',
    'passwordTooShort': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
    'passwordsDontMatch': 'كلمات المرور غير متطابقة',
    'logout': 'تسجيل الخروج',
    'logoutConfirm': 'هل تريد تسجيل الخروج فعلاً؟',
    'homeTitle': 'نظرة عامة',
    'currentWeight': 'الوزن الحالي',
    'targetWeight': 'الوزن المستهدف',
    'remaining': 'المتبقي',
    'bmi': 'مؤشر كتلة الجسم',
    'dailyCalories': 'السعرات اليومية',
    'consumed': 'المستهلكة',
    'waterIntake': 'شرب الماء',
    'workoutSummary': 'التمارين',
    'habitsProgress': 'العادات',
    'weeklySnapshot': 'نظرة أسبوعية',
    'motivationalInsight': 'تحفيز',
    'addWeight': 'الوزن',
    'addMeal': 'وجبة',
    'addWater': 'ماء',
    'addWorkout': 'تمرين',
    'addMeasurement': 'قياس',
    'goodMorning': 'صباح الخير',
    'goodAfternoon': 'مساء الخير',
    'goodEvening': 'مساء النور',
    'todaySummary': 'ملخص اليوم',
    'weightLog': 'تسجيل الوزن',
    'weightHistory': 'سجل الوزن',
    'weightCharts': 'رسوم الوزن',
    'weightEntry': 'إدخال الوزن',
    'weightDate': 'التاريخ',
    'weightNote': 'ملاحظة',
    'weeklyAverage': 'المتوسط الأسبوعي',
    'monthlyAverage': 'المتوسط الشهري',
    'progressPercentage': 'التقدم',
    'trendChart': 'رسم الاتجاه',
    'targetProjection': 'توقع الهدف',
    'milestone': 'إنجاز',
    'deleteWeightConfirm': 'هل تريد حذف هذا الإدخال فعلاً؟',
    'kg': 'كجم',
    'lbs': 'رطل',
    'measurements': 'قياسات الجسم',
    'addMeasurementTitle': 'إضافة قياس',
    'waist': 'الخصر',
    'chest': 'الصدر',
    'hips': 'الوركين',
    'arms': 'الذراعين',
    'thighs': 'الفخذين',
    'neck': 'الرقبة',
    'bodyFat': 'نسبة الدهون',
    'cm': 'سم',
    'percent': '٪',
    'measurementHistory': 'سجل القياسات',
    'comparisonChart': 'رسم المقارنة',
    'changeIndicator': 'التغيير',
    'meals': 'الوجبات',
    'addMealTitle': 'إضافة وجبة',
    'breakfast': 'فطور',
    'lunch': 'غداء',
    'dinner': 'عشاء',
    'snacks': 'وجبات خفيفة',
    'mealName': 'اسم الوجبة',
    'calories': 'السعرات',
    'protein': 'بروتين',
    'carbs': 'كربوهيدرات',
    'fat': 'دهون',
    'favoriteMeals': 'الوجبات المفضلة',
    'customMeal': 'وجبة مخصصة',
    'caloriesSummary': 'ملخص السعرات',
    'macronutrients': 'المغذيات الكبرى',
    'kcal': 'سعرة',
    'g': 'غ',
    'waterTracking': 'تتبع الماء',
    'addWaterTitle': 'إضافة ماء',
    'waterGoal': 'هدف الماء',
    'ml': 'مل',
    'glass': 'كوب',
    'glassOfWater': 'كوب ماء',
    'workouts': 'التمارين',
    'addWorkoutTitle': 'إضافة تمرين',
    'walking': 'مشي',
    'running': 'جري',
    'strength': 'تمارين قوة',
    'cycling': 'ركوب الدراجة',
    'homeWorkout': 'تمارين منزلية',
    'other': 'أخرى',
    'duration': 'المدة',
    'caloriesBurned': 'السعرات المحروقة',
    'workoutNotes': 'ملاحظات',
    'weeklySummary': 'ملخص الأسبوع',
    'minutes': 'دقائق',
    'habits': 'العادات',
    'drinkWater': 'شرب الماء',
    'walk': 'المشي',
    'noSugaryDrinks': 'بدون مشروبات سكرية',
    'sleepEarly': 'النوم مبكراً',
    'workoutHabit': 'التمرين',
    'streak': 'سلسلة',
    'completionRate': 'معدل الإنجاز',
    'days': 'أيام',
    'today': 'اليوم',
    'completed': 'مكتمل',
    'notCompleted': 'غير مكتمل',
    'analytics': 'التحليلات',
    'weightTrend': 'اتجاه الوزن',
    'calorieTrend': 'اتجاه السعرات',
    'waterTrend': 'اتجاه الماء',
    'habitTrend': 'اتجاه العادات',
    'weeklyReport': 'تقرير أسبوعي',
    'monthlyReport': 'تقرير شهري',
    'goalForecast': 'توقع الهدف',
    'insights': 'رؤى',
    'profile': 'الملف الشخصي',
    'editProfile': 'تعديل الملف',
    'settings': 'الإعدادات',
    'language': 'اللغة',
    'theme': 'المظهر',
    'lightTheme': 'فاتح',
    'darkTheme': 'داكن',
    'systemTheme': 'النظام',
    'notifications': 'الإشعارات',
    'units': 'الوحدات',
    'metric': 'متري',
    'imperial': 'إمبراطوري',
    'about': 'حول',
    'privacyPolicy': 'سياسة الخصوصية',
    'termsConditions': 'الشروط والأحكام',
    'version': 'الإصدار',
    'german': 'Deutsch',
    'arabic': 'العربية',
    'gender': 'الجنس',
    'male': 'ذكر',
    'female': 'أنثى',
    'age': 'العمر',
    'height': 'الطول',
    'dietaryPreference': 'النظام الغذائي',
    'reminderSettings': 'التذكيرات',
    'weightReminder': 'تذكير الوزن',
    'waterReminder': 'تذكير الماء',
    'mealReminder': 'تذكير الوجبات',
    'workoutReminder': 'تذكير التمارين',
    'motivationReminder': 'تذكير التحفيز',
    'streakReminder': 'تذكير السلسلة',
    'insightProgressing': 'أنت تحرز تقدماً مستمراً!',
    'insightPlateau': 'وزنك مستقر مؤخراً.',
    'insightCloseTarget': 'أنت قريب من هدفك!',
    'insightStreakImproving': 'سلسلتك تتحسن!',
    'insightWaterLow': 'شربك للماء أقل من الهدف.',
    'bmiUnderweight': 'نقص الوزن',
    'bmiNormal': 'وزن طبيعي',
    'bmiOverweight': 'زيادة الوزن',
    'bmiObese': 'سمنة',
    'noWeightsYet': 'لا توجد إدخالات وزن بعد',
    'noMealsYet': 'لا توجد وجبات مسجلة بعد',
    'noWorkoutsYet': 'لا توجد تمارين مسجلة بعد',
    'noMeasurementsYet': 'لا توجد قياسات مسجلة بعد',
    'noHabitsYet': 'لا توجد عادات بعد',
    'navHome': 'الرئيسية',
    'navProgress': 'التقدم',
    'navLog': 'تسجيل',
    'navHabits': 'العادات',
    'navProfile': 'الملف',
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['de', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}