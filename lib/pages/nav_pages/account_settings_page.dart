import 'package:cte_admin/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              const SizedBox(
                height: 50,
              ),
              // profile details
              AccountDetailsBox(
                label: 'Name',
                text: FirebaseAuth.instance.currentUser!.displayName.toString(),
              ),
              AccountDetailsBox(
                label: 'Email',
                text: FirebaseAuth.instance.currentUser!.email.toString(),
              ),
              const AccountDetailsBox(label: 'Phone', text: "NA"),
              const AccountDetailsBox(
                label: 'Location',
                text: '📍',
              ),
              const AccountDetailsBox(
                label: 'Change Password',
                text: '✎',
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
                text: 'NA',
              ),
              const AccountDetailsBox(
                label: 'Joined on',
                text: 'NA',
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
                  onPressed: () async {
                    // delete user
                    await DatabaseMethods().deleteUserAccount();
                    // show message
                    Fluttertoast.showToast(
                        msg: "Your account has been deleted successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
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
