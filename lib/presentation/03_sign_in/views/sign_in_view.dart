import 'package:app_delivery_3/presentation/05_home/home_page.dart';
import 'package:app_delivery_3/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/l10n/l10n.dart';

class SignInview extends StatelessWidget {
  const SignInview({Key? key}) : super(key: key);

  void _gotoHomePage(BuildContext context) {
    Navigator.of(context).pushNamed(HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signIn),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        textTheme: Theme.of(context).textTheme,
        iconTheme: const IconThemeData(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          children: [
            // SizedBox(height: SizeConfig.screenHeight * 0.0),
            // bloque 1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.signInWelcomeTo,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
                Text(l10n.signInMessage1),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            // bloque 2
            BuildTextField(
              hintText: l10n.signInUsername,
              prefixIconData: Icons.person_outline,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            BuildTextField(
              hintText: l10n.signInPassword,
              prefixIconData: Icons.lock_outline,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRememberMe(context, true, l10n.signInRemenberMe),
                _buildForgotPassword(context, l10n.signInForgotPassword),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            //
            CustomButton(
              onPressed: () => _gotoHomePage(context),
              height: SizeConfig.screenHeight * 0.067,
              bold: true,
              child: Text(l10n.signIn),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            RichText(
              text: TextSpan(
                  text: l10n.signInDontHaveAccount,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' ${l10n.signUp}',
                        style: TextStyle(color: Theme.of(context).primaryColor)
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = () {
                        //     // navigate to desired screen
                        //   }
                        )
                  ]),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            Text(l10n.signInOr),

            SizedBox(height: SizeConfig.screenHeight * 0.025),
            CustomButton(
              onPressed: () {},
              height: SizeConfig.screenHeight * 0.059,
              color: AppColors.facebookColor,
              image: 'assets/images/facebook.png',
              child: Text(l10n.signInFacebook),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.026),
            CustomButton(
              onPressed: () {},
              height: SizeConfig.screenHeight * 0.059,
              color: AppColors.googleColor,
              image: 'assets/images/google.png',
              child: Text(l10n.signInGoogle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberMe(BuildContext context, bool value, String text) {
    return Row(
      children: [
        Switch(
          value: value,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {},
        ),
        Text(text),
      ],
    );
  }

  Widget _buildForgotPassword(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    this.sufixIcon,
    this.textFieldColor,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final Widget? sufixIcon;
  final Color? textFieldColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        color: textFieldColor ?? Colors.grey[200],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIconData,
            size: 30,
          ),
          // suffixIcon: sufixIcon,
          suffixIcon: sufixIcon,
          isDense: true,
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
