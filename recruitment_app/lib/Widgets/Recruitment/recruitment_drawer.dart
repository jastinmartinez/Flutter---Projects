import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';

class RecruitmentDrawer extends StatelessWidget {
  const RecruitmentDrawer({
    Key key,
    Function(int index) menuItemTap,
  })  : _menuItemTap = menuItemTap,
        super(key: key);

  final Function(int index) _menuItemTap;
  void _menuItemIndex(BuildContext context, int index) {
    _menuItemTap(index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            width: MediaQuery.of(context).size.width * 0.8,
            color: kPrimaryColor,
            child: CircleAvatar(
              radius: 50,
              child: SvgPicture.asset(
                'assets/icons/owl.svg',
                height: 100,
                width: 100,
              ),
            ),
          ),
          Container(
            color: kSecondaryColor,
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('Inicio'),
            onTap: () => _menuItemIndex(context, 0),
          ),
          ListTile(
            leading: Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.green,
            ),
            title: Text('Reclutar'),
          ),
          ExpansionTile(
            leading: Icon(
              Icons.search,
              color: Colors.deepOrange,
            ),
            title: Text('Consulta'),
            children: [
              ListTile(
                title: Text('Candidatos Por Puestos'),
              ),
              ListTile(
                title: Text('Candidatos Por Competencia'),
              ),
              ListTile(
                title: Text('Candidatos Por Capacitaciones'),
              ),
              ListTile(
                title: Text('Emplados'),
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text('Mantenimiento'),
            children: [
              ExpansionTile(
                title: Text('Puesto'),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.new_releases,
                      color: Colors.amber,
                    ),
                    title: Text('Crear'),
                    onTap: () => _menuItemIndex(context, 1),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.list,
                      color: Colors.deepPurple,
                    ),
                    title: Text('Visualizar'),
                    onTap: () => _menuItemIndex(context, 2),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Competencias'),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.new_releases,
                      color: Colors.amber,
                    ),
                    title: Text('Crear'),
                    onTap: () => _menuItemIndex(context, 3),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.list,
                      color: Colors.deepPurple,
                    ),
                    title: Text('Visualizar'),
                    onTap: () => _menuItemIndex(context, 4),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Idiomas'),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.new_releases,
                      color: Colors.amber,
                    ),
                    title: Text('Crear'),
                    onTap: () => _menuItemIndex(context, 5),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.list,
                      color: Colors.deepPurple,
                    ),
                    title: Text('Visualizar'),
                    onTap: () => _menuItemIndex(context, 6),
                  ),
                ],
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.blue,
            ),
            title: Text('Informacion'),
            subtitle: Text('Powered By MeteorX'),
          ),
        ],
      ),
    );
  }
}
