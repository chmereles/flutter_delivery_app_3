import 'package:flutter/material.dart';

import 'package:app_delivery_3/app/theme_utils.dart';
import 'package:app_delivery_3/config/app_constants.dart';
import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/l10n/l10n.dart';

class SignInview extends StatelessWidget {
  const SignInview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // final textFieldColor = Colors.grey[200];

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
            SizedBox(height: SizeConfig.screenHeight * 0.02),
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
              iconData: Icons.person_outline,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            BuildTextField(
              hintText: l10n.signInPassword,
              iconData: Icons.lock_outline,
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
              onPressed: () {},
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

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.bold = false,
    this.height,
    this.color,
    this.image,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final bool bold;
  final double? height;
  final Color? color;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: double.infinity, height: height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color ?? Theme.of(context).primaryColor,
          textStyle: TextStyle(
            fontWeight: bold ? FontWeight.bold : null,
          ),
        ),
        // child: child,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(image!)),
              ),
            Align(child: child),
          ],
        ),
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    this.textFieldColor,
    required this.iconData,
    required this.hintText,
  }) : super(key: key);

  final Color? textFieldColor;
  final IconData iconData;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            size: 30,
          ),
          // contentPadding: EdgeInsets.only(
          //     left: 15, top: editHeight / 2, right: buttonWidth + 10),
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
