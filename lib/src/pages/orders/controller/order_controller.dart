import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/pages/orders/repository/orders.repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;
  bool isLoading = false;

  OrderController(this.order);

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  Future<void> getOrderItems() async {
    setLoading(true);

    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );

    setLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
