import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:marketi/core/services/stripe_payment/stripe_keys.dart';

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      String cleintSecret = await _getClientSecret(
        currency,
        (amount * 100).toString(),
      );
      await _initPaymentSheet(cleintSecret);
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<String> _getClientSecret(String currency, String amount) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {'amount': amount, 'currency': currency},
    );
    return response.data['client_secret'];
  }

  static Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Marketi',
      ),
    );
  }
}
