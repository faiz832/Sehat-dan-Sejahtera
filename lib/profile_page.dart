import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:slicing/onboarding_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  late User _currentUser;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;

  String _displayName = '';
  String _phoneNumber = '';
  String _createdAt = '';
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _currentUser = FirebaseAuth.instance.currentUser!;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await _firestore.collection('users').doc(_currentUser.uid).get();
      if (userData.exists) {
        Timestamp createdAtTimestamp = userData.get('createdAt');
        setState(() {
          _displayName = userData.get('displayName') ?? userData.get('name');
          _phoneNumber = userData.get('phoneNumber') ?? '';
          _createdAt = DateFormat('dd-MM-yyyy').format(createdAtTimestamp.toDate());
          _profileImageUrl = userData.get('profileImageUrl') ?? '';
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile(String name, String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('users').doc(_currentUser.uid).update({
        'name': name,
        'phoneNumber': phoneNumber,
      });

      setState(() {
        _displayName = name;
        _phoneNumber = phoneNumber;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        File file = File(pickedFile.path);
        String fileName = _currentUser.uid + '.png';
        UploadTask uploadTask = _storage.ref('profile_images/$fileName').putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await _firestore.collection('users').doc(_currentUser.uid).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          _profileImageUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile image updated successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile image: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _editProfile() async {
    TextEditingController nameController = TextEditingController(text: _displayName);
    TextEditingController phoneController = TextEditingController(text: _phoneNumber);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter your new details:'),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(hintText: 'Phone Number'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _updateProfile(nameController.text, phoneController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetPassword() async {
    TextEditingController emailController = TextEditingController(text: _currentUser.email);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter your email to reset password:'),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password reset email sent")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to send reset email: $e")),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete your account? This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  await _firestore.collection('users').doc(_currentUser.uid).delete();

                  await _currentUser.delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Account deleted successfully")),
                  );

                  Navigator.of(context).pop();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OnBoardingPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to delete account: $e")),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }



  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully logged out")),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoardingPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _updateProfileImage,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: _profileImageUrl.isNotEmpty
                              ? NetworkImage(_profileImageUrl)
                              : AssetImage('images/profile.png') as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _displayName,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(_createdAt, style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(_phoneNumber, style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ProfileMenuItem(
                  icon: Icons.edit,
                  text: 'Personal Information',
                  onTap: _editProfile,
                ),
                ProfileMenuItem(
                  icon: Icons.settings,
                  text: 'Profile Settings',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.lock,
                  text: 'Reset Password',
                  onTap: _resetPassword,
                ),
                ProfileMenuItem(
                  icon: Icons.delete,
                  text: 'Delete Account',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: _deleteAccount,
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Log Out',
                  onTap: _logout,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blue),
        title: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor ?? Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
