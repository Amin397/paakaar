import 'package:paakaar/Models/Club/Insruance/InsuranceModels.dart';
import 'package:paakaar/Plugins/get/get.dart';
import 'package:paakaar/Utils/routing_utils.dart';

class MainInsuranceController extends GetxController {
  List<TipsClass> listOfTips = [
    TipsClass(
      id: 0,
      icon: 'form',
      title: 'استعلام',
      text:
          'وارد صفحه استعلام بیمه‌نامه مدنظر خود شده و اطلاعات و جزییات  درخواستی را در کادرهای مربوط به صورت صحیح جهت حصول بهترین نتیجه تکمیل نمایید',
    ),
    TipsClass(
      id: 1,
      icon: 'completeinfo',
      title: 'تکمیل اطلاعات',
      text:
          'با کلیک کردن روی دکمه استعلام، سامانه، فهرستی از شرکت‌های بیمه‌گر و شرایط مربوطه را جهت انتخاب متناسب با نیاز بیمه‌ای شما، نمایش خواهد داد.',
    ),
    TipsClass(
      id: 2,
      icon: 'onlineShopping',
      title: 'خرید آنلاین',
      text:
          'اطلاعات هویتی و جزییات بیمه‌نامه درخواستی را وارد نمایید. در صفحه پرداخت وجه بیمه‌نامه، مشخصات شرکت بیمه و پوشش‌های بیمه‌ای دیده می‌شوند.',
    ),
    TipsClass(
      id: 3,
      icon: 'map',
      title: 'دریافت',
      text:
          'دریافت کد رهگیری  به منزله پایان فرایند خرید بیمه‌نامه است. بیمه‌نامه شما در اسرع وقت به محل معین و مطلوب شما بدون هیچ هزینه ای ارسال خواهدشد.',
    ),
  ];

  List<InsuranceClass> listOfItems = [
    InsuranceClass(
      title: 'شخص ثالث',
      icon: 'carCrash',
      id: 2,
      flag: 'اقساطی',
      data: ClubRoutingUtils.thirdPersonInsurance,
    ),
    InsuranceClass(
      title: 'موتور',
      icon: 'motorbike',
      id: 1,
      // data: MotorcycleInsuranceScreen(),
    ),
    InsuranceClass(
      title: 'بدنه',
      icon: 'carinsurance',
      id: 0,
      // data: BadaneInsuranceScreen(),
    ),
    InsuranceClass(
      title: 'مسافرتی',
      icon: 'bag',
      id: 5,
      // data: TravelInsuranceScreen(),
    ),
    InsuranceClass(
      title: 'مسافرتی ویژه',
      icon: 'plane',
      id: 4,
      flag: 'آنلاین',

      // data: SpecialTravelScreen(),
    ),
    InsuranceClass(
      title: 'تجهیزات الکترونیک',
      icon: 'smartphone',
      id: 3, flag: 'آنلاین',

      // data: ElectronicMaterialScreen(),
    ),
    InsuranceClass(
      title: 'درمان',
      icon: 'stethoscope',
      id: 8, flag: 'اقساطی',

      // data: TreatmentScreen(),
    ),
    InsuranceClass(
      title: 'کرونا',
      icon: 'coronavirus',
      id: 7,
      flag: 'آنلاین',

      // data: CoronaVirusInsuranceScreen(),
    ),
    InsuranceClass(
      title: 'مسئولیت پزشکان',
      icon: 'doctor',
      id: 6,
    ),
    InsuranceClass(
      title: 'آتش سوزی و زلزله',
      icon: 'fire',
      id: 9,
      // data: FireAndEarthquakeInsuranceScreen(),
    ),
  ];
}
