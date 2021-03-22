import 'dart:io';

import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/button.dart';
import 'package:contacts/widgets/image_selector.dart';
import 'package:contacts/widgets/return_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  //construtor que inicia o contato.
  //Entre chaves porque é opcional.
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;
  bool _userEdited;

  //para garantir o foco no nome
  final _nomeFocus = FocusNode();

  //controladores
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //acessando o contato definido no widget(ContactPage)
    //mostrar se ela for privada
    if (widget.contact == null)
      _editedContact = Contact();
    else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      nomeController.text = _editedContact.name;
      emailController.text = _editedContact.email;
      phoneController.text = _editedContact.phone;
    }
  }

  Future<bool> _requestPop() {
    if (_userEdited != null && _userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return WarningDialog(
              title: "Abandonar alterações?",
              content: "Todos os dados alterados serão perdidos.",
              primaryButtonText: "Sim",
              primaryButtonAction: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              secondaryButtonText: "Cancelar",
              secondaryButtonAction: () {
                Navigator.pop(context);
              },
            );
          });
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    //com popup de confirmação
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor, //change your color here
            ),
            backgroundColor: Color(0xFF363636),
            title: Text(
              _editedContact.name != null
                  ? _editedContact.name.length > 0
                      ? _editedContact.name
                      : "Novo contato"
                  : "Novo contato",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 24),
            ),
            centerTitle: true),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ImageSelector(
                contact: _editedContact,
                changePicture: (String path) => setState(() {
                  _editedContact.image = path;
                }),
              ),
              TextField(
                controller: nomeController,
                style: TextStyle(color: Colors.white),
                focusNode: _nomeFocus,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    labelText: "Nome",
                    focusColor: Theme.of(context).primaryColor),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "E-mail"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                },
              ),
              TextField(
                controller: phoneController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.phone = text;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.centerRight,
                child: Builder(
                  builder: (context) => ActionButton(
                      text: 'Salvar',
                      textColor: Color(0xFF333333),
                      buttonColor: Theme.of(context).primaryColor,
                      action: () {
                        if (_editedContact.name != null &&
                            _editedContact.name.isNotEmpty) {
                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Contato salvo com sucesso!',
                                style: TextStyle(color: Colors.white)),
                            action: SnackBarAction(
                              label: 'Limpar',
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ));
                          Navigator.pop(context, _editedContact);
                        } else {
                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text('Informe o nome',
                                style: TextStyle(color: Colors.white)),
                            action: SnackBarAction(
                              label: 'Limpar',
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ));
                          FocusScope.of(context).requestFocus(_nomeFocus);
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
