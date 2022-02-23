import 'dart:convert';

import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Club/SingleProviderModel.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/web_controllers.dart';
import 'package:paakaar/Utils/Api/web_methods.dart';

class ClubWebMethods extends WebMethods {
  static const String providerByCaste = 'providerByCaste';
  static const String singleProvider = 'singleProvider';
  static const String allOperators = 'allOperators';
  static const String buyCharge = 'buyCharge';
  static const String allCards = 'allCards';
  static const String deleteCards = 'deleteCards';
  static const String findBank = 'findBank';
  static const String addCard = 'addCard';
  static const String getVoucherCode = 'getVoucherCode';
  static const String getVoucherCodeProviders = 'getVoucherCodeProviders';
  static const String getFlights = 'getFlights';
  static const String getAirports = 'getAirports';
  static const String getHotels = 'getHotels';
  static const String getRegions = 'getRegions';
  static const String packageList = 'packageList';
  static const String allWorkGroups = 'allWorkGroups';
  static const String allCastes = 'allCastes';
  static const String allProviders = 'allProviders';
  static const String allCities = 'allCities';
  static const String getWallets = 'getWallets';
  static const String payToProvider = 'payToProvider';
  static const String thirdPartyBaseData = 'thirdPartyBaseData';
  static const String carBodyBaseData = 'carBodyBaseData';
  static const String motorBaseData = 'motorBaseData';
  static const String travelBaseData = 'travelBaseData';
  static const String fireBaseData = 'fireBaseData';
  static const String healthBaseData = 'healthBaseData';
  static const String coronaBaseData = 'coronaBaseData';
  static const String travelPlusBaseData = 'travelPlusBaseData';
  static const String buyInternetPackage = 'buyInternetPackage';
  static const String setNationalCode = 'setNationalCode';
  static const String allNews = 'allNews';
  static const String mainNews = 'mainNews';
}

class ClubRequestUtils extends RequestsUtil {
  static ClubRequestUtils instance = ClubRequestUtils();

  Future<ApiResult> allOperators() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allOperators,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> mainNews() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.mainNews,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> allNews() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allNews,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> setNationalCode({required String nationalCode}) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user?.id.toString(),
        'nationalCode': nationalCode.toString(),
      },
      webMethod: ClubWebMethods.setNationalCode,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> buyCharge({
    required String mobile,
    required String amount,
  }) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
        'mobile': mobile,
        'amount': amount.toString(),
      },
      webMethod: ClubWebMethods.buyCharge,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> allCards() async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
      },
      webMethod: ClubWebMethods.allCards,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> deleteCards({
    required List<int> list,
  }) async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.deleteCards,
      body: {
        'cards': jsonEncode(list),
        'customerId': Globals.userStream.user!.id.toString(),
      },
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> findBank(String text) async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.findBank,
      body: {
        'prefix': text,
      },
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> addCard({
    required String cardNumber,
    required String cvv2,
    required String expireMonth,
    required String expireYear,
    required String bankId,
  }) async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.addCard,
      webController: WebControllers.Services,
      body: {
        'cardNumber': cardNumber.toString(),
        'cvv2': cvv2.toString(),
        'bank_id': bankId.toString(),
        'expireMonth': expireMonth.toString(),
        'expireYear': expireYear.toString(),
        'customerId': Globals.userStream.user!.id.toString(),
      },
    );
  }

  Future<ApiResult> getRegionList() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.getRegions,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> searchHotels({
    required int destination,
    required String dates,
  }) async {
    return await this.makeRequest(
      body: {
        'destination': destination.toString(),
        'dates': dates,
        'customerId': Globals.userStream.user!.id.toString(),
      },
      webMethod: ClubWebMethods.getHotels,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> buyInternet({
    required String operatorId,
    required String simType,
  }) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
        'operatorId': operatorId.toString(),
        'simType': simType,
      },
      webMethod: ClubWebMethods.packageList,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> getAllVoucherCodeProviders() async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
      },
      webMethod: ClubWebMethods.getVoucherCodeProviders,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> getVoucherCodeInfo(String providerCode) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
        'providerCode': providerCode,
      },
      webMethod: ClubWebMethods.getVoucherCode,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> allWorkGroups() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allWorkGroups,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> allCities() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allCities,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> allCastes(
    String workGroupId,
  ) async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allCastes,
      webController: WebControllers.Services,
      body: {
        'workgroupId': workGroupId,
      },
    );
  }

  Future<ApiResult> singleProvider({
    required String providerId,
  }) async {
    return await this.makeRequest(
      webController: WebControllers.Services,
      webMethod: ClubWebMethods.singleProvider,
      body: {
        'providerId': providerId,
      },
    ).timeout(Duration(seconds: 50));
  }

  Future<ApiResult> allProviders(
    String casteId,
    int page,
  ) async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.allProviders,
      webController: WebControllers.Services,
      body: {
        'casteId': casteId,
        'page': page.toString(),
        'cityId': Globals.city.city?.id.toString(),
      },
    );
  }

  Future<ApiResult> getWallets() async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
      },
      webMethod: ClubWebMethods.getWallets,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> payToProvider({
    required SingleProviderModel provider,
    required double amount,
    bool fromWallet = false,
  }) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
        'fromWallet': fromWallet.toString(),
        'providerId': provider.providerCode.toString(),
        'amount': amount.toString(),
      },
      webMethod: ClubWebMethods.payToProvider,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> thirdPartyBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.thirdPartyBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> carBodyBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.carBodyBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> motorBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.motorBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> travelBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.travelBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> fireBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.fireBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> travelPlusBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.travelPlusBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> healthBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.healthBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> coronaBaseData() async {
    return await this.makeRequest(
      webMethod: ClubWebMethods.coronaBaseData,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> buyPackage({
    required String packageCode,
    required String packageCost,
    required String mobile,
  }) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user?.id.toString(),
        'packageCode': packageCode,
        'packageCost': packageCost,
        'mobile': mobile,
      },
      webMethod: ClubWebMethods.buyInternetPackage,
      webController: WebControllers.Services,
    );
  }

  Future<ApiResult> buyLevel(String levelId) async {
    return await this.makeRequest(
      body: {
        'customerId': Globals.userStream.user!.id.toString(),
        'levelId': levelId,
      },
      webMethod: WebMethods.buyLevel,
      webController: WebControllers.Services,
    );
  }
}
