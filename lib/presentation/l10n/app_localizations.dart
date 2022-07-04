import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:owwn_coding_challenge/models/errors/errors.dart';
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

  String get authenticate {
    return Intl.message(
      'Authenticate',
      name: 'authenticate',
      desc: 'The word authenticate',
      locale: localeName,
    );
  }

  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: 'The word e-mail',
      locale: localeName,
    );
  }

  String get invalidCredentialsOnAuthenticationError {
    return Intl.message(
      'Credentials not authorized.',
      name: 'invalidCredentialsOnAuthenticationError',
      desc: 'Describes the reason for the error case of invalid credentails',
      locale: localeName,
    );
  }

  String get invalidSessionOnAuthenticationError {
    return Intl.message(
      'Credentials not authorized.',
      name: 'invalidCredentialsOnAuthenticationError',
      desc: 'Describes the reason for the error case of invalid credentails',
      locale: localeName,
    );
  }

  String get unknownErrorOnAuthenticationError {
    return Intl.message(
      "An issue occurred while processing some data. Don't worry, this is an issue on our end.",
      name: 'unknownErrorOnAuthenticationError',
      desc: 'Describes the reason for an unknown authentication error',
      locale: localeName,
    );
  }

  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: 'The word active',
      locale: localeName,
    );
  }

  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: 'The word inactive',
      locale: localeName,
    );
  }

  String get usersTitle {
    return Intl.message(
      'Users',
      name: 'usersTitle',
      desc: 'Title of users page',
      locale: localeName,
    );
  }

  String get statisticsNotAvailable {
    return Intl.message(
      'No statistics available.',
      name: 'statisticsNotAvailable',
      desc: 'Label that informs that an user has no statistics',
      locale: localeName,
    );
  }

  String get saveCaps {
    return Intl.message(
      'SAVE',
      name: 'saveCaps',
      desc: 'The word save in upper-case',
      locale: localeName,
    );
  }

  String authenticationError(final AuthenticationError error) {
    switch (error.runtimeType) {
      case InvalidCredentialsAuthenticationError:
        return invalidCredentialsOnAuthenticationError;
      case InvalidSessionAuthenticationError:
        return invalidSessionOnAuthenticationError;
      default:
        return unknownErrorOnAuthenticationError;
    }
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
