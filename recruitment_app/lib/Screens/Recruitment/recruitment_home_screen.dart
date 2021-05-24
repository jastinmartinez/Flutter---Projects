import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recruitment_app/Models/user.dart';

class RecruitmentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box('user').listenable(),
                      builder: (context, box, widget) {
                        final user = box.getAt(0) as User;
                        return ListTile(
                          trailing: SvgPicture.asset(
                            'assets/icons/owl.svg',
                            height: 100,
                            width: 100,
                          ),
                          title: Text(user.name),
                          subtitle: Text('Reclutador'),
                          leading: Icon(
                            Icons.email,
                            color: (user.name.isNotEmpty)
                                ? Colors.blue
                                : Colors.red,
                          ),
                        );
                      }),
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 150,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottom: false,
    );
  }
}
