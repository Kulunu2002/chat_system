
import 'package:get/get.dart';

class LanguageConfig extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Welcome back': 'Welcome!', 
          'User Name': 'User Name',
          'I already have an account': 'I already have an account',
          "I don't have an account": "I don't have an account",
          'password':'password',
          'Change Language':'Change Language',
          'Language':'Language',
          'Settings':'Settings'
        },
        'si_LK': {
          'Welcome back': "ආපසු සාදරයෙන් පිළිගනිමු",
          'User Name': 'පරිශීලක නාමය',
          'I already have an account': 'මට දැනටමත් ගිණුමක් තියෙනවා',
          "i don't have an account": 'මට ගිණුමක් නැහැ',
          'password':'මුරපදය',
          'Change Languge':' භාෂාව මාරුකරන්න',
          'Language':'භාෂාව',
          'Settings':'සැකසුම්'
        }
      };
}
