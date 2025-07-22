import 'package:crocurry/data/data_sources/auth/auth_local_datasource.dart';
import 'package:crocurry/data/data_sources/auth/auth_remote_datasource.dart';
import 'package:crocurry/data/data_sources/cart/cart_local_datasource.dart';
import 'package:crocurry/data/data_sources/cart/cart_remote_datasource.dart';
import 'package:crocurry/data/data_sources/order/order_remote_data_source.dart';
import 'package:crocurry/data/data_sources/product/product_local_datasource.dart';
import 'package:crocurry/data/data_sources/product/product_remote_datasource.dart';
import 'package:crocurry/data/data_sources/user/user_local_datasource.dart';
import 'package:crocurry/data/data_sources/user/user_remote_datasource.dart';
import 'package:crocurry/data/repository_impl/auth/auth_repository_impl.dart';
import 'package:crocurry/data/repository_impl/cart/cart_repository_impl.dart';
import 'package:crocurry/data/repository_impl/connectivity/connectivity_repo_impl.dart';
import 'package:crocurry/data/repository_impl/orders/orders_repository_impl.dart';
import 'package:crocurry/data/repository_impl/product/product_repository_impl.dart';
import 'package:crocurry/data/repository_impl/user/user_repository_impl.dart';
import 'package:crocurry/domain/repository/connectivity/connectivity_repository.dart';
import 'package:crocurry/domain/use_cases/auth/check_logged_in.dart';
import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
import 'package:crocurry/domain/use_cases/auth/update_logged_in_status.dart';
import 'package:crocurry/domain/use_cases/auth/verify_otp.dart';
import 'package:crocurry/domain/use_cases/cart/add_to_cart.dart';
import 'package:crocurry/domain/use_cases/cart/check_order_status.dart';
import 'package:crocurry/domain/use_cases/cart/clear_cart_id.dart';
import 'package:crocurry/domain/use_cases/cart/get_cart_id.dart';
import 'package:crocurry/domain/use_cases/cart/remove_from_cart.dart';
import 'package:crocurry/domain/use_cases/cart/update_qty.dart';
import 'package:crocurry/domain/use_cases/cart/view_cart.dart';
import 'package:crocurry/domain/use_cases/connectivity/check_connectivity_repo.dart';
import 'package:crocurry/domain/use_cases/orders/get_orders_list.dart';
import 'package:crocurry/domain/use_cases/product/add_bookmark.dart';
import 'package:crocurry/domain/use_cases/product/check_if_product_bookmarked.dart';
import 'package:crocurry/domain/use_cases/product/get_bookmarks.dart';
import 'package:crocurry/domain/use_cases/product/get_brands.dart';
import 'package:crocurry/domain/use_cases/product/get_carousal.dart';
import 'package:crocurry/domain/use_cases/product/get_categories.dart';
import 'package:crocurry/domain/use_cases/product/get_product_details.dart';
import 'package:crocurry/domain/use_cases/product/get_products.dart';
import 'package:crocurry/domain/use_cases/product/get_subcategories.dart';
import 'package:crocurry/domain/use_cases/product/remove_bookmark.dart';
import 'package:crocurry/domain/use_cases/user/clear_user_details.dart';
import 'package:crocurry/domain/use_cases/user/get_user_details_from_shared.dart';
import 'package:crocurry/domain/use_cases/user/save_user_details_shared_pref.dart';
import 'package:crocurry/domain/use_cases/user/update_user_details.dart';
import 'package:crocurry/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  var directory = await getApplicationDocumentsDirectory();
  final store = await openStore(
    directory: join(directory.path, 'objectbox1'),
  );
  locator.registerSingleton<Store>(store);

  /// remote-datasource
  locator.registerSingleton<ProductRemoteDataSourceImpl>(
      ProductRemoteDataSourceImpl());
  locator
      .registerSingleton<AuthRemoteDatasourceImpl>(AuthRemoteDatasourceImpl());
  locator
      .registerSingleton<CartRemoteDatasourceImpl>(CartRemoteDatasourceImpl());
  locator
      .registerSingleton<UserRemotedataSourceImpl>(UserRemotedataSourceImpl());
  locator.registerSingleton<OrderRemoteDataSourceImpl>(
      OrderRemoteDataSourceImpl());

  /// local-datasource
  locator.registerSingleton<AuthLocalDatasourceImpl>(AuthLocalDatasourceImpl());
  locator.registerSingleton<CartLocalDatasourceImpl>(
      CartLocalDatasourceImpl(store));
  locator.registerSingleton<UserLocalDatasourceImpl>(
      UserLocalDatasourceImpl(locator()));
  locator.registerSingleton<ProductLocalDatasourceImpl>(
      ProductLocalDatasourceImpl(store));

  /// repository-impl
  locator.registerSingleton<ProductRepositoryImpl>(
      ProductRepositoryImpl(locator(), locator()));
  locator.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(locator(), locator()));
  locator.registerSingleton<CartRepositoryImpl>(
      CartRepositoryImpl(locator(), locator()));
  locator.registerSingleton<UserRepositoryImpl>(UserRepositoryImpl(
      localDatasource: locator(), remotedataSource: locator()));
  locator.registerSingleton<OrdersRepositoryImpl>(OrdersRepositoryImpl(
    locator(),
    locator(),
  ));

  /// use-cases
  locator.registerSingleton<GetCarousal>(GetCarousal(repository: locator()));

  locator.registerSingleton<GetProducts>(GetProducts(repository: locator()));

  locator.registerSingleton<GetSubCategories>(
      GetSubCategories(repository: locator()));

  locator.registerSingleton<GetProductCategories>(
      GetProductCategories(repository: locator()));

  locator.registerSingleton<GetOtp>(GetOtp(locator()));
  locator.registerSingleton<VerifyOtp>(VerifyOtp(locator()));
  locator.registerSingleton<CheckLoggedIn>(CheckLoggedIn(locator()));
  locator.registerSingleton<UpdateLoggedInStatus>(UpdateLoggedInStatus(locator()));
  locator.registerSingleton<AddToCart>(AddToCart(locator()));
  locator.registerSingleton<ViewCart>(ViewCart(locator()));
  locator.registerSingleton<GetCartId>(GetCartId(locator()));
  locator.registerSingleton<RemoveFromCart>(RemoveFromCart(locator()));
  locator.registerSingleton<UpdateQty>(UpdateQty(locator()));
  locator.registerSingleton<SaveUserDetailsSharedPref>(
      SaveUserDetailsSharedPref(repository: locator()));
  locator.registerSingleton<UpdateUserDetails>(UpdateUserDetails(locator()));
  locator.registerSingleton<GetUserDetailsFromShared>(
      GetUserDetailsFromShared(locator()));
  locator.registerSingleton<ClearUserDetails>(ClearUserDetails(locator()));
  locator.registerSingleton<GetProductDetails>(GetProductDetails(locator()));
  locator.registerSingleton<AddBookmark>(AddBookmark(locator()));
  locator.registerSingleton<GetBookmarks>(GetBookmarks(locator()));
  locator.registerSingleton<RemoveBookmark>(RemoveBookmark(locator()));
  locator
      .registerSingleton<CheckIfProductBookmarked>(CheckIfProductBookmarked(locator()));
  locator.registerSingleton<CheckOrderStatus>(CheckOrderStatus(locator()));
  locator.registerSingleton<ClearCartId>(ClearCartId(locator()));
  locator.registerSingleton<GetOrdersList>(GetOrdersList(locator()));
  locator.registerSingleton<GetBrands>(GetBrands(locator()));

  locator.registerLazySingleton<ConnectivityRepository>(() => ConnectivityRepositoryImpl());
  locator.registerLazySingleton<CheckConnectivity>(() => CheckConnectivity(locator()));
  // locator.registerFactory(() => ConnectivityBloc(getIt<CheckConnectivity>()));
}
