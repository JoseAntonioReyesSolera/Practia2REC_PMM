import 'package:flutter/material.dart';
import '../models/person.dart';
import 'personal_page.dart';
import 'widget_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SPPMM'),
       backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(person != null ? 'Nombre: ${person!.name} ${person!.surname}' : 'Sin datos'),
            Text(person != null ? 'Email: ${person!.email}, ${person!.password}' : 'Sin datos'),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalPage(
                      person: person ??
                          Person(
                            name: '',
                            surname: 'Crear Usuario',
                            email: 'john.doe@example.com',
                            password: '123456',
                          ),
                    ),
                  ),
                );
                if (result is Person) {
                  setState(() {
                    person = result;
                  });
                }
              },
              child: Text('Ir a PersonalPage'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetPage()),
                );
              },
              child: Text('Ir a WidgetPage'),
            ),
          ],
        ),
      ),
    );
  }
}
