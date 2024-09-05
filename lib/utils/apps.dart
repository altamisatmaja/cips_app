part of 'util.dart';

class CIPSMaterialApp {
  static MaterialApp get theme => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
        theme: CIPSThemeDatas.theme,
      );
}
