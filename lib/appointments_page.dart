import 'package:flutter/material.dart';

const weekDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];

class AppointmentsPage extends StatelessWidget {
  final ValueNotifier<List<Map<String, dynamic>>> appointments;

  AppointmentsPage({required this.appointments});

  void _editAppointment(BuildContext context, int idx, Map<String, dynamic> appt) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text("Select a new day (Sun-Thu)"),
        children: weekDays
            .map((day) => SimpleDialogOption(
                  child: Text(day),
                  onPressed: () {
                    final updated = List<Map<String, dynamic>>.from(appointments.value);
                    updated[idx]['day'] = day;
                    appointments.value = updated;
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment updated!')));
                  },
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Appointments')),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: appointments,
        builder: (_, appts, __) => appts.isEmpty
            ? Center(child: Text('No appointments'))
            : ListView.builder(
                itemCount: appts.length,
                itemBuilder: (ctx, i) {
                  final appt = appts[i];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(
                        appt['doctor'],
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF617073)),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appt['desc'], style: TextStyle(color: Color(0xFF859A6A))),
                          SizedBox(height: 3),
                          Text("Day: ${appt['day']}", style: TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xFF617073)),
                            onPressed: () => _editAppointment(context, i, appt),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[400]),
                            onPressed: () {
                              appointments.value = List.from(appts)..removeAt(i);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Appointment cancelled')));
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}