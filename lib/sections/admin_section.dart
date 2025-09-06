import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('contact_submissions')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final submissions = snapshot.data!.docs;
          if (submissions.isEmpty) {
            return const Center(child: Text('No submissions yet.'));
          }
          return ListView.builder(
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              final data = submissions[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Name: ${data['name'] ?? 'No Name'}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${data['email'] ?? 'No Email'}'),
                      Text('Message: ${data['message'] ?? 'No Message'}'),
                      Text(
                        'Time: ${(data['timestamp'] as Timestamp?)?.toDate().toString() ?? 'No Timestamp'}',
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.email),
                        onPressed: () {
                          final email = data['email'] ?? '';
                          final name = data['name'] ?? '';
                          final uri = Uri.parse(
                            'mailto:$email?subject=Re: Your Message&body=Hi $name,',
                          );
                          launchUrl(uri);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => FirebaseFirestore.instance
                            .collection('contact_submissions')
                            .doc(submissions[index].id)
                            .delete(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}