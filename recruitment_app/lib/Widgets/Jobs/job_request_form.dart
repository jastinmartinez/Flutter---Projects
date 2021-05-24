import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruitment_app/Helpers/Design/colors_palette.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recruitment_app/Helpers/others/validation.dart';

class JobRequestForm extends StatefulWidget {
  final Function(int index) goOtherForm;

  final GlobalKey<FormState> formKey;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  JobRequestForm(
      {this.formKey,
      this.goOtherForm,
      this.idController,
      this.addressController,
      this.lastNameController,
      this.nameController,
      this.phoneController});

  @override
  _JobRequestFormState createState() => _JobRequestFormState();
}

class _JobRequestFormState extends State<JobRequestForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text(
              'Formulario de Solicitud',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Obligatorio'),
            leading: Text('1/3'),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: kBlueColor,
                size: 50,
              ),
              onPressed: () {
                bool formValidate = widget.formKey.currentState.validate();
                if (formValidate) {
                  widget.goOtherForm(1);
                } else {
                  return;
                }
              },
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2,
            ),
          ),
          TextFormField(
            key: ValueKey('Id'),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '###-#######-#',
                filter: {
                  "#": RegExp(r'[0-9]'),
                },
              )
            ],
            decoration: InputDecoration(
              icon: SvgPicture.asset(
                "assets/icons/id.svg",
                width: 20,
                height: 20,
              ),
              labelText: 'Cedula',
            ),
            controller: widget.idController,
            validator: (userId) {
              if (userId.isEmpty) {
                return 'Digitar Cedula';
              } else if (!Validation.documentID(userId)) {
                return 'Cedula Invalida';
              } else if (userId.length < 11) {
                return 'La cédula debe contener once(11) digitos';
              }
              return null;
            },
          ),
          TextFormField(
            key: ValueKey('Name'),
            decoration: InputDecoration(
              labelText: 'Nombre',
              icon: SvgPicture.asset(
                "assets/icons/doc.svg",
                width: 20,
                height: 20,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            controller: widget.nameController,
            validator: (name) {
              if (name.isEmpty) {
                return 'Digite Nombre';
              }
              return null;
            },
          ),
          TextFormField(
            key: ValueKey('LastName'),
            decoration: InputDecoration(
              labelText: 'Apellido',
              icon: SvgPicture.asset(
                "assets/icons/doc.svg",
                width: 20,
                height: 20,
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            controller: widget.lastNameController,
            validator: (lastname) {
              if (lastname.isEmpty) {
                return 'Digite Apellido';
              }
              return null;
            },
          ),
          TextFormField(
            key: ValueKey('Telephone'),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '(###)-###-####',
                filter: {
                  "#": RegExp(r'[0-9]'),
                },
              )
            ],
            decoration: InputDecoration(
              icon: Icon(
                Icons.contact_phone,
                color: kBlueColor,
              ),
              labelText: 'Telefono',
            ),
            controller: widget.phoneController,
            validator: (tel) {
              if (tel.isEmpty) {
                return 'Digite Telefono';
              } else if (tel.length < 14) {
                return 'Telefono Incompleto';
              }
              return null;
            },
          ),
          TextFormField(
            key: ValueKey('adresss'),
            decoration: InputDecoration(
              labelText: 'Direccion',
              icon: Icon(
                Icons.location_city,
                color: Colors.brown,
              ),
            ),
            minLines: 5,
            maxLines: 10,
            inputFormatters: [
              LengthLimitingTextInputFormatter(100),
            ],
            controller: widget.addressController,
            validator: (address) {
              if (address.isEmpty) {
                return 'Digite Direccion';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
