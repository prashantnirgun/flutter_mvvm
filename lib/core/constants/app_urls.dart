class AppUrls {
  ///https://ecommerceapi.projectnest.online/ecommerce-api/user/registration
  static const String baseUrl = "http://example/com/api/";
  static const String registrationUrl = "${baseUrl}users/sign-up";
  static const String loginUrl = "${baseUrl}users/sign-in";

  /// Endpoint to check whether a username exists. Use as: `userExistsUrl?user_name=...`
  static const String userExistsUrl = "${baseUrl}users/user-exists";

  static const String userListUrl = "${baseUrl}user/list";

  static const String fetchCategoryUrl = "${baseUrl}categories";
  static const String fetchProductUrl = "${baseUrl}products";
  static const String addToCartUrl = "${baseUrl}add-to-cart";
  static const String deleteFromCartUrl = "${baseUrl}product/delete-cart";
  static const String fetchCartUrl = "${baseUrl}product/view-cart";
  static const String createOrderUrl = "${baseUrl}product/create-order";
  static const String fetchOrderUrl = "${baseUrl}product/get-order";
  static const String updateQtyUrl = "${baseUrl}product/decrement-quantity";
}
