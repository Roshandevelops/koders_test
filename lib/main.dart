import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/dependency_injection.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/post_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final loginUseCase = await DependencyInjection.provideLoginUseCase();
  final logoutUseCase = await DependencyInjection.provideLogoutUseCase();
  final getCurrentUserUseCase =
      await DependencyInjection.provideGetCurrentUserUseCase();
  final getPostsUseCase = DependencyInjection.provideGetPostsUseCase();
  final getPostByIdUseCase = DependencyInjection.provideGetPostByIdUseCase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUseCase,
            logoutUseCase: logoutUseCase,
            getCurrentUserUseCase: getCurrentUserUseCase,
          )..checkAuthStatus(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostProvider(
            getPostsUseCase: getPostsUseCase,
            getPostByIdUseCase: getPostByIdUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koders Test App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.status == AuthStatus.initial ||
              authProvider.status == AuthStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (authProvider.isAuthenticated) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
