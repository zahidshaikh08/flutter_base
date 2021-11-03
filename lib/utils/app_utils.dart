import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/base/app.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static String formatDateFromApi(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("dd MMM yyyy");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateFromApi parsing date ---> $e");
      return '';
    }
  }

  static String formatDateFromApi2(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("dd MMM");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateFromApi2 parsing date ---> $e");
      return '';
    }
  }

  static String formatDateFromApi3(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("EEE, dd MMM yyyy");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateFromApi3 parsing date ---> $e");
      return '';
    }
  }

  static String formatTimeFromApi(String inputtedDate) {
    try {
      var inputFormat = DateFormat("HH:mm:ss");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("hh:mm a");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatTimeFromApi parsing time ---> $e");
      return '';
    }
  }

  static String formatDateAPI(String inputtedDate) {
    try {
      var inputFormat = DateFormat("dd MMM yyyy");
      var outputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateAPI parsing date ---> $e");
      return '';
    }
  }

  static String formatDateAndTimeForComments(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd HH:mm");
      var outputFormat = DateFormat("dd MMM yyyy hh:mm a");

      var date1 = inputFormat.parse(inputtedDate);

      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateAndTimeForComments parsing date ---> $e");
      return '';
    }
  }

  static DateTime currentDateTime() {
    final now = DateTime.now();
    return now;
  }

  static String currentDate() {
    try {
      var outputFormat = DateFormat("yyyy-MM-dd");
      return outputFormat.format(DateTime.now());
    } on Exception catch (e) {
      print("Error in currentDate parsing date ---> $e");
      return '';
    }
  }

  static String currentTime() {
    try {
      var outputFormat = DateFormat("HH:mm");
      return outputFormat.format(DateTime.now());
    } on Exception catch (e) {
      print("Error in currentTime parsing date ---> $e");
      return '';
    }
  }

  static bool isTimeBeforeCurrent(String date, String time) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      var date1 = DateTime.now();
      var date2 = inputFormat.parse(date + " " + time);

      if (date2.isBefore(date1)) {
        return true;
      }

      return false;
    } on Exception catch (e) {
      print("Error isTimeBeforeCurrent in parsing time ---> $e");
      return false;
    }
  }

  static String ddMmYyyy({DateTime? date1, DateTime? date2}) {
    try {
      var outputFormat;
      if (date1 != null) {
        outputFormat = DateFormat("dd MMMM yyyy");
        return outputFormat.format(date1);
      }

      if (date2 != null) {
        outputFormat = DateFormat("dd MM yyyy");
        return outputFormat.format(date1);
      }

      return "";
    } on Exception catch (e) {
      print("Error in ddMmYyyy parsing date ---> $e");
      return '';
    }
  }

  static String formatDateOnly(String inputtedDate, String format) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat(format);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print("Error in formatDateOnly parsing date ---> $e");
      return '';
    }
  }

  static String getMonthFromFullString(String month) {
    switch (month) {
      case "January":
        return "01";
      case "February":
        return "02";
      case "March":
        return "03";
      case "April":
        return "04";
      case "May":
        return "05";
      case "June":
        return "06";
      case "July":
        return "07";
      case "August":
        return "08";
      case "September":
        return "09";
      case "October":
        return "10";
      case "November":
        return "11";
      case "December":
        return "12";
      default:
        return "01";
    }
  }

  static String getDayFromInt(int month) {
    switch (month) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Monday";
    }
  }

  static int getIntFromDay(String day) {
    switch (day) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wednesday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      case "Sunday":
        return 7;
      default:
        return 1;
    }
  }

  static openMap(String lat, String lng) {
    final mapOptions = ['daddr=$lat,$lng', 'dir_action=navigate'].join('&');

    final mapUrl = 'https://www.google.com/maps?$mapOptions';
    launchUrlInBrowser(mapUrl);
  }

  static openEmail(String email) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: AppUtils.encodeQueryParameters(
        <String, String>{
          'subject': 'Send us your query!',
          'body': '',
        },
      ),
    );
    launchUrlInBrowser(emailLaunchUri.toString());
  }

  static call(String phone) {
    launchUrlInBrowser("tel:${phone.removeSpaces()}");
  }

  static Future<bool> launchUrlInBrowser(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );

        return true;
      } else {
        throw 'launchUrlInBrowser could not launch : $url';
      }
    } catch (e) {
      print('launchUrlInBrowser exception ====>>> $e');
      return false;
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<File?> pickImage({required ImageSource source}) async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    return await compressImage(selectedImage);
  }

  static Future<File?> compressImage(XFile? imageToCompress) async {
    if (imageToCompress == null) {
      return null;
    }

    final actualFile = File(imageToCompress.path);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    im.Image? image = im.decodeImage(actualFile.readAsBytesSync());
    im.copyResize(image!, width: 500, height: 500);

    return File('$path/img_$rand.jpg')..writeAsBytesSync(im.encodeJpg(image, quality: 85));
  }

  static shareMe(BuildContext context, String title, String content) {
    // final RenderBox box = context.findRenderObject();
    // Share.share(
    //   title,
    //   subject: content,
    //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    // );
  }

  static getFileName(String path) {
    var fileName = (path.split('/').last);
    return fileName;
  }

  static Future clearAppCacheData() async {
    var appDir = (await getTemporaryDirectory()).path;
    Directory(appDir).delete(recursive: true);
  }

  static Future clearPrefsExceptValues() async {
    final Set set = {};

    sharedPref.getKeys().toList().forEach((key) async {
      if (!set.contains(key)) await sharedPref.remove(key);
    });
  }

  static int calculateAge(String inputtedDate) {
    int age = 0;

    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);
      var current = DateTime.now();

      age = (current.year - date1.year).ceilToDouble().toInt();
    } on Exception catch (e) {
      print('calculateAge exception ====>>> $e');
    }
    return age;
  }

  //TODO convert UTC time to Local Timezone
  static String convertUTCToLocalTime(String inputtedDate) {
    try {
      // var dateUtc = inputtedDate+'.5Z';
      var dateUtc = inputtedDate;
      var strToDateTime = DateTime.parse(dateUtc.toString());
      final convertLocal = strToDateTime.toLocal();
      var newFormat = DateFormat("yy-MM-dd hh:mm:ss");
      String updatedDt = newFormat.format(convertLocal);
      return updatedDt;
    } on Exception catch (e) {
      print('convertUTCToLocalTime exception ====>>> $e');
      return '';
    }
  }

  // input 300 seconds output 05:00
  static String formatSecondsToTime(String inputtedDate) {
    try {
      var inputFormat = DateFormat("ss");
      var outputFormat = DateFormat("mm:ss");
      var date1 = inputFormat.parse(inputtedDate);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print('formatSecondsToTime exception ====>>> $e');
    }

    return '';
  }

  // input 300 seconds output 05:00
  static String formatSecondsToExpireTime(String inputtedDate) {
    try {
      var inputFormat = DateFormat("ss");
      var outputFormat = DateFormat("HH:mm:ss");
      var date1 = inputFormat.parse(inputtedDate);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      print('formatSecondsToTime exception ====>>> $e');
    }

    return "00:00:00";
  }

  // static String formatTimeStamp(Timestamp timestamp) {
  //   try {
  //     var outputFormat = DateFormat("dd-MMM-yyyy HH:mm");
  //     // var outputFormat = DateFormat("HH:mm");
  //
  //     var date = DateTime.fromMillisecondsSinceEpoch(timestamp?.millisecondsSinceEpoch);
  //
  //     return outputFormat.format(date) ?? "";
  //   } on Exception catch (e) {
  //     print("Error in formatTimeStamp parsing date ---> $e");
  //     return "";
  //   }
  // }

  static Duration getDifference(DateTime from, DateTime to) {
    try {
      return from.difference(to);
    } catch (e) {
      print("getDifference exception =====>>> $e");
    }

    return Duration.zero;
  }

  static void openWhatsapp() async {
    try {
      var whatsapp = "+919144040888";
      // var androidUrl = "whatsapp://send?phone=" + whatsapp + "&text=hello";
      var androidUrl = "whatsapp://send?text=hello";
      // var iOSUrl = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      var iOSUrl = "https://wa.me/text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(iOSUrl)) {
          await launch(iOSUrl, forceSafariVC: false);
        } else {
          showSnackbar("App not found!");
        }
      } else {
        if (await canLaunch(androidUrl)) {
          await launch(androidUrl);
        } else {
          showSnackbar("App not found!");
        }
      }
    } catch (e, stackTrace) {
      print("openWhatsapp exception =====>>> $e");
      print("openWhatsapp exception stackTrace =====>>> $stackTrace");
    }
  }
}
