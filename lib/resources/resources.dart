import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 226, 224, 239);
  static const Color secondary = Color.fromARGB(255, 209, 196, 233);
  static const Color tertiary = Color.fromARGB(255, 169, 165, 200);

  static const Color selectButton = Color.fromARGB(255, 224, 186, 205);
  static const Color favoriteIcon = Color(0xFFE57373);

  static const Color deleteDismissible = Color.fromARGB(255, 247, 177, 169);
  static const Color deleteIconDismissible = Colors.white;

  static const Color chioceChip = Color.fromARGB(255, 245, 245, 245);

  static const Color card = Color.fromARGB(5, 50, 50, 50);
  static const Color boxShadow = Color.fromARGB(128, 128, 128, 128);

  static const Color arrow = Colors.white;
  static const Color arrowCircle = Colors.white;
  static const Color snackBar = Colors.white;
}

class AppDimens {
  static const double textS = 16.0;
  static const double textM = 20.0;
  static const double textL = 24.0;
  static const double textXL = 32.0;

  static const double paddingMarginXXS = 5.0;
  static const double paddingMarginXS = 10.0;
  static const double paddingMarginSM = 15.0;
  static const double paddingMarginM = 20.0;
  static const double paddingMarginML = 25.0;
  static const double paddingMarginL = 30.0;
  static const double paddingMarginXL = 35.0;
  static const double paddingMarginXXL = 50.0;

  static const double widthXXS = 2.0;
  static const double widthXS = 10.0;
  static const double widthSM = 15.0;
  static const double widthM = 20.0;
  static const double widthML = 100.0;
  static const double widthL = 200.0;
  static const double widthXL = 400.0;
  static const double widthXXL = 600.0;
  static const double widthXXXL = 1000.0;

  static const double heightXXXS = 6.0;
  static const double heightXXS = 10.0;
  static const double heightXS = 20.0;
  static const double heightS = 50.0;
  static const double heightM = 100.0;
  static const double heightML = 120.0;
  static const double heightL = 250.0;

  static const double radiusXS = 2.0;
  static const double radiusSM = 5.0;
  static const double radiusM = 8.0;
  static const double radiusML = 20.0;
  static const double radiusL = 50.0;
}

class AppStrings {
  static const String homeNav = "Order your Tea";
  static const String homeCarousel = "Limited Edition";
  static const String homeBeverage = "Pick your Beverage";
  static const String tooltipFavoriteAdd = "Add to favorites";
  static const String tooltipFavoriteRemove = "Remove from favorites";
  static const String selectButton = "Select";

  static const String chioceChipSugar = "Sugar Level";
  static const String chioceChipTemperature = "Temeprature";
  static const String descriptionTitle = "Description";
  static const String snackBar = "Drink added!";
  static const String addButton = "Add to Cart";

  static const String cartNav = "Cart";
  static const String emptyCart = "The cart is empty";
  static const String totalPrice = "Total Price:";
  static const String quantity = "Quantity:";
  static const String alertTitle = "Order Sent";
  static const String confirmAlert = "Ok";
  static const String sendOrderButton = "Send Order";

  static const String favoritesNav = "Favorites";

  static const String permissionTitle = "Location Permission";
  static const String permissionContent =
      "The use of map requires location access. Please grant permission to calcolate distance";
  static const String permissionOptionSettings = "Go to settings";
  static const String infoNav = "Information";
  static const String titleApp = "Bobo Tea";
  static const String contact = "05731 255 6785";
  static const String workingHours = "7.00 am - 22.00 pm";
  static const String address = "Corso c.b. Cavour, 165, 47521 Cesena FC";
  static const String urlMeta = "https://www.instagram.com/bobo_tea2022/";
  static const String urlIns = "https://www.instagram.com/bobo_tea2022/";
  static const String urlWhatsapp = "https://www.instagram.com/bobo_tea2022/";
  static const String titleMapContainer = "Come and find us";
  static const String markerMap = "bobo_tea_marker";
  static const String titleMap = "Bobo Tea";
  static const String snippetMap = "Cesena, Italia";

  static const String homeNavLabel = "Menù";
  static const String infoNavLabel = "Info";
  static const String favoritesNavLabel = "Favorites";
  static const String cartNavLabel = "Cart";
  static const String orderNavLabel = "Order";
  static const String homeNavTooltip = "";
  static const String infoNavTooltip = "";
  static const String favoritesNavTooltip = "";
  static const String cartNavTooltip = "";
  static const String orderNavTooltip = "";

  static const String orderNav = "Orders";
  static const String emptyOrder = "No orders found";
  static const String errorDeleting = "Error deleting order";
}

class AppTextStyles {
  static final TextStyle small = GoogleFonts.mukta(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 96, 96, 96),
      fontSize: AppDimens.textS,
    ),
  );

  static final TextStyle smallBold = GoogleFonts.mukta(
    textStyle: const TextStyle(
        color: Colors.white,
        fontSize: AppDimens.textS,
        fontWeight: FontWeight.bold),
  );

  static final TextStyle medium = GoogleFonts.mukta(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: AppDimens.textM,
    ),
  );

  static final TextStyle mediumBold = GoogleFonts.mukta(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: AppDimens.textM,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle mediumBoldBlack = GoogleFonts.mukta(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textM,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle large = GoogleFonts.mukta(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textL,
    ),
  );

  static final TextStyle largeBold = GoogleFonts.mukta(
    textStyle: const TextStyle(
        color: Colors.black,
        fontSize: AppDimens.textL,
        fontWeight: FontWeight.bold),
  );

  static final TextStyle appBar =
      GoogleFonts.courgette(fontSize: AppDimens.textL, color: Colors.white);
}
