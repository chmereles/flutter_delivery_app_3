import 'package:app_delivery_3/config/size_config.dart';
import 'package:app_delivery_3/presentation/my_address/my_address_page.dart';
import 'package:app_delivery_3/presentation/my_address/save_address_page.dart';
import 'package:app_delivery_3/presentation/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';

final _avatarHeight = SizeConfig.screenHeight * 0.3;
final _listHeight = SizeConfig.screenHeight * 0.7;

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  Widget _buildAvatar(BuildContext context) {
    const radius = 80.0;
    final cameraColor = Theme.of(context).colorScheme.primary;

    return Container(
      height: _avatarHeight,
      // width: 200,
      // color: Colors.amber,
      child: Stack(
        children: [
          Align(
            // alignment: Alignment.center,
            child: CircleAvatar(
              radius: radius,
              // backgroundColor: Color(0xffFDCF09),
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
          Align(
            alignment: const Alignment(0.5, 0),
            child: CircleAvatar(
              radius: radius / 3,
              backgroundColor: cameraColor,
              child: const Icon(Icons.add_a_photo_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    IconData iconData,
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 45,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 20),
            Text(text),
            const Spacer(),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }

  void _goToLocation(BuildContext context) {
    Navigator.of(context).pushNamed(SaveAddressPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(title: Text('')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //
              _buildAvatar(context),

              //
              SizedBox(
                height: _listHeight,
                child: Card(
                  child: Column(
                    children: [
                      _buildRow(
                          context, Icons.person_outline, 'Usuario', () {}),
                      const Divider(),
                      _buildRow(context, Icons.lock_outline, 'Password', () {}),
                      const Divider(),
                      _buildRow(context, Icons.email_outlined, 'Email', () {}),
                      const Divider(),
                      _buildRow(context, Icons.phone_outlined, 'Phone', () {}),
                      const Divider(),
                      _buildRow(context, Icons.place_outlined, 'Location',
                          () => _goToLocation(context)),
                    ],
                  ),
                  // child: ListView.separated(
                  //   itemCount: 7,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return _buildRow(context, Icons.ac_unit, 'tadfadf');
                  //   },
                  //   separatorBuilder: (BuildContext context, int index) =>
                  //       const Divider(),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
