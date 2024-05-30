import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todo_app/src/components/pages/Profile/editProfile.dart';
import 'package:todo_app/src/routes/DrawerNavigaton.dart';

class Profile extends StatefulWidget {
  final String? fullNameEdit;
  final String? eMailEdit;
  final String? phoneNumberEdit;
  final String? addressEdit;
  final String? avatarEdit;
  final File? selectedImage;

  const Profile({
    super.key, 
    this.fullNameEdit,
    this.eMailEdit,
    this.phoneNumberEdit,
    this.addressEdit,
    this.avatarEdit,
    this.selectedImage,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _fullName = 'Nguyen Tuan Anh';
  String _eMail = 'tuananh260602@gmail.com';
  String _phoneNumber = '0322653167';
  String _address = 'Thanh Hoa';

  File? _selectedImage = File(
      '/data/user/0/com.example.todo_app/cache/fbda0190-7125-4728-b9e6-3c2325d8716e/1689758585_Anh-avatar-dep-chat-lam-hinh-dai-dien-600x600.jpg');

  @override
  void initState() {
    super.initState();
    if (widget.fullNameEdit != null) _fullName = widget.fullNameEdit!;
    if (widget.eMailEdit != null) _eMail = widget.eMailEdit!;
    if (widget.phoneNumberEdit != null) _phoneNumber = widget.phoneNumberEdit!;
    if (widget.addressEdit != null) _address = widget.addressEdit!;
    if (widget.selectedImage != null) _selectedImage = widget.selectedImage!;
  }

  _editProfile() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Editprofile(
          fullName: _fullName,
          eMail: _eMail,
          phoneNumber: _phoneNumber,
          address: _address,
          avatar: _selectedImage!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            "Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .unfocus(); // Khi bấm vào màn hình sẽ bỏ focus input
          },
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsetsDirectional.only(top: 20),
              child: Form(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _selectedImage != null
                                  ? Image.file(_selectedImage!)
                                  : null),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "FullName:",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  initialValue: _fullName,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Email:",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  initialValue: _eMail,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Phone number:",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  initialValue: _phoneNumber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Address:",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  initialValue: _address,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _editProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: const Drawernavigaton(),
      ),
    );
  }
}
