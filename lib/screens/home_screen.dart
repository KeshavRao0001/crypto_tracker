import 'package:cryptotracker/models/cryptocurrency.dart';
import 'package:cryptotracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Crypto Today",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Trade & Upgrade",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 18.0,
              ),
              Expanded(
                child: Consumer<MarketProvider>(
                    builder: (context, marketProvider, child) {
                  if (marketProvider.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketProvider.markets.isNotEmpty) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: marketProvider.markets.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency currentCrypto =
                                marketProvider.markets[index];

                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCrypto.image!),
                              ),
                              title: Text(currentCrypto.name! +
                                  " #${currentCrypto.marketCapRank!}"),
                              subtitle:
                                  Text(currentCrypto.symbol!.toUpperCase()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹" +
                                        currentCrypto.currentPrice!
                                            .toStringAsFixed(4),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Builder(builder: (context) {
                                    double priceChange =
                                        currentCrypto.priceChange24!;
                                    double priceChangePercentage =
                                        currentCrypto.priceChange24!;

                                    if (priceChange < 0) {
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)}"
                                        "%${priceChange.toStringAsFixed(3)}",
                                        style: TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      return Text(
                                        "+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(3)})",
                                        style: TextStyle(color: Colors.green),
                                      );
                                    }
                                  })
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text("Not Found");
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
