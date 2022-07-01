import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thegreatkabab/bookingstatus.dart';
import 'package:thegreatkabab/bookseat.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/contact.dart';
import 'package:thegreatkabab/custom_animated_bottom_bar.dart';
import 'package:thegreatkabab/dprbooking.dart';
import 'package:thegreatkabab/gallery.dart';
import 'package:thegreatkabab/menu.dart';
import 'package:thegreatkabab/network/api_service.dart';
import 'package:thegreatkabab/notification.dart';
import 'package:thegreatkabab/reviews.dart';
import 'package:thegreatkabab/signup.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

enum ConfirmAction { Cancel, Accept}

class HomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var bottomNotification=4;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  var emojiRegexp =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';
  TextEditingController topicController = new TextEditingController();
  final _inactiveColor = Colors.grey;
  TextStyle style = TextStyle(fontFamily:'Poppins', fontSize: 16.0);
  var _IsLogin;
  SFData sfdata= SFData();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool restu=true,vegPic=false,nonvegPicfalse=false;
  static const colors= AppColors();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<int> getpay = sfdata.getLogin(context);
    getpay.then((data) {
      setState(() {
        _IsLogin=data;
      });
    },onError: (e) {
      print(e);
    });

    hotelData();
  }

  //////////////////  Hotel Details  //////////////////////
  Future<Null> hotelData() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .hotelData(colors.hotelId)
        .then((result) {
      setState(() {
        if(result.data.isNotEmpty){
        sfdata.saveHotelData(context,result.data[0].name, result.data[0].logo, result.data[0].address, result.data[0].phoneNumber, result.data[0].email, result.data[0].seatDiscountInPercent, result.data[0].itemDiscountInPercent, result.data[0].firstTimeDiscountInPercent, result.data[0].contactPerson);
        }else{
        }

      });
    }).catchError((error) {

      // EasyLoading.dismiss();
      print(error);
    });
  }


  Widget _logoutBadge() {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: IconButton(icon: Icon(Icons.power_settings_new), onPressed: () async {
          _asyncConfirmDialognew(context);
        }
        )
    );
  }


//////////////Logout dialog//////
  Future<Future<ConfirmAction?>> _asyncConfirmDialognew(BuildContext context) async {
    SFData sfdata= SFData();
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Logout'),
          content: const Text(
              'Do you really want to logout?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text('Logout',style: TextStyle(color: Colors.red)),
              onPressed: () {
                //sfdata.removeAll(context);
                sfdata.saveLoginDataToSF(context,"0","",0);
                Navigator.of(context).pop(ConfirmAction.Accept);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => SignUp()),
                  ModalRoute.withName('/'),
                );
              },
            )
          ],
        );
      },
    );
  }

  _drawerMenus(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60.0,
        ),
        Container(
          height: 60.0,
          child: Row(
            children: [
              Expanded(
                flex:1,
                child: Image.asset("assets/logo.png",
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Expanded(
                flex:3,
                child:Text(""),
              ),
              Expanded(
                  flex:1,
                child: new IconButton(
                           icon: Icon(Icons.close, color: Colors.white,size: 30.0,),
                           onPressed: () {
                             _scaffoldKey.currentState!.openEndDrawer();
                           },
                   )



              ),
            ],
          ),
        ),
        Container(
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/drawerbanner.png", fit: BoxFit.cover),
        ),

        Expanded(
          child:MediaQuery.removePadding(
            context: context,
            removeTop: true,
             child: ListView(
              children: <Widget>[
                 ListTile(
          leading:Image.asset("assets/menu_done.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Home",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dtwo.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Book Seat",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookSeat()),
            );

          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dthree.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Book PDR",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DprBooking()));
           /* final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notifications()),
            );*/

          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dfour.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Book Status",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingStatus()),
            );

          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dfive.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Menu Items",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuView()),
            );

          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dsix.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Gallery",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            Navigator.push(
                     context, MaterialPageRoute(builder: (context) => GalleryView()));


          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dseven.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Notification",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notifications()),
            );

          },
        ),
                 Divider(color: colors.purpals,),
                 ListTile(
          leading:Image.asset("assets/menu_dnine.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text("Contact",style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.0,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () async {
            ///  Comment //////
            Navigator.of(context).pop();
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUs()),
            );

          },
        ),
                 Divider(color: colors.purpals,),

      ],
    ),
          ),




        ),

        Container(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Text(colors.appversion,style: TextStyle(color: colors.white),),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colors.white,
        /*drawer: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/header.jpeg"),
                        fit: BoxFit.cover)),
                child: Text("Header"),
              ),
              ListTile(
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),*/

        drawer: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
           // color: colors.redtheme,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xff662b99),
                      const Color(0xff6e26d2),
                     // Colors.deepPurple, Colors.deepPurpleAccent
                    ])),//<-- SEE HERE
            child: _drawerMenus(),
          ),

        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90, // default is 56
          //toolbarOpacity: 1,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgappbar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              SizedBox(height: 28.0,)
              // Your widgets here
            ],
          ),

          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.more_vert, color: Colors.white),
                ),
                SizedBox(height: 30.0,)
                // Your widgets here
              ],
            ),


          ],
        ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar()
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: colors.redtheme,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Image.asset("assets/homeicon.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text('Home',style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:  Image.asset("assets/iconmenu.png",
          width: 30.0,
          height: 30.0,
          ),
          title: Text('Menu',style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:  Image.asset("assets/grlleryicon.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text(
            'Gallery',style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),
          ),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:  Image.asset("assets/noticon.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text('Notification',style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
          ),),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        /*BottomNavyBarItem(
          icon:  Image.asset("assets/contacticon.png",
            width: 30.0,
            height: 30.0,
          ),
          title: Text('Contact'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),*/
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      Container(
        color: Colors.white,
        child: getHomePage(),
      ),
      Container(
        color: Colors.white,
        child: getMenuPage(),
      ),
      Container(
        color: Colors.white,
        child: getGalleryPage(),
      ),
      Container(
        color: Colors.white,
        child: getNotificationPage(),
      ),
      /*Container(
        color: Colors.white,
        child: getContactPage(),
      ),*/
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }


  /////////////////////////////////// HOME PAGE ///////////////////////////
  Widget getHomePage(){
    return SingleChildScrollView(
      child:  Container(
        child: Padding(padding:const EdgeInsets.all(7.0),
          child: Column(
              children:[
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                //////////////////////////////////   MENU ///////////////
                Row(
                  children: [

                    Expanded(
                      child: SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => BookSeat()));
                              /* if(_IsPay==1){
                              CoolAlert.show(
                                barrierDismissible: true,
                                context: context,
                                type: CoolAlertType.warning,
                                backgroundColor: colors.redtheme,
                                text: 'Already submit you profile',
                                // autoCloseDuration: Duration(seconds: 2),
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);


                                },
                                confirmBtnText: 'Submit again your CV',
                              );
                            }else{

                            }*/

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/sheet.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Book Your Seat Now",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => DprBooking()));

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset( "assets/pdrd.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Book PDR Now",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child:SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => MenuView()));
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset("assets/menud.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Our Menu",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                  ],
                ),
                //////////////////////////////////   MENU ///////////////
               // const SizedBox(height: 20.0),
                Row(
                  children: [

                    Expanded(
                      child: SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => GalleryView()));

                              /* if(_IsPay==1){
                              CoolAlert.show(
                                barrierDismissible: true,
                                context: context,
                                type: CoolAlertType.warning,
                                backgroundColor: colors.redtheme,
                                text: 'Already submit you profile',
                                // autoCloseDuration: Duration(seconds: 2),
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);


                                },
                                confirmBtnText: 'Submit again your CV',
                              );
                            }else{

                            }*/

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/galleryd.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Photo Gallery",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => Notifications()));
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset( "assets/notid.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Notification",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child:SizedBox(
                        width: 100,
                        height: 170,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => BookingStatus()));
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset("assets/bookd.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Booking Status",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                  ],
                ),
                //const SizedBox(height: 20.0),
                Row(
                  children: [

                    Expanded(
                      child: SizedBox(
                        width: 100,
                        height: 140,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => Reviews()));
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset( "assets/reviewd.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Reviews",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child:SizedBox(
                        width: 100,
                        height: 140,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ContactUs()));
                            },
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:  Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset("assets/contd.png", fit: BoxFit.cover),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Contact Us",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                  ],
                ),


                Container(
                  height: 150.0,

                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        height: 150,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:Image.asset("assets/restone.jpg", fit: BoxFit.cover),

                        ),
                      ),

                      SizedBox(
                        width: 150,
                        height: 150,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:Image.asset("assets/resttwo.jpeg", fit: BoxFit.cover),

                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 150,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:Image.asset("assets/restthree.jpg", fit: BoxFit.cover),

                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 150,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:Image.asset("assets/restone.jpg", fit: BoxFit.cover),

                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 150,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child:Image.asset("assets/resttwo.jpeg", fit: BoxFit.cover),

                        ),
                      ),

                    ],
                  ),
                ),



                const SizedBox(height: 20.0),

              ]
          ),
        ),
      ),
    );
  }



  /////////////////////////////////// CONTACT PAGE ///////////////////////////
  Widget getContactPage(){
    return SingleChildScrollView(
      child:   Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg4.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      Expanded(
                        flex: 1,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           SizedBox(
                              height: 150.0,
                              width: 150.0,
                              child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                            ),
                          ],
                        ),

                      ),

                      Expanded(
                        flex: 4,
                        child:Stack(
                          children: [
                            Container(
                              decoration:const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/shapenew.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),

                            Visibility(
                              visible: true,
                              child:  Padding(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset( "assets/contact1.png", fit: BoxFit.contain),
                                            ),
                                          ),



                                        ),

                                        Expanded(
                                          flex:2,
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("CONTACT PERSON",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.redtheme,fontSize: 14.0,fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                              Text("Prabhakar Kumar Sign",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.black,fontSize: 14.0,fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),

                                      ],),
                                    Divider(

                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset( "assets/contact2.png", fit: BoxFit.contain),
                                            ),
                                          ),



                                        ),

                                        Expanded(
                                          flex:2,
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("MOBILE",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.redtheme,fontSize: 14.0,fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                              Text("8000000000",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.black,fontSize: 14.0,fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),

                                      ],),
                                    Divider(

                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset( "assets/contact3.png", fit: BoxFit.contain),
                                            ),
                                          ),



                                        ),

                                        Expanded(
                                          flex:2,
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("EMAIL",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.redtheme,fontSize: 14.0,fontFamily:'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                              Text("tgfk@gmail.com",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(color: colors.black,fontSize: 14.0,fontFamily:'Poppins',
                                                      fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),

                                      ],),

                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),





                          ],
                        ),






                      ),

                    ]
                )




              ]
          )
      )
    );
  }

  /////////////////////////////////// MENU PAGE ///////////////////////////
  Widget getMenuPage(){
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(padding:const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                             "Menu Items",maxLines: 2,textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'Poppins',
                               fontWeight: FontWeight.w600,
                               fontSize: 16.0,
                               color: colors.redthemenew,
                             ),
                           ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center
                                ,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon1.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Non Veg",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon2.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Veg",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon3.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Salad",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center
                                ,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon4.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Dal",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon5.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Dessert",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                    Expanded(
                      child: SizedBox(
                        width: 180,
                        height: 120,
                        child:  Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child:InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:Image.asset("assets/menu_item_icon6.png", fit: BoxFit.contain),
                                  ),
                                  //SizedBox(height: 5),
                                  Text(
                                    "Drinks",maxLines: 2,textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: colors.redthemenew,
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),

                        ),
                      ),


                    ),
                  ],
                ),

                const SizedBox(height: 20.0),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 9),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(12.0),
                      color: colors.redtheme,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 60.0,
                        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {

                        },
                        child: Text("Non Veg",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16.0)),
                      ),
                    )
                ),

              ],
            ),
          ),


        )
    );
  }


  /////////////////////////////////// NOTIFICATION PAGE ///////////////////////////
  Widget getGalleryPage(){

    return SingleChildScrollView(
        child: Container(
          color: colors.white,
          height: MediaQuery.of(context).size.height,
          child: Padding(padding:const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding:const EdgeInsets.all(10.0),
                      child: Text(
                        "Gallery",textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: colors.redthemenew,
                        ),
                      ),
                    ),
                  ],
                ),

             SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       restu=true;
                       vegPic=false;
                       nonvegPicfalse=false;
                     });


                   },
                   child:Container(
                     margin: EdgeInsets.all(0.0),
                     decoration: BoxDecoration(
                       color:restu==true?colors.purpals:colors.greylight,
                       borderRadius: BorderRadius.only(
                         topRight: Radius.circular(10.0),
                         topLeft: Radius.circular(10.0),
                       ),
                     ),
                     child: Padding(padding:const EdgeInsets.all(10.0),
                       child:  Text(
                         "Restaurant",maxLines: 2,textAlign: TextAlign.center,
                         style: TextStyle(
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.w500,
                           fontSize: 14.0,
                           color: restu==true?colors.redthemenew:colors.grey,
                         ),
                       ),
                     ),



                   ),
                 ),
                 SizedBox(width: 5.0,),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       restu=false;
                       vegPic=true;
                       nonvegPicfalse=false;
                     });

                   },
                   child:Container(
                     margin: EdgeInsets.all(0.0),
                     decoration: BoxDecoration(
                       color: vegPic==true?colors.purpals:colors.greylight,
                       borderRadius: BorderRadius.only(
                         topRight: Radius.circular(10.0),
                         topLeft: Radius.circular(10.0),
                       ),
                     ),
                     child: Padding(padding:const EdgeInsets.all(10.0),
                       child:  Text(
                         "Veg Food",maxLines: 2,textAlign: TextAlign.center,
                         style: TextStyle(
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.w500,
                           fontSize: 14.0,
                           color: vegPic==true?colors.redthemenew:colors.grey,
                         ),
                       ),
                     ),



                   ),
                 ),
                 SizedBox(width: 5.0,),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       restu=false;
                       vegPic=false;
                       nonvegPicfalse=true;
                     });

                   },
                   child: Container(
                     margin: EdgeInsets.all(0.0),
                     decoration: BoxDecoration(
                       color: nonvegPicfalse==true?colors.purpals:colors.greylight,
                       borderRadius: BorderRadius.only(
                         topRight: Radius.circular(10.0),
                         topLeft: Radius.circular(10.0),
                       ),
                     ),
                     child: Padding(padding:const EdgeInsets.all(10.0),
                       child:  Text(
                         "Non Veg Food",maxLines: 2,textAlign: TextAlign.center,
                         style: TextStyle(
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.w500,
                           fontSize: 14.0,
                           color: nonvegPicfalse==true?colors.redthemenew:colors.grey,
                         ),
                       ),
                     ),



                   ),
                 ),


               ],
             ),

              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                   color: colors.purpals,
                   child: Text(
                     "Gallery",textAlign: TextAlign.start,
                     style: TextStyle(
                       fontFamily: 'Poppins',
                       fontWeight: FontWeight.w600,
                       fontSize: 16.0,
                       color: colors.redthemenew,
                     ),
                   ),
                 ),
               ],
             ),







              ],
            ),
          ),


        )
    );
  }

  /////////////////////////////////// NOTIFICATION PAGE ///////////////////////////
  Widget getNotificationPage(){
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(padding:const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Notification",maxLines: 2,textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: colors.redthemenew,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(padding:const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset('assets/bell_icon.png'),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("01-02-22",
                                  textAlign: TextAlign.start,
                                  style: style.copyWith(color: colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                              Text("Message Here.....",
                                  textAlign: TextAlign.start,
                                  style: style.copyWith(color: Colors.black45, fontWeight: FontWeight.w400,fontSize: 14.0)),
                            ]) ,
                      ),

                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: Image.asset('assets/down_arrow.png'),
                        ),
                      ),
                    ],
                  ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(padding:const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset('assets/bell_icon.png'),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("01-02-22",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                                Text("Message Here.....",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: Colors.black45, fontWeight: FontWeight.w400,fontSize: 14.0)),
                              ]) ,
                        ),

                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset('assets/down_arrow.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(padding:const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset('assets/bell_icon.png'),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("01-02-22",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                                Text("Message Here.....",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: Colors.black45, fontWeight: FontWeight.w400,fontSize: 14.0)),
                              ]) ,
                        ),

                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset('assets/down_arrow.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(padding:const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset('assets/bell_icon.png'),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("01-02-22",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                                Text("Message Here.....",
                                    textAlign: TextAlign.start,
                                    style: style.copyWith(color: Colors.black45, fontWeight: FontWeight.w400,fontSize: 14.0)),
                              ]) ,
                        ),

                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset('assets/down_arrow.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),


        )
    );
  }



}