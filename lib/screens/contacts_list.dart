import 'package:bytebankwebapi/components/progress.dart';
import 'package:bytebankwebapi/screens/contact_form.dart';
import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';
import '../models/contact.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: Future.delayed(const Duration(seconds: 1)).then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              // ignore: dead_code
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Contact>? contacts = snapshot.data;
                if (contacts != null) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Contact contact = contacts[index];
                      return _ContactItem(contact);
                    },
                    itemCount: contacts.length,
                  );
                }
              }
              break;
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
              .then(
                (reload) => setState(() {}),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
