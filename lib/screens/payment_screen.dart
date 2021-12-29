import 'package:damascent/constants/common_functions.dart';
import 'package:damascent/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String price;
  final String email;
  final String type;
  const PaymentScreen(
      {Key? key, required this.price, required this.email, required this.type})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> globKeyPay = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String _loadHTML() {
      return widget.type == '1'
          ? '''
  <html>
  <body onload="document.f.submit();">
  <form id="f" name="f" method="get" action="https://damascent.com/stripe/index.php?price=${widget.price}&email=${widget.email}">
  <input type="hidden" name="price" value="${widget.price}"/>
  <input type="hidden" name="email" value="${widget.email}"/>
  </form>
  </body>
  </html>
  '''
          : '''
  <html>
  <body onload="document.f.submit();">
  <form id="f" name="f" method="get" action="https://damascent.com/paypal/invoice.php?price=${widget.price}&email=${widget.email}">
  <input type="hidden" name="price" value="${widget.price}"/>
  <input type="hidden" name="email" value="${widget.email}"/>
  </form>
  </body>
  </html>
  ''';
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: globKeyPay,
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title: const Text('Payment'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: WebView(
          onPageFinished: (page) async {

              if (page.contains('/shopping')) {
                debugPrint('SUCCESS PAGE');
                showToast("Payment Successful", Colors.green);
                showToast(
                    "You will be redirected to App shortly", Colors.green);
                await Future.delayed(const Duration(seconds: 3)).then((value) {
                  Navigator.pop(context, true);
                });
              }

            // }
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
        ),
      ),
    );
  }
}
