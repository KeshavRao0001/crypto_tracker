import 'dart:async';

import 'package:cryptotracker/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

import '../models/Api.dart';

class MarketProvider with ChangeNotifier{
  
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider(){
    fetchData();
  }
  
  void fetchData() async{
    List<dynamic> _markets = await API.getMarkets();
    
    List<CryptoCurrency> temp = [];
    for(var market in _markets){
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 3),(){
      fetchData();
      print("Updated");
    });

  }
  
}