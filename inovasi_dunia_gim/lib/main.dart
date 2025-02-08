import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inovasi_dunia_gim/src/home/presentation/bloc/schedules/schedules_bloc.dart';
import 'core/route/routes.dart';
import 'core/utils/notification_api.dart';
import 'package:timezone/data/latest_all.dart' as tz;
//ha

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MainApp());
  NotificationApi.init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SchedulesBloc(),
        child: MaterialApp(
          onGenerateRoute: generateRoute,
          theme: ThemeData(
              // fontFamily: GoogleFonts.roboto().fontFamily,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          debugShowCheckedModeBanner: false,
        ));
  }
}
