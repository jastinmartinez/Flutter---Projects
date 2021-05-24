import 'package:flutter/material.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  final String id, title;
  final int minSalary, maxSalary, index;
  final DateTime createdAt;
  JobCard(
      {this.id,
      this.title,
      this.minSalary,
      this.maxSalary,
      this.createdAt,
      this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: index.isEven ? kBlueColor : kSecondaryColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [kDefaultShadow],
      ),
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Container(
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(createdAt),
            ),
            leading: Icon(
              Icons.info,
              color: index.isEven ? kBlueColor : kSecondaryColor,
            ),
            trailing: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: index.isEven ? kBlueColor : kSecondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Text(
                '\$$minSalary\ - \$$maxSalary',
                style: Theme.of(context).textTheme.button,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
