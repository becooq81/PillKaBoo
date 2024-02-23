import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PKBAppState extends ChangeNotifier {
  static PKBAppState _instance = PKBAppState._internal();

  factory PKBAppState() {
    return _instance;
  }

  PKBAppState._internal();

  static void reset() {
    _instance = PKBAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _userAllergies =
          prefs.getStringList('pkb_userAllergies') ?? _userAllergies;
    });
    _safeInit(() {
      _primaryColor =
          _colorFromIntValue(prefs.getInt('pkb_primaryColor')) ?? _primaryColor;
      _secondaryColor =
          _colorFromIntValue(prefs.getInt('pkb_secondaryColor')) ?? _secondaryColor;
      _tertiaryColor =
          _colorFromIntValue(prefs.getInt('pkb_tertiaryColor')) ?? _tertiaryColor;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String infoChild = '';
  String infoExprDate = '';
  String infoIngredient = '';
  String infoUsage = '';
  String infoHowToTake = '';
  String infoWarning = '';
  String infoCombo = '';
  String infoSideEffect = '';
  String infoMedName = '';
  int pourAmount = 0;
  String slotOfDay = '';
  String infoPrescribedDate = '';


  Color _primaryColor = const Color(0xFFF9E000);
  Color get primaryColor => _primaryColor;
  set primaryColor(Color value) {
    _primaryColor = value;
    prefs.setInt('pkb_primaryColor', value.value);
  }

  Color _secondaryColor = Colors.white;
  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color value) {
    _secondaryColor = value;
    prefs.setInt('pkb_secondaryColor', value.value);
  }

  Color _tertiaryColor = Colors.black;
  Color get tertiaryColor => _tertiaryColor;
  set tertiaryColor(Color value) {
    _tertiaryColor = value;
    prefs.setInt('pkb_tertiaryColor', value.value);
  }

  bool isRestAmountRecognized = false;


  String foundAllergies = '';


  List<String> _userAllergies = [];
  List<String> get userAllergies => _userAllergies;
  set userAllergies(List<String> value) {
    _userAllergies = value;
    prefs.setStringList('pkb_userAllergies', value);
  }

  void addToUserAllergies(String value) {
    _userAllergies.add(value);
    prefs.setStringList('pkb_userAllergies', _userAllergies);
  }

  void removeFromUserAllergies(String value) {
    _userAllergies.remove(value);
    prefs.setStringList('pkb_userAllergies', _userAllergies);
  }

  void removeAtIndexFromUserAllergies(int index) {
    _userAllergies.removeAt(index);
    prefs.setStringList('pkb_userAllergies', _userAllergies);
  }

  void updateUserAllergiesAtIndex(
      int index,
      String Function(String) updateFn,
      ) {
    _userAllergies[index] = updateFn(_userAllergies[index]);
    prefs.setStringList('pkb_userAllergies', _userAllergies);
  }

  void insertAtIndexInUserAllergies(int index, String value) {
    _userAllergies.insert(index, value);
    prefs.setStringList('pkb_userAllergies', _userAllergies);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}