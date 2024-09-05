import 'package:cips_app/data/blocs/bloc.dart';
import 'package:cips_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(providers: [
      BlocProvider<HomeScreenBloc>(
        create: (context) {
          final bloc = HomeScreenBloc();
          bloc.add(SetHomeScreenState());
          return bloc;
        },
      ),
    ], child: CIPSMaterialApp.theme);
  }
}
