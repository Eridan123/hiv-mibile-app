import 'package:HIVApp/pages/basic_information/basic_information.dart';
import 'package:HIVApp/pages/choose_language/choose_language.dart';
import 'package:HIVApp/pages/choose_registration/choose_registration.dart';
import 'package:HIVApp/pages/consultation/consultant_contacts.dart';
import 'package:HIVApp/pages/consultation/consultation.dart';
import 'package:HIVApp/pages/diary/diary_page.dart';
import 'package:HIVApp/pages/information_on%20_arv/schema_page.dart';
import 'package:HIVApp/pages/language/change_laguage_page.dart';
import 'package:HIVApp/pages/my_state/mood/mood_page.dart';
import 'package:HIVApp/pages/my_state/my_state.dart';
import 'package:HIVApp/pages/my_state/symptom/symptom_page.dart';
import 'package:HIVApp/pages/school/school_page.dart';
import 'package:HIVApp/pages/visit/visit_add_page.dart';
import 'package:HIVApp/pages/visit/visit_page.dart';
import 'package:HIVApp/pages/settings/widgets/reset_password.dart';
import 'package:HIVApp/pages/signup/pin_code.dart';
import 'package:HIVApp/pages/signup/questionary.dart';
import 'package:HIVApp/pages/signup/questionnaire.dart';
import 'package:HIVApp/pages/signup/successful_registration.dart';
import 'package:HIVApp/pages/test/test_information_page.dart';
import 'package:HIVApp/pages/test/test_page.dart';
import 'package:HIVApp/pages/treatment/treatment_page.dart';
import 'package:HIVApp/pages/pin_code_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/forgot/forgot_password_page.dart';
import '../pages/home/home.dart';
import '../pages/add/add_page.dart';
import '../pages/login/login_page.dart';
import '../pages/signup/signup_page.dart';
import '../pages/splash_page.dart';
import 'routes.dart';

import 'package:easy_localization/easy_localization.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());

      case Routes.signup:
        return CupertinoPageRoute(builder: (_) => SignupPage());

      case Routes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => ForgotPasswordPage());

      case Routes.chooseLanguage:
        return CupertinoPageRoute(builder: (_) => ChooseLanguagePage());

      case Routes.chooseRegistration:
        return CupertinoPageRoute(builder: (_) => ChooseRegistrationPage());

      case Routes.questionnaire:
        return CupertinoPageRoute(builder: (_) => QuestionnairePage());

      case Routes.questionary:
        return CupertinoPageRoute(builder: (_) => Questionary());

      case Routes.successfull_registration:
        return CupertinoPageRoute(builder: (_) => SuccessfullRegistrationPage());

      case Routes.pin_code:
        return CupertinoPageRoute(builder: (_) => PinCodePage());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => Home());

      case Routes.basic_information:
        return CupertinoPageRoute(builder: (_) => BasicInformationPage());

      case Routes.test:
        return CupertinoPageRoute(builder: (_) => TestPage());

      case Routes.test_information:
        return CupertinoPageRoute(builder: (_) => TestInformationPage());

      case Routes.treatment:
        return CupertinoPageRoute(builder: (_) => TreatmentPage());

      case Routes.consultation:
        return CupertinoPageRoute(builder: (_) => ConsultationPage());

      case Routes.consultant_contact:
        return CupertinoPageRoute(builder: (_) => ConsultantContactPage());

      case Routes.schema_of_arv:
        return CupertinoPageRoute(builder: (_) => SchemaPage());

      case Routes.changeLanguage:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case Routes.my_state:
        return CupertinoPageRoute(builder: (_) => MyStatePage());

      case Routes.diary:
        return CupertinoPageRoute(builder: (_) => DiaryPage());

      case Routes.add:
        return CupertinoPageRoute(builder: (_) => AddPage());

      case Routes.resetPassword:
        return CupertinoPageRoute(builder: (_) => ResetPasswordPage());

      case Routes.symptom:
        return CupertinoPageRoute(builder: (_) => SymptomPage());

      case Routes.mood:
        return CupertinoPageRoute(builder: (_) => MoodPage());

      case Routes.visit_doctor:
        return CupertinoPageRoute(builder: (_) => VisitPage());

      case Routes.visit_add:
        return CupertinoPageRoute(builder: (_) => VisitAddPage());

      case Routes.pin_code_screen:
        return CupertinoPageRoute(builder: (_) => PinCodeInputPage());

      case Routes.school:
        return CupertinoPageRoute(builder: (_) => SchoolPage());

      case Routes.error:
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('new_page'.tr()),
        ),
        body: Center(
          child: Text('new_page'.tr()),
        ),
      );
    });
  }
}
