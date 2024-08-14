import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionHelper{
  Future<bool> checkInternetConnection()async{
    var connectivityResult=await Connectivity().checkConnectivity(); 

    if(connectivityResult== ConnectivityResult.none){
      return false;
    }else if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi || connectivityResult==ConnectivityResult.vpn){
        return true;
    }
    return false; 
  }
}