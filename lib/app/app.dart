// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:app_delivery_3/presentation/02_welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:app_delivery_3/l10n/l10n.dart';
import 'package:app_delivery_3/app/theme_utils.dart';
import 'package:app_delivery_3/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.red,
        // systemNavigationBarIconBrightness: Brightness.dark,
        // systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    // SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routes: ruotes,
      initialRoute: WelcomePage.id,
    );
  }
}
