import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Represents a single workshop item.
class Workshop {
  final String title;
  final String date;
  final String location;
  final int quota;
  bool isRegistered;
  final Color cardColor;
  final Color titleColor;
  final Color buttonColor;

  Workshop({
    required this.title,
    required this.date,
    required this.location,
    required this.quota,
    this.isRegistered = false,
    required this.cardColor,
    required this.titleColor,
    required this.buttonColor,
  });
}

/// Manages the state of the workshops list.
class WorkshopData extends ChangeNotifier {
  final List<Workshop> _workshops;

  // Initializer list for constructor
  WorkshopData()
      : _workshops = [
          Workshop(
            title: "Workshop Flutter Basic",
            date: "10 Juni 2026",
            location: "Lab Komputer A",
            quota: 30,
            cardColor: Colors.blue.shade50,
            titleColor: Colors.blue.shade900,
            buttonColor: Colors.blue,
          ),
          Workshop(
            title: "Workshop UI/UX Design",
            date: "15 Juni 2026",
            location: "Aula Kampus",
            quota: 25,
            cardColor: Colors.green.shade50,
            titleColor: Colors.green.shade900,
            buttonColor: Colors.green,
          ),
          Workshop(
            title: "Workshop Data Science Fundamentals",
            date: "20 Juli 2026",
            location: "Ruang Seminar B",
            quota: 20,
            cardColor: Colors.purple.shade50,
            titleColor: Colors.purple.shade900,
            buttonColor: Colors.purple,
          ),
        ];

  List<Workshop> get workshops => _workshops;

  void toggleRegistration(Workshop workshop) {
    workshop.isRegistered = !workshop.isRegistered;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<WorkshopData>(
      create: (BuildContext context) => WorkshopData(),
      builder: (BuildContext context, Widget? child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WorkshopPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class WorkshopPage extends StatelessWidget {
  const WorkshopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshop Kampus"),
      ),
      body: Consumer<WorkshopData>(
        builder: (BuildContext context, WorkshopData workshopData, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: workshopData.workshops.length,
              itemBuilder: (BuildContext context, int index) {
                final Workshop workshop = workshopData.workshops[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: index == workshopData.workshops.length - 1 ? 0 : 16.0),
                  child: WorkshopCard(workshop: workshop),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;

  const WorkshopCard({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: workshop.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              workshop.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: workshop.titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 8),
                Text("Tanggal: ${workshop.date}"),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 8),
                Text("Lokasi: ${workshop.location}"),
              ],
            ),
            const SizedBox(height: 4),
            Text("Kuota: ${workshop.quota} Peserta"),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: workshop.buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Provider.of<WorkshopData>(context, listen: false).toggleRegistration(workshop);
                },
                child: Text(workshop.isRegistered ? "Batalkan" : "Daftar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}