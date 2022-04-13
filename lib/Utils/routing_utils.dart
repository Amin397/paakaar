import 'package:paakaar/Pages/AddAd/ad_add_screen.dart';
import 'package:paakaar/Pages/AllAds/View/all_ads_screen.dart';
import 'package:paakaar/Pages/AppIntro/app_intro_screen.dart';
import 'package:paakaar/Pages/BookmarksScreen/bookmarks_screen.dart';
import 'package:paakaar/Pages/Chat/chat_single_screen.dart';
import 'package:paakaar/Pages/Club/BarcodeReader/QrCodeScannerScreen.dart';
import 'package:paakaar/Pages/Club/Charity/CharityScreen.dart';
import 'package:paakaar/Pages/Club/CreditCards/CreditCardsScreen.dart';
import 'package:paakaar/Pages/Club/Insurance/MainInsuranceScreen.dart';
import 'package:paakaar/Pages/Club/Insurance/Pages/ThirdPersonInsuranceScreen.dart';
import 'package:paakaar/Pages/Club/Internet/internetPackageScreen.dart';
import 'package:paakaar/Pages/Club/MobileCharge/MobileChargeScreen.dart';
import 'package:paakaar/Pages/Club/Providers/WorkGroups/WorkGroups.dart';
import 'package:paakaar/Pages/Club/VoucherCodes/VoucherCodeScreen.dart';
import 'package:paakaar/Pages/Club/dashboard_screen.dart';
import 'package:paakaar/Pages/LoginRegister/login_register_screen.dart';
import 'package:paakaar/Pages/MainPage/dashboard_screen.dart';
import 'package:paakaar/Pages/NewReport/View/new_report_from_user.dart';
import 'package:paakaar/Pages/ParticipateForCallOut/participate_for_call_out_screen.dart';
import 'package:paakaar/Pages/Peoposals/my_proposal_screen.dart';
import 'package:paakaar/Pages/Profile/complete_profile_screen.dart';
import 'package:paakaar/Pages/ReportFromUser/View/report_from_user_screen.dart';
import 'package:paakaar/Pages/RequestService/CallOuts/call_out_single_screen.dart';
import 'package:paakaar/Pages/RequestService/CallOuts/add_call_out_screen.dart';
import 'package:paakaar/Pages/RequestService/expert_list_screen.dart';
import 'package:paakaar/Pages/RequestService/request_service_screen.dart';
import 'package:paakaar/Pages/Scores/VIew/user_score_screen.dart';
import 'package:paakaar/Pages/SelectFieldAndGroupScreen/select_field_and_group_screen.dart';
import 'package:paakaar/Pages/SingleTicket/View/single_ticket_screen.dart';
import 'package:paakaar/Pages/Ticket/View/send_new_ticket_screen.dart';
import 'package:paakaar/Pages/Ticket/View/ticket_screen.dart';
import 'package:paakaar/Pages/Splash/splash_screen.dart';
import 'package:paakaar/Pages/Support/View/support_screen.dart';
import 'package:paakaar/Pages/UpgradePlan/upgrade_plan_screen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/my_ads_screen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/MyCallOutSingleScreen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/view_proposal_screen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/my_call_outs_screen.dart';
import 'package:paakaar/Pages/UserDashboardScreen/user_dashboard_screen.dart';
import 'package:paakaar/Plugins/get/get.dart';

class RoutingUtils {
  static GetPage splash = GetPage(
    name: '/',
    page: () => SplashScreen(),
  );
  static GetPage loginRegister = GetPage(
    name: '/loginRegister',
    page: () => LoginRegisterScreen(),
  );
  static GetPage sendNewTicket = GetPage(
    name: '/sendNewTicketRout',
    page: () => SendNewTicketScreen(),
  );
  static GetPage userScore = GetPage(
    name: '/userScore',
    page: () => UserScoreScreen(),
  );
  static GetPage getFieldAndGroupDialog = GetPage(
    name: '/getField',
    page: () => SelectFieldAndGroupScreen(),
  );
  static GetPage newReport = GetPage(
    name: '/newReport',
    page: () => NewReportFromUserScreen(),
  );
  static GetPage reportFromUser = GetPage(
    name: '/reportFromUser',
    page: () => ReportFromUserScreen(),
  );
  static GetPage showSingleTicket = GetPage(
    name: '/showSingleTicket',
    page: () => ShowSingleTicketScreen(),
  );
  static GetPage allAds = GetPage(
    name: '/allAds',
    page: () => AllAdsScreen(),
  );
  static GetPage ticketSingle = GetPage(
    name: '/getField',
    page: () => SingleTicketScreen(),
  );
  static GetPage myBookmarks = GetPage(
    name: '/myBookmarks',
    page: () => BookmarksScreen(),
  );
  static GetPage chatSingle = GetPage(
    name: '/chatSingle',
    page: () => ChatSingleScreen(),
  );
  static GetPage viewProposal = GetPage(
    name: '/viewProposal',
    page: () => ViewProposalScreen(),
  );
  static GetPage myCallOutSingle = GetPage(
    name: '/myCallOutSingle',
    page: () => MyCallOutSingleScreen(),
  );
  static GetPage myCallOuts = GetPage(
    name: '/myCallOuts',
    page: () => MyCallOutsScreen(),
  );
  static GetPage myProposals = GetPage(
    name: '/myProposals',
    page: () => MyProposalsScreen(),
  );
  static GetPage myAds = GetPage(
    name: '/myAds',
    page: () => MyAdsScreen(),
  );
  static GetPage participateForCallOut = GetPage(
    name: '/participateForCallOut',
    page: () => ParticipateForCallOutScreen(),
  );
  static GetPage appIntroScreen = GetPage(
    name: '/appIntroScreen',
    page: () => AppIntroScreen(),
  );
  static GetPage dashboard = GetPage(
    name: '/dashboard',
    page: () => DashboardScreen(),
  );
  static GetPage userDashboard = GetPage(
    name: '/userDashboard',
    page: () => UserDashboardScreen(),
  );
  static GetPage requestService = GetPage(
    name: '/requestService',
    page: () => RequestServiceScreen(),
  );
  static GetPage support = GetPage(
    name: '/mySupport',
    page: () => SupportScreen(),
  );
  static GetPage expertList = GetPage(
    name: '/expertList',
    page: () => ExpertListScreen(),
  );
  static GetPage addCallOut = GetPage(
    name: '/addCallOut',
    page: () => AddCallOutScreen(),
  );

  static GetPage upgradePlan = GetPage(
    name: '/upgradePlan',
    page: () => UpgradePlanScreen(),
  );

  static GetPage completeProfile = GetPage(
    name: '/completeProfile',
    page: () => CompleteProfileScreen(),
  );

  static GetPage adAdd = GetPage(
    name: '/adAdd',
    page: () => AdAddScreen(),
  );
  static GetPage callOutSingle = GetPage(
    name: '/callOutSingle',
    page: () => CallOutSingleScreen(),
  );
}

class ClubRoutingUtils extends RoutingUtils {
  static GetPage mainInsuranceScreen = GetPage(
    name: '/mainInsuranceScreen',
    page: () => MainInsuranceScreen(),
  );

  static GetPage clubDashboard = GetPage(
    name: '/clubDashboard',
    page: () => ClubDashboardScreen(),
  );
  static GetPage charge = GetPage(
    name: '/charge',
    page: () => MobileChargeScreen(),
  );
  static GetPage cards = GetPage(
    name: '/cards',
    page: () => CreditCardsScreen(),
  );
  static GetPage qrScanner = GetPage(
    name: '/qrScanner',
    page: () => QRCodeScannerScreen(),
  );
  static GetPage charity = GetPage(
    name: '/charity',
    page: () => CharityScreen(),
  );
  static GetPage internet = GetPage(
    name: '/internet',
    page: () => InternetPackageScreen(),
  );
  static GetPage voucherCodes = GetPage(
    name: '/voucherCodes',
    page: () => VoucherCodeScreen(),
  );
  static GetPage workGroups = GetPage(
    name: '/workGroups',
    page: () => WorkGroupsScreen(),
  );
  static GetPage thirdPersonInsurance = GetPage(
    name: '/thirdPersonInsurance',
    page: () => ThirdPersonInsuranceScreen(),
  );
}
