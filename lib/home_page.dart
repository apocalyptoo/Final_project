import 'package:flutter/material.dart';

final doctors = [
  {'name': "Dr. Siddik Shahriar", 'desc': "General Physician"},
  {'name': 'Dr. Sneha Hussain', 'desc': 'Cardiologist'},
  {'name': 'Dr. Abdul Hannan', 'desc': 'Dermatologist'},
  {'name': 'Dr. Mohammad Halim', 'desc': 'Pediatrician'},
  {'name': 'Dr. Manna Dey', 'desc': 'Neurologist'},
];

const weekDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];

class HomePage extends StatelessWidget {
  final ValueNotifier<List<Map<String, dynamic>>> appointments;

  HomePage({required this.appointments});

  void bookAppointment(BuildContext context, int doctorIdx) async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text("Select a day (Sun-Thu)"),
        children: weekDays
            .map((day) => SimpleDialogOption(
                  child: Text(day),
                  onPressed: () {
                    appointments.value = [
                      ...appointments.value,
                      {
                        'doctor': doctors[doctorIdx]['name'],
                        'desc': doctors[doctorIdx]['desc'],
                        'day': day,
                      }
                    ];
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Appointment booked!')));
                  },
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors"),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () => Navigator.pushNamed(context, '/appointments'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (ctx, i) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                doctors[i]['name']!,
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF617073)),
              ),
              subtitle: Text(
                doctors[i]['desc']!,
                style: TextStyle(color: Color(0xFF859A6A)),
              ),
              trailing: ElevatedButton(
                onPressed: () => bookAppointment(context, i),
                child: Text("Book"),
              ),
            ),
          );
        },
      ),
    );
  }
}