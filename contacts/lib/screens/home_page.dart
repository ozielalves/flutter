import 'package:contacts/models/contact.dart';
import 'package:contacts/helpers/db.dart';
import 'package:contacts/widgets/contact_card.dart';
import 'package:contacts/widgets/options_modal.dart';
import 'package:flutter/material.dart';

import 'contact_page.dart';

//enum para opções de ordenação.
enum OrderOptions { orderAz, orderZa }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbManager helper = DbManager();
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool showSearchBar = false;

  // search controller
  TextEditingController searchController = TextEditingController();

  // carregando a lista de contacts do banco ao iniciar o app
  @override
  void initState() {
    super.initState();
    updateList();
  }

  void updateList() {
    helper.getAllContact().then((list) {
      //atualizando a lista de contacts na tela
      setState(() {
        contacts = list;
        filteredContacts = list;
      });
    });
  }

  void handdleSearch(String value) {
    if (value.length > 0) {
      setState(() {
        filteredContacts = contacts
            .where((c) => c.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredContacts = contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: showSearchBar ? 3 : 0,
        title: Text(
          "Meus Contatos",
          style: TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Color(0xFF363636),
        centerTitle: showSearchBar ? true : false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showSearchBar = !showSearchBar;
                  });
                },
                child: Icon(Icons.search,
                    size: 26.0, color: Theme.of(context).primaryColor),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showContactPage();
                },
                child: Icon(Icons.add,
                    size: 26.0, color: Theme.of(context).primaryColor),
              )),
        ],
      ),
      backgroundColor: Color(0xFF121212),
      body: Column(
        children: [
          AnimatedCrossFade(
            sizeCurve: Curves.ease,
            crossFadeState: showSearchBar
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 200),
            firstChild: SizedBox(),
            secondChild: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[3],
                  color: Color(0xFF363636),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Busque por um contato",
                    icon: Icon(Icons.search)),
                onChanged: (text) {
                  handdleSearch(text);
                },
              ),
            ),
          ),
          /* ), */
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowBehaviour(),
              child: ListView(
                children: <Widget>[
                  if (filteredContacts.length > 0)
                    for (var contact in filteredContacts)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ContactCard(
                            contact: contact,
                            updateList: updateList,
                            showOptions: showOptions),
                      )
                  else
                    Container(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nenhum contato encontrado",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          Text(
                            "Castre um novo contato ou realize uma nova busca",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white38,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //mostra as opções
  void showOptions(BuildContext context, Contact contact) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return OptionsModal(
              context: context,
              contact: contact,
              updateList: updateList,
              showContactPage: showContactPage);
        });
  }

  void showContactPage({Contact contact}) async {
    Contact contatoRet = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));

    if (contatoRet != null) {
      print(contatoRet.id);
      if (contatoRet.id == null)
        await helper.saveContact(contatoRet);
      else
        await helper.updateContact(contatoRet);

      updateList();
    }
  }
}
