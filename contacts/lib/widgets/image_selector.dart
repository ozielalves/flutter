import 'dart:io';
import 'package:contacts/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatelessWidget {
  final Contact contact;
  final Function changePicture;

  ImageSelector({
    this.contact,
    this.changePicture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: contact.image != null
                ? DecorationImage(image: FileImage(File(contact.image)))
                : null),
        child: contact.image == null
            ? Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey,
              )
            : null,
      ),
      onTap: () {
        ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 50)
            .then((file) {
          if (file == null)
            return;
          else {
            changePicture(file.path);
          }
        });
      },
    );
  }
}
