import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:marketi/core/cubit/ui_cubit.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/services/localStorage/prefrence_manger.dart';
import 'package:marketi/core/services/stripe_payment/stripe_keys.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/feature/auth/domain/repo/auth_repo.dart';
import 'package:marketi/feature/auth/presentation/mangment/cubit/auth_cubit.dart';
import 'package:marketi/feature/cart/domain/repo/cart_repo.dart';
import 'package:marketi/feature/cart/presentation/mangement/cubit/cart_cubit.dart';
import 'package:marketi/feature/favorite/domain/repo/favorite_repo.dart';
import 'package:marketi/feature/favorite/presentation/mangement/cubit/favorite_cubit.dart';
import 'feature/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeKeys.publishableKey;
  await PreferenceManager.instance.init();

  getItSetUp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(getIt<CartRepo>())..getCart(),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteCubit(getIt<FavoriteRepo>())..getFavorite(),
        ),
        BlocProvider(create: (context) => UiCubit()),
        BlocProvider(create: (context) => AuthCubit(getIt<AuthRepo>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarThemeData(
            backgroundColor: AppStyle.background,
            titleTextStyle: AppStyle.title.copyWith(
              fontWeight: FontWeight.w500,
            ),
            centerTitle: true,
            actionsPadding: const EdgeInsets.only(right: 16),
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: AppStyle.background,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
