import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // profile picture
              // Center(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width / 4,
              //     height: MediaQuery.of(context).size.width / 4,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       //border: Border.all(color: Colors.green),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              // profile details
              AccountDetailsBox(
                label: 'Name',
                text: 'Sajid A A',
              ),
              AccountDetailsBox(
                label: 'Email',
                text: 'iamsajid.aa@gmail.com',
              ),
              AccountDetailsBox(
                label: 'Phone',
                text: '+91 9901312320',
              ),
              AccountDetailsBox(
                label: 'Location',
                text: '>',
              ),
              AccountDetailsBox(
                label: 'Change Password',
                text: '>',
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              AccountDetailsBox(
                label: 'Account Status',
                text: 'Approved',
              ),
              AccountDetailsBox(
                label: 'Joined on',
                text: '28 May 2024',
              ),

              const SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),

              // delete account button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}

class AccountDetailsBox extends StatelessWidget {
  final String label;
  final String text;
  const AccountDetailsBox({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      //   height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
