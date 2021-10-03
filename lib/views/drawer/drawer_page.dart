import 'package:flutter/material.dart';
import 'package:keepnote/views/constants/constants.dart';
import 'package:keepnote/database/database_helper.dart';
import 'package:keepnote/views/home/home_page.dart';
import 'package:keepnote/views/commons/utils/custom_toast.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  DatabaseHelper _db;

  @override
  void initState() {
    super.initState();
    _db = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: qColorPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 35,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Text(
                          'Keep Note',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 20),
                      )),
                  SizedBox(
                    height: 70,
                  ),
                  _drawerItem(
                    title: 'About us',
                    icon: Icons.person,
                    onTap: () {},
                  ),
                  _drawerItem(
                    title: 'Delete account',
                    icon: Icons.account_box_outlined,
                    onTap: () async {
                      int deleted = await _db.deleteTable();
                      if (deleted != null) {
                        CustomToast.toast('Account has been deleted');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false);
                      }

                    },
                  ),
                  _drawerItem(
                    title: 'Logout',
                    icon: Icons.exit_to_app,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _drawerItem({
    @required IconData icon,
    @required String title,
    @required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
        //this.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 58,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
