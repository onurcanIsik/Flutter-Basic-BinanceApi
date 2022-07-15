import 'dart:async';
import 'package:binance_spot/binance_spot.dart';
import 'package:flutter/material.dart' hide Interval;
import 'package:flutter_binance_api/Widget/coin_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BinanceSpot binanceSpot = BinanceSpot(
    key: "YOUR API KEY",
    secret: "YOUR SECRET API KEY",
  );
  double lastClosePrice = 0;
  double lastPriceEth = 0;
  late StreamSubscription<dynamic> klineStreamSub;
  late StreamSubscription<dynamic> klineStreamEth;

  @override
  void initState() {
    startKlineStream();
    startKlineEtherium();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#324A60"),
      appBar: AppBar(
        backgroundColor: HexColor("#E8AB16"),
        title: Text(
          "Binance Api",
          style: GoogleFonts.comfortaa(
            color: HexColor("#2F2F1B"),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  coinWidget(
                    "Current BTC price : $lastClosePrice",
                    "Assets/Images/btc.jpeg",
                  ),
                  coinWidget(
                    "Current ETH price : $lastPriceEth",
                    "Assets/Images/eth.jpeg",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void startKlineStream() {
    var stream = binanceSpot.klineStream(
      symbol: "BTCUSDT",
      interval: Interval.INTERVAL_5m,
    );
    klineStreamSub = stream.listen(handleNewKline);
  }

  void handleNewKline(WsKlineEvent event) {
    setState(() {
      lastClosePrice = event.kline.close;
    });
  }

  void startKlineEtherium() {
    var stream = binanceSpot.klineStream(
      symbol: "ETHBUSD",
      interval: Interval.INTERVAL_5m,
    );
    klineStreamEth = stream.listen(handleEtherium);
  }

  void handleEtherium(WsKlineEvent event) {
    setState(() {
      lastPriceEth = event.kline.close;
    });
  }

  @override
  void dispose() {
    klineStreamSub.cancel();
    super.dispose();
  }
}
