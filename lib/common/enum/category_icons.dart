import 'package:flutter/material.dart';

enum CategoryIcons {
  restaurant,
  menu,
  history,
  home,
  settings,
  star,
  favorite,
  person,
  email,
  phone,
  locationOn,
  calendarToday,
  cameraAlt,
  musicNote,
  shoppingCart,
  work,
  school,
  carRental,
  question,
}

extension CategoryIconsExtension on CategoryIcons {
  IconData get iconData {
    switch (this) {
      case CategoryIcons.menu:
        return Icons.menu;
      case CategoryIcons.history:
        return Icons.history;
      case CategoryIcons.home:
        return Icons.home;
      case CategoryIcons.settings:
        return Icons.settings;
      case CategoryIcons.star:
        return Icons.star;
      case CategoryIcons.favorite:
        return Icons.favorite;
      case CategoryIcons.person:
        return Icons.person;
      case CategoryIcons.email:
        return Icons.email;
      case CategoryIcons.phone:
        return Icons.phone;
      case CategoryIcons.locationOn:
        return Icons.location_on;
      case CategoryIcons.calendarToday:
        return Icons.calendar_today;
      case CategoryIcons.cameraAlt:
        return Icons.camera_alt;
      case CategoryIcons.musicNote:
        return Icons.music_note;
      case CategoryIcons.shoppingCart:
        return Icons.shopping_cart;
      case CategoryIcons.work:
        return Icons.work;
      case CategoryIcons.school:
        return Icons.school;
      case CategoryIcons.carRental:
        return Icons.car_rental;
      case CategoryIcons.restaurant:
        return Icons.restaurant;
      case CategoryIcons.question:
        return Icons.help_outline;
    }
  }
}
