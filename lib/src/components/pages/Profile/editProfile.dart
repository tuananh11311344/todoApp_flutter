import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:todo_app/src/components/pages/Profile/profile.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  final String fullName;
  final String eMail;
  final String phoneNumber;
  final String address;
  final File? avatar;

  const Editprofile({
    super.key,
    required this.fullName,
    required this.eMail,
    required this.phoneNumber,
    required this.address,
    this.avatar,
  });

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  late String _fullName;
  late String _eMail;
  late String _phoneNumber;
  late String _address;

  File? _selectedImage;
  @override
  void initState() {
    super.initState();
    _fullName = widget.fullName;
    _eMail = widget.eMail;
    _phoneNumber = widget.phoneNumber;
    _address = widget.address;
    _selectedImage = widget.avatar;
  }

  final _formKey = GlobalKey<FormState>();
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;
    setState(() {
      _selectedImage = File(returnImage.path);
    });
    print(_selectedImage);
  }

  _saveEdit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Profile(
                  fullNameEdit: _fullName,
                  eMailEdit: _eMail,
                  phoneNumberEdit: _phoneNumber,
                  addressEdit: _address,
                  selectedImage: _selectedImage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            "Edit Profile",
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
              margin: const EdgeInsetsDirectional.only(top: 10),
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
                            color: Colors.blue,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              _pickImageFromGallery();
                            },
                            child: const Icon(
                              LineAwesomeIcons.camera,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.user),
                              labelText: "Full Name",
                              labelStyle: const TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            validator: (input) {
                              return input!.trim().isEmpty
                                  ? "Please enter a full name"
                                  : null;
                            },
                            onChanged: (input) {
                              _fullName = input;
                            },
                            initialValue: _fullName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.envelope),
                              labelText: "E-Mail",
                              labelStyle: const TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            validator: (input) {
                              return input!.trim().isEmpty
                                  ? "Please enter an email"
                                  : null;
                            },
                            onChanged: (input) {
                              _eMail = input;
                            },
                            initialValue: _eMail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.phone),
                              labelText: "Phone Number",
                              labelStyle: const TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            validator: (input) {
                              return input!.trim().isEmpty
                                  ? "Please enter a phone number"
                                  : null;
                            },
                            onChanged: (input) {
                              _phoneNumber = input;
                            },
                            initialValue: _phoneNumber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  LineAwesomeIcons.alternate_map_marked),
                              labelText: "Address",
                              labelStyle: const TextStyle(
                                fontSize: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            validator: (input) {
                              return input!.trim().isEmpty
                                  ? "Please enter an address"
                                  : null;
                            },
                            onChanged: (input) {
                              _address = input;
                            },
                            initialValue: _address,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 47,
                            child: ElevatedButton(
                              onPressed: _saveEdit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                "Save Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
