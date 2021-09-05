import 'package:flutter/material.dart';

import 'package:app_delivery_3/presentation/03_sign_in/sign_in_page.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/l10n/l10n.dart';
// import 'package:app_delivery_3/l10n/l10n.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static String id = 'welcome-page';

  void _gotoSingInPage(BuildContext context) {
    Navigator.of(context).pushNamed(SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    SizeConfig().init(context);

    const style = TextStyle(
      color: Colors.white,
      fontSize: 16,
      // fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Stack(
        children: [
          InkWell(
              onTap: () => _gotoSingInPage(context),
              child: Container(color: Theme.of(context).primaryColor)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                l10n.welcomeMessage,
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
