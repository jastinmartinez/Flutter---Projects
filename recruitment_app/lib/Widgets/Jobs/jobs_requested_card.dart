import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';

class JobsRequestedCard extends StatelessWidget {
  final String id;

  final String name;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String departament;
  final int salary;
  final String position;
  final String competitions;
  final String capacitations;
  final int index;
  final DateTime createdAt;
  JobsRequestedCard({
    this.index,
    this.id,
    this.position,
    this.salary,
    this.address,
    this.capacitations,
    this.competitions,
    this.lastName,
    this.name,
    this.createdAt,
    this.departament,
    this.phoneNumber,
  });
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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  position,
                  style: Theme.of(context).textTheme.button,
                ),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(createdAt),
                ),
                leading: Icon(
                  Icons.send,
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
                    '\$$salary',
                    style: Theme.of(context).textTheme.button,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(name),
                subtitle: Text(lastName),
              ),
              ListTile(
                title: Text(phoneNumber),
                subtitle: Text('Telefono'),
              ),
              ListTile(
                title: Text(address),
                subtitle: Text('Direccion'),
              ),
              ListTile(
                title: Text(departament),
                subtitle: Text('Departamento'),
              ),
              ListTile(
                title: Text(competitions),
                subtitle: Text('Competencia'),
              ),
              ListTile(
                title: Text(capacitations),
                subtitle: Text('Capacitacion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
