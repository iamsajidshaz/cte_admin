import 'package:flutter/material.dart';
import '../../widgets/account_details_box.dart';

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
              const AccountDetailsBox(
                label: 'Name',
                text: 'Sajid A A',
              ),
              const AccountDetailsBox(
                label: 'Email',
                text: 'iamsajid.aa@gmail.com',
              ),
              const AccountDetailsBox(
                label: 'Phone',
                text: '+91 9901312320',
              ),
              const AccountDetailsBox(
                label: 'Location',
                text: '>',
              ),
              const AccountDetailsBox(
                label: 'Change Password',
                text: '>',
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              const AccountDetailsBox(
                label: 'Account Status',
                text: 'Approved',
              ),
              const AccountDetailsBox(
                label: 'Joined on',
                text: '28 May 2024',
              ),

              const SizedBox(
                height: 20,
              ),
              const Divider(
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
