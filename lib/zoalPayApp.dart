import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/Mint_Payment_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/Safir_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/TUTIA_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/About_Us_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Card_Balance_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Card_Details_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Change_IPIN_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Entertainment_Card_History_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Favourites_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Generate_IPIN_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Transaction_History_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Electrictiy_Services_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Entertainment_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/GovermentServicesPages/E-Invoice_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Transfer_Card_To_Card_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Voucher_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Telecom_Services_Page.dart';
import 'package:ZoalPay/pages/HomePagePages/LoginPage.dart';
import 'package:ZoalPay/pages/HomePagePages/NewAccountPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'lang/Localization.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/Dal_Payment_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/GovermentServicesPages/Customs_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/GovermentServicesPages/E15_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/GovermentServicesPages/Higher_Eduction_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/Goverment_Services_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/QR_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/Scan_&_Pay_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/TelecomServicesPages/Bill_Payment_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/TelecomServicesPages/Mobile_TOPUP_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/TelecomServicesPages/Sudani_ADSL_Page.dart';
import 'pages/AfterLoggingInPages/CardServicesPages/Zoal_Khair_Page.dart';
import 'pages/AfterLoggingInPages/Card_Services_Page.dart';
import 'pages/Home_Page.dart';
import 'package:ZoalPay/pages/HomePagePages/validate_otp_page.dart';

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  build(context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: HomePage.pageName,
        routes: {
          HomePage.pageName: (context) => HomePage(),
          LoginPage.pageName: (context) => LoginPage(),
          NewAccountPage.pageName: (context) => NewAccountPage(),
          CardServicesPage.pageName: (context) => CardServicesPage(),
          ZoalKhairPage.pageName: (context) => ZoalKhairPage(),
          DalPaymentPage.pageName: (context) => DalPaymentPage(),
          TelecomSevicesPage.pageName: (context) => TelecomSevicesPage(),
          GovermentServices.pageName: (context) => GovermentServices(),
          ElectricityServicesPage.pageName: (context) =>
              ElectricityServicesPage(),
          BillPaymentPage.pageName: (context) => BillPaymentPage(),
          MobileTopUpPage.pageName: (context) => MobileTopUpPage(),
          SudaniAdSlPage.pageName: (context) => SudaniAdSlPage(),
          Customs.pageName: (context) => Customs(),
          E15.pageName: (context) => E15(),
          HigherEducation.pageName: (context) => HigherEducation(),
          QRPage.pageName: (context) => QRPage(),
          ScanAndPayPage.pageName: (context) => ScanAndPayPage(),
          EInvoicePage.pageName: (context) => EInvoicePage(),
          MoneyTransferPage.pageName: (context) => MoneyTransferPage(),
          TransferCardToCardPage.pageName: (context) =>
              TransferCardToCardPage(),
          VoucherPage.pageName: (context) => VoucherPage(),
          BillerSPage.pageName: (context) => BillerSPage(),
          SafirPage.pageName: (context) => SafirPage(),
          TUTIAPage.pageName: (context) => TUTIAPage(),
          MintPaymentPage.pageName: (context) => MintPaymentPage(),
          EntertainmentPage.pageName: (context) => EntertainmentPage(),
          GenerateIPINPage.pageName: (context) => GenerateIPINPage(),
          CardBalancePage.pageName: (context) => CardBalancePage(),
          CardDetailsPage.pageName: (context) => CardDetailsPage(),
          ChangeIPINPage.pageName: (context) => ChangeIPINPage(),
          FavouritesPage.pageName: (context) => FavouritesPage(),
          TransactionHistoryPage.pageName: (context) =>
              TransactionHistoryPage(),
          EntertainmentCardHistoryPage.pageName: (context) =>
              EntertainmentCardHistoryPage(),
          AboutUsPage.pageName: (context) => AboutUsPage(),
          ValidateOtpPage.pageName: (context) => ValidateOtpPage(),
        });
  }
}
