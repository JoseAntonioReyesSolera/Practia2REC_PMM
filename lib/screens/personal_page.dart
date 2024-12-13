import 'package:flutter/material.dart';
import '../models/person.dart';

class PersonalPage extends StatefulWidget {
  final Person person;

  const PersonalPage({required this.person});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.person.name);
    surnameController = TextEditingController(text: widget.person.surname);
    emailController = TextEditingController(text: widget.person.email);
    passwordController = TextEditingController(text: widget.person.password);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.person.surname), backgroundColor: Colors.blue,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nombre', hintText: 'Jhon', helperText: "anterior nombre: ${widget.person.name}"),),
            TextField(controller: surnameController, decoration: InputDecoration(labelText: 'Apellido', hintText: 'Doe', helperText: "anterior apellido: ${widget.person.surname}"),),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Correo Electrónico', hintText: 'john.doe@example.com', helperText: "anterior email: ${widget.person.email}"),),
            TextField(obscureText: true,controller: passwordController, decoration: InputDecoration(labelText: 'Contraseña', hintText: '123456', helperText: "anterior password: ${widget.person.password}"),),
            ElevatedButton(
              onPressed: () {
                final updatedPerson = Person(
                  name: nameController.text,
                  surname: surnameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
                Navigator.pop(context, updatedPerson);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
