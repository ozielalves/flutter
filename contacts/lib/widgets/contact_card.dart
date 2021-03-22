import 'dart:io';
import 'package:contacts/helpers/db.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/return_dialog.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final DbManager helper = DbManager();
  final Contact contact;
  final Function updateList;
  final Function showOptions;

  ContactCard({this.contact, this.updateList, this.showOptions});

  void handleDelete(BuildContext context) {
    helper.deleteContact(contact.id);
    updateList();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Text('Contato excluido com sucesso!',
          style: TextStyle(color: Colors.white)),
      action: SnackBarAction(
        label: 'Limpar',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        child: Align(
          alignment: Alignment(-0.9, -0.1),
          child: Icon(
            Icons.delete,
            color: Colors.white.withOpacity(0.87),
          ),
        ),
      ),
      onDismissed: (direction) => showDialog(
          context: context,
          builder: (context) {
            return WarningDialog(
              title: "Excluir ${contact.name}?",
              content:
                  "Ao confirmar a exclusão todas as informações sobre ${contact.name} serão perdidas",
              primaryButtonText: "Confirmar",
              primaryButtonAction: () {
                handleDelete(context);
                Navigator.pop(context);
              },
              secondaryButtonText: "Cancelar",
              secondaryButtonAction: () {
                updateList();
                Navigator.pop(context);
              },
            );
          }),
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: GestureDetector(
            child: Card(
              margin: EdgeInsets.only(bottom: 0),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: contact.image != null
                              ? DecorationImage(
                                  image: FileImage(File(contact.image)))
                              : null),
                      child: contact.image == null
                          ? Icon(
                              Icons.account_circle,
                              size: 80,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //se não existe nome, joga vazio
                          Text(
                            contact.name ?? "",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.87)),
                          ),
                          Text(
                            contact.email ?? "",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white.withOpacity(0.60)),
                          ),
                          Text(
                            contact.phone ?? "",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white.withOpacity(0.60)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              showOptions(context, contact);
            }),
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
