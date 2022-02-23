import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:paakaar/Globals/globals.dart';
import 'package:paakaar/Models/Chat/messages_model.dart';
import 'package:paakaar/Models/CustomFileModel.dart';
import 'package:paakaar/Utils/Api/Base/base_request_util.dart';
import 'package:paakaar/Utils/Api/web_controllers.dart';
import 'package:paakaar/Utils/Api/web_methods.dart';

class ProjectRequestUtils extends RequestsUtil {
  static ProjectRequestUtils instance = ProjectRequestUtils();

  Future<ApiResult> completeRegister({
    required String name,
    required String lastName,
    // String fatherName,
    // String nationalCode,
    // required String referer,
    required String code,
    required String mobile,
    required String gender,
  }) async {
    return await makeRequest(
      webController: WebControllers.Individuals,
      webMethod: WebMethods.register,
      body: {
        "fname": name,
        "lname": lastName,
        // "fatherName": fatherName,
        // "nationalCode": nationalCode,
        "gender": gender,
        // "referer": referer,
        "mobile": mobile,
        "code": code,
      },
    ).timeout(const Duration(seconds: 50));
  }

  Future<ApiResult> register({
    required String mobile,
    required String code,
    required String pushId,
  }) async {
    return await makeRequest(
      webController: WebControllers.Individuals,
      webMethod: WebMethods.codeValidate,
      body: {
        'mobile': mobile,
        'code': code,
        'pushId': pushId,
      },
    ).timeout(const Duration(seconds: 50));
  }

  Future<ApiResult> forgotPassword(String mobile) async {
    return await makeRequest(
      body: {
        'mobile': mobile,
      },
      webMethod: WebMethods.forgotPassword,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> deleteMessage({String? id}) async {
    return await makeRequest(
      body: {
        'messageId': id,
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.deleteMessage,
      webController: WebControllers.Messages,
    );
  }

  Future<ApiResult> sendNewTicket({String? message, String? title}) async {
    return await makeRequest(
      body: {
        'message': message,
        'title': title,
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.addTicket,
      webController: WebControllers.Tickets,
    );
  }

  Future<ApiResult> getTicketsRoom({String? id}) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.individualTickets,
      webController: WebControllers.Tickets,
    );
  }

  Future<ApiResult> removeReport({String? id}) async {
    return await makeRequest(
      body: {
        'reportId': id,
      },
      webMethod: WebMethods.deleteReport,
      webController: WebControllers.ReportAbuse,
    );
  }

  Future<ApiResult> getDashboardScore() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.getScore,
      webController: WebControllers.Scores,
    );
  }

  Future<ApiResult> getCanAddCall() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.callType,
      webController: WebControllers.Calls,
    );
  }

  Future<ApiResult> getCanAddAd() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.adType,
      webController: WebControllers.Ads,
    );
  }

  Future<ApiResult> getScore() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.scoreList,
      webController: WebControllers.Scores,
    );
  }

  Future<ApiResult> deleteChat({String? id}) async {
    return await makeRequest(
      body: {
        'targetId': id,
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.deleteChat,
      webController: WebControllers.Messages,
    );
  }

  Future<ApiResult> deleteTicketRoom({String? id}) async {
    return await makeRequest(
      body: {
        'ticketId': id,
      },
      webMethod: WebMethods.deleteTicket,
      webController: WebControllers.Tickets,
    );
  }

  Future<ApiResult> deleteFile({CustomFileModel? file}) async {
    return await makeRequest(
      files: file!.file,
      body: {
        'fileId': file.id.toString(),
      },
      webMethod: WebMethods.deleteCvItem,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> sendNewReport({String? report}) async {
    return await makeRequest(
      body: {
        'text': report,
        'individualId': Globals.userStream.user!.id.toString(),
      },
      webMethod: WebMethods.addReport,
      webController: WebControllers.ReportAbuse,
    );
  }

  Future<ApiResult> sendAnswerTicket(
      {String? id, String? ticketMessage}) async {
    return await makeRequest(
      body: {
        'ticketId': id,
        'message': ticketMessage,
      },
      webMethod: WebMethods.answerTicket,
      webController: WebControllers.Tickets,
    );
  }

  Future<ApiResult> getAllReports() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webMethod: WebMethods.getReports,
      webController: WebControllers.ReportAbuse,
    );
  }

  Future<ApiResult> closeTicketMessage({String? id}) async {
    return await makeRequest(
      body: {
        'ticketId': id,
      },
      webMethod: WebMethods.closeTicket,
      webController: WebControllers.Tickets,
    );
  }

  Future<ApiResult> getAllFields() async {
    return await makeRequest(
      webMethod: WebMethods.getAllFields,
      webController: WebControllers.Fields,
    );
  }

  Future<ApiResult> getTopSliders() async {
    return await makeRequest(
      webMethod: WebMethods.getTopSliders,
      webController: WebControllers.UpSliders,
    );
  }

  Future<ApiResult> getInfoData() async {
    return await makeRequest(
      webMethod: WebMethods.contactUs,
      webController: WebControllers.ContactUs,
    );
  }

  Future<ApiResult> getTvItems() async {
    return await makeRequest(
      webMethod: WebMethods.allAcceptedVideos,
      webController: WebControllers.Tv,
    );
  }

  Future<ApiResult> getCallOuts(List<int> id) async {
    return await makeRequest(
      body: {
        'specialities': jsonEncode(id),
        'individualId': Globals.userStream.user?.id,
      },
      webMethod: WebMethods.recentCalls,
      webController: WebControllers.Calls,
    );
  }

  Future<ApiResult> recentAds({String? fieldId}) async {
    return await makeRequest(
      body: {
        'fieldId':fieldId,
      },
      webMethod: WebMethods.recentAds,
      webController: WebControllers.Ads,
    );
  }

  Future<ApiResult> dashboardAd() async {
    return await makeRequest(
      webMethod: WebMethods.getAllAdBanners,
      webController: WebControllers.AdBanners,
    );
  }

  Future<ApiResult> forgotPasswordConfirm(String mobile, String code) async {
    return await makeRequest(
      body: {
        'mobile': mobile,
        'code': code,
      },
      webMethod: WebMethods.forgotPasswordConfirm,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> login({
    required String mobile,
    required String password,
    required String pushId,
  }) async {
    return await makeRequest(
      webController: WebControllers.Individuals,
      webMethod: WebMethods.login,
      body: {

        'mobile': mobile,
        'code': password,
        'pushId': pushId,
      },
    ).timeout(const Duration(seconds: 50));
  }

  Future<ApiResult> startLoginRegister({required String mobile}) async {
    return await makeRequest(
      body: {
        'mobile': mobile,
      },
      webMethod: WebMethods.startLoginRegister,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> getIndividualData(String value) async {
    return await makeRequest(
      body: {
        'userId': value,
      },
      webMethod: WebMethods.getIndividualData,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> getOptions(int id) async {
    return await makeRequest(
      body: {
        'specialtyId': id.toString(),
      },
      webMethod: WebMethods.getOptionsBySpeciality,
      webController: WebControllers.Options,
    );
  }

  Future<ApiResult> getOptionsByListOfIds(List<int> ids) async {
    return await makeRequest(
      body: {
        'specialities': jsonEncode(ids),
      },
      webMethod: WebMethods.getOptionsBySpecialities,
      webController: WebControllers.Options,
    );
  }

  Future<ApiResult> getPublicOptions(int id) async {
    return await makeRequest(
      body: {
        'fieldId': id.toString(),
      },
      webMethod: WebMethods.getPublicOptions,
      webController: WebControllers.PublicFilters,
    );
  }

  Future<ApiResult> getIndividualsBySubSubGroupId(int id) async {
    return await makeRequest(
      body: {
        'subSubgroupId': id,
      },
      webMethod: WebMethods.getIndividualsBySubSubGroupId,
      webController: WebControllers.Individuals,
    );
  }

  Future<ApiResult> getAllMemberships() async {
    return await makeRequest(
      webMethod: WebMethods.getAllMemberships,
      webController: WebControllers.Membership,
    );
  }

  Future<ApiResult> buyMembership(
    int membershipId,
  ) async {
    return await makeRequest(
      body: {
        'membershipId': membershipId,
        'individualId': Globals.userStream.user?.id,
      },
      webMethod: WebMethods.buyMembership,
      webController: WebControllers.Membership,
    );
  }

  Future<ApiResult> allStatesAndCities() async {
    return await makeRequest(
      webMethod: WebMethods.getAllStates,
      webController: WebControllers.States,
    );
  }

  Future<ApiResult> allSubSubgroups() async {
    return await makeRequest(
      webController: WebControllers.SubsiderSubgroup,
      webMethod: WebMethods.allSubSubgroups,
    );
  }

  Future<ApiResult> allIntroScreens() async {
    return await makeRequest(
      webController: WebControllers.AppIntroScreens,
      webMethod: WebMethods.allIntroScreens,
    );
  }

  Future<ApiResult> allSocialMediaAddresses() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Individuals,
      webMethod: WebMethods.allSocialMediaAddresses,
    );
  }

  Future<ApiResult> uploadFile({CustomFileModel? file}) async {
    return await makeRequest(
      files: file!.file,
      body: {
        'fileName': file.name,
        'individualId':Globals.userStream.user!.id.toString()
      },
      webController: WebControllers.Individuals,
      webMethod: WebMethods.addCvFile,
    );
  }

  Future<ApiResult> saveProfile({
    required List<int> listOfSubSubGroups,
    XFile? image,
    required Map<String, String> listOfSocialMedia,
    required String bio,
    required String password,
    int stateId = 0,
    String? fName,
    String? lName,
    int cityId = 0,
    int region = 0,
    required List<Map<String, dynamic>> listOptions,
    required List<CustomFileModel> cvFiles,
    required String cv,
    required bool showMobile,
  }) async {
    List<String> fileNames = [];
    List<File> files = [];
    cvFiles.forEach((element) {
      if (element.file != null) {
        fileNames.add(element.name);
        files.add(element.file!);
      }
    });
    print('==================###===============');
    print(jsonEncode(
      cvFiles.where((element) => element.id > 0).map((e) => e.name).toList(),
    ));
    print('==================###===============');
    return await makeRequest(
      body: {
        'fileNames': jsonEncode(fileNames),
        // 'files': jsonEncode(
        //         cvFiles
        //             .where((element) => element.id > 0)
        //             .map((e) => e.id)
        //             .toList(),
        //       ),
        'listOfSocialMedia': jsonEncode(listOfSocialMedia),
        'listOfOptions': jsonEncode(listOptions),
        'specialities': jsonEncode(listOfSubSubGroups),
        'individualId': Globals.userStream.user?.id,
        'bio': bio,
        'cv': cv,
        'fname':fName,
        'lname':lName,
        'showMobile': showMobile ? 1 : 2,
        'password': password,
        'stateId': stateId.toString(),
        'cityId': cityId.toString(),
        'region': region.toString(),
        'avatar': image is XFile
            ? base64Encode(
                await image.readAsBytes(),
              )
            : null,
      },
      webController: WebControllers.Individuals,
      webMethod: WebMethods.saveProfile,
    );
  }

  Future<ApiResult> getIndividualsInField(int id) async {
    return await makeRequest(
      body: {
        'fieldId': id.toString(),
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Individuals,
      webMethod: WebMethods.getIndividualsInField,
    );
  }

  Future<ApiResult> changeBookmark(int id) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'targetId': id,
      },
      webController: WebControllers.Bookmarks,
      webMethod: WebMethods.changeBookmark,
    );
  }

  Future<ApiResult> myBookmarks() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Bookmarks,
      webMethod: WebMethods.myBookmarks,
    );
  }

  Future<ApiResult> saveCallOut({
    required int fieldId,
    required int categoryId,
    required int specialityId,
    required String text,
    required dynamic image,
    required String phoneNumber,
    required String link,
    required int stateId,
    required int cityId,
    required String title,
    required String district,
    required String day,
    required List<Map<String, Object>> listOptions,
  }) async {
    return await makeRequest(
      body: {
        'fieldId': fieldId.toString(),
        'categoryId': categoryId.toString(),
        'listOfOptions': jsonEncode(listOptions),
        'specialityId': specialityId.toString(),
        'stateId': stateId.toString(),
        'cityId': cityId.toString(),
        'day': day.toString(),
        'district': district.toString(),
        'title': title,
        'desc': text,
        'callNumber': phoneNumber,
        'link': link,
        'cover': (image is XFile)
            ? base64Encode(
                await image.readAsBytes(),
              )
            : '',
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.saveCallOut,
    );
  }

  Future<ApiResult> saveAd({
    required int fieldId,
    required int stateId,
    required int cityId,
    required String title,
    required String link,
    required String price,
    required dynamic cover,
    required String desc,
  }) async {
    return await makeRequest(
      body: {
        'fieldId': fieldId.toString(),
        'stateId': stateId.toString(),
        'cityId': cityId.toString(),
        'title': title.toString(),
        'link': link,
        'desc': desc,
        'price': price,
        'cover': (cover is XFile)
            ? base64Encode(
                await cover.readAsBytes(),
              )
            : '',
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Ads,
      webMethod: WebMethods.addAd,
    );
  }

  Future<ApiResult> sendProposal({
    required int callId,
    required String price,
    required int priceTypeId,
    required String text,
  }) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callId': callId.toString(),
        'price': price.toString(),
        'priceTypeId': priceTypeId.toString(),
        'text': text.toString(),
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.sendProposal,
    );
  }

  Future<ApiResult> getUserCallOuts() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.userCallOuts,
    );
  }

  Future<ApiResult> getUserAds() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Ads,
      webMethod: WebMethods.userAds,
    );
  }

  Future<ApiResult> getCallOutProposals(int callId) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callId': callId,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.callOutProposals,
    );
  }

  Future<ApiResult> acceptProposal({
    required int proposalId,
    required int callOutId,
  }) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callId': callOutId,
        'proposalId': proposalId,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.acceptProposal,
    );
  }

  Future<ApiResult> readProposal({
    required int proposalId,
    required int callOutId,
  }) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callId': callOutId,
        'proposalId': proposalId,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.readProposal,
    );
  }

  Future<ApiResult> allMessages() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Messages,
      webMethod: WebMethods.allMessages,
    );
  }

  Future<ApiResult> sendMessage(MessageModel message) async {
    Map<String, dynamic> data = message.toJson();
    return await makeRequest(
      body: data,
      webController: WebControllers.Messages,
      webMethod: WebMethods.sendMessage,
    );
  }

  Future<ApiResult> startChat({
    required int targetId,
  }) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'targetId': targetId,
      },
      webController: WebControllers.Messages,
      webMethod: WebMethods.startChat,
    );
  }

  Future<ApiResult> deleteAds(List<int> list) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'ads': jsonEncode(
          list,
        ),
      },
      webController: WebControllers.Ads,
      webMethod: WebMethods.deleteAds,
    );
  }

  Future<ApiResult> deleteCallOuts(List<int> list) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callOuts': jsonEncode(
          list,
        ),
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.deleteCallOuts,
    );
  }

  Future<ApiResult> deleteProposal(List<int> list) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'callId': jsonEncode(
          list,
        ),
      },
      webController: WebControllers.Proposals,
      webMethod: WebMethods.deleteProposal,
    );
  }

  Future<ApiResult> saveComment({
    required double rate,
    required String comment,
    required int targetId,
    int proposalId = 0,
  }) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'rate': rate.toString(),
        'comment': comment,
        'targetId': targetId.toString(),
        'proposalId': proposalId,
      },
      webController: WebControllers.Individuals,
      webMethod: WebMethods.rateUser,
    );
  }

  Future<ApiResult> getMainCategories(int fieldId) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'fieldId': fieldId,
      },
      webController: WebControllers.Categories,
      webMethod: WebMethods.allMainCategories,
    );
  }

  Future<ApiResult> getSubCategories(int categoryId) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'categoryId': categoryId,
      },
      webController: WebControllers.Categories,
      webMethod: WebMethods.allSubCategories,
    );
  }

  Future<ApiResult> getSpecialities(int categoryId) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'categoryId': categoryId,
      },

      webController: WebControllers.Specialties,
      webMethod: WebMethods.allSpecialitiesByCategoryId,
    );
  }

  Future<ApiResult> getMyProposals() async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
      },
      webController: WebControllers.Calls,
      webMethod: WebMethods.myProposals,
    );
  }

  Future<ApiResult> getDistrictsByCity(int cityId) async {
    return await makeRequest(
      body: {
        'individualId': Globals.userStream.user?.id,
        'cityId': cityId,
      },
      webController: WebControllers.Districts,
      webMethod: WebMethods.districtsByCityId,
    );
  }
}
