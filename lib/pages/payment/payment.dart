import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_doctor_client/constant/constant.dart';
import 'package:user_doctor_client/pages/appointment/appointment.dart';

class Payment extends StatefulWidget {
  const Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Razorpay _razorpay = Razorpay();
  var orderId;

  int commision;

  String paymentId;

  String signature;
  void _showDialog(
      BuildContext context, String title, String message, Function function) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: function,
            child: Text('OK!'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCommision();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    orderId = response.orderId;
    paymentId = response.paymentId;
    signature = response.signature;
    // Do something when payment succeeds
    print("---success----${response.orderId}");
    _showDialog(context, "Success", "Your payment Succesful", () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Appointment(),
        ),
      );
    });

    db.collection("extras").add({
      "orderId": orderId,
      "paymentId": paymentId,
      "signature": signature,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Your request is received!", toastLength: Toast.LENGTH_SHORT);
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("---error----${response.message}");
    _showDialog(context, "Error Occured!", response.message, () {
      Navigator.of(context).pop();
    });

    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    // _showDialog(context, "Success", "Your payment Succesful");

    print("---wallet----${response.walletName}");
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  getCommision() {
    db.collection("extras").doc("commision").get().then((value) {
      final dat = value.data();
      commision = dat['com'];
      print("-----------${dat['com']}");
    });
  }

  doPayement() async {
    var options = {
      'key': paymentApiKey,
      'amount': commision + 100,
      'name': 'Doctor Client',
      'description': 'Payment for appointment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
              onPressed: () {
                doPayement();
              },
              child: Text("Click"))
        ],
      ),
    );
  }
}
