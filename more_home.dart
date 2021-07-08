import 'package:covidtastic/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'widget/custom_bottombar.dart';
import '../widgets/my_header.dart';
import '../widgets/own_test.dart';
import '../widgets/prevention.dart';
import '../widgets/app_drawer.dart';

class MoreHome extends StatelessWidget {
  static const routeName = "/more-home";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(), drawer: AppDrawer(),
      //bottomNavigationBar: CustomBottombar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyHeader(),
          SizedBox(
            height: 32,
          ),
          Prevention(),
          SizedBox(
            height: 32,
          ),
          OwnTest(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: mBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/men.svg'),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/icons/bell.svg'),
          onPressed: () {},
        )
      ],
    );
  }
}
