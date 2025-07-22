import 'package:crocurry/data/data_sources/order/order_remote_data_source.dart';
import 'package:crocurry/data/data_sources/user/user_local_datasource.dart';
import 'package:crocurry/data/models/orders_model.dart';
import 'package:crocurry/domain/repository/orders/orders_repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  final OrderRemoteDataSourceImpl orderRemoteDataSource;
  final UserLocalDatasourceImpl userLocalDatasource;
  OrdersRepositoryImpl(
    this.orderRemoteDataSource,
    this.userLocalDatasource,
  );
  @override
  Future<(List<OrdersModel>?, Exception?)> getOrdersList() async {
    try {
      var userId = await userLocalDatasource.getUserId();
      return await orderRemoteDataSource.getOrdersList(userId);
    } catch (err) {
      return (null, Exception());
    }
  }
}
