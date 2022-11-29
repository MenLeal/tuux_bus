import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HorariosPage extends StatefulWidget {
  const HorariosPage({Key? key}) : super(key: key);

  @override
  State<HorariosPage> createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final options = const [
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:30 AM",
    "12:00 PM",
    "2:00 PM",
    "3:30 PM",
    "5:30 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horarios"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 40.0,
                      child: Icon(
                        Icons.directions_bus,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green.withOpacity(0.4)),
                  title: Text(
                    options[index],
                  ),
                  subtitle: const Text("Llegada"),
                  trailing: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Se ha apartado su asiento correctamente')));
                      },
                      icon: const Icon(Icons.add)),
                ),
              ),
            );
          }),
    );
  }
}
