import 'package:contacts/helpers/db.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/widgets/return_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionsModal extends StatelessWidget {
  final DbManager helper = DbManager();
  final BuildContext context;
  final Contact contact;
  final Function updateList;
  final Function showContactPage;

  OptionsModal(
      {this.context, this.contact, this.updateList, this.showContactPage});

  @override
  Widget build(BuildContext context) {
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

    return BottomSheet(
      //onclose obrigatório. Não fará nada
      onClosing: () {},
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            //ocupa o mínimo de espaço.
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text("Ligar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        ],
                      ),
                      onPressed: () {
                        launch("tel:${contact.phone}");
                        Navigator.pop(context);
                      })),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text("Editar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showContactPage(contact: contact);
                      })),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text("Excluir",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        ],
                      ),
                      onPressed: () {
                        return showDialog(
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
                                  Navigator.pop(context);
                                },
                                secondaryButtonText: "Cancelar",
                                secondaryButtonAction: () {
                                  updateList();
                                  Navigator.pop(context);
                                },
                              );
                            });
                      }))
            ],
          ),
        );
      },
    );
  }
}
