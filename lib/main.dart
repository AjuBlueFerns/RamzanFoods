import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/utils/route/router.dart' as router;
import 'package:crocurry/utils/theme/app_theme.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/app_details/app_details_bloc.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/auth/auth_state.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/categories/category_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/orders/orders_bloc.dart';
import 'package:crocurry/views/bloc/products/product_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/search/search_bloc.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_bloc.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/validator/validator_bloc.dart';
import 'package:crocurry/views/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CarousalBloc>(create: (_) => CarousalBloc()),
          BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
          BlocProvider<SubcategoryBloc>(create: (_) => SubcategoryBloc()),
          BlocProvider<ProductBloc>(create: (_) => ProductBloc()),
          BlocProvider<AllProductsBloc>(create: (_) => AllProductsBloc()),
          BlocProvider<ScreenBloc>(create: (_) => ScreenBloc()),
          BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
          BlocProvider<QuantityBloc>(create: (_) => QuantityBloc()),
          BlocProvider<CartBloc>(create: (_) => CartBloc()),
          BlocProvider<UserBloc>(create: (_) => UserBloc()),
          BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
          BlocProvider<BookmarkBloc>(create: (_) => BookmarkBloc()),
          BlocProvider<OrdersBloc>(create: (_) => OrdersBloc()),
          BlocProvider<FilterBloc>(create: (_) => FilterBloc()),
          BlocProvider<AppDetailsBloc>(create: (_) => AppDetailsBloc()),
          BlocProvider<ValidatorBloc>(create: (_) => ValidatorBloc()),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Ramzan Foods',
              theme: AppTheme.lightTheme(context),
              themeMode: ThemeMode.light,
              onGenerateRoute: router.generateRoute,
              initialRoute: splashScreenRoute,
            ),
          );
        }),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
