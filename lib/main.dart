import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pawfect_match/core/db/hive_pet_model.dart';
import 'package:pawfect_match/core/theme/app_theme.dart';
import 'package:pawfect_match/core/theme/theme_provider.dart';
import 'package:pawfect_match/features/bottomnavbar/base_screen.dart';
import 'package:pawfect_match/features/details/presentation/bloc/details_bloc.dart';
import 'package:pawfect_match/features/favourites/cubit/favourite_cubit.dart';
import 'package:pawfect_match/features/history/cubit/history_cubit.dart';
import 'package:pawfect_match/features/home/presentation/bloc/home_bloc.dart';
import 'package:pawfect_match/features/home/presentation/view/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive with correct directory
  await Hive.initFlutter();

  // Register your adapters here if needed
  Hive.registerAdapter(HivePetModelAdapter());
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
        BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(context.read<HomeBloc>()),
        ),
        BlocProvider<HistoryCubit>(create: (_) => HistoryCubit()),
        BlocProvider<FavouriteCubit>(create: (_) => FavouriteCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852), // iPhone 15 logical size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: const BaseScreen(),
          );
        },
      ),
    );
  }
}
