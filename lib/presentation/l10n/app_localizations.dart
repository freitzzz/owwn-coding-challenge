import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:owwn_coding_challenge/presentation/l10n/messages/messages_all.dart';

const supportedLocales = [
  Locale('en'),
  Locale('de'),
];

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  final String localeName;

  const AppLocalizations(this.localeName);

  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: 'The word hello',
      locale: localeName,
    );
  }

  static Future<AppLocalizations> load(Locale locale) {
    final name = '${locale.countryCode}'.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
