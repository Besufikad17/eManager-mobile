import 'dart:io';

import 'package:cleanarchdemo/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class MyFilePicker extends StatelessWidget {
  const MyFilePicker({
    super.key,
    required this.type,
    required this.image,
    required this.pickFromGallery,
    required this.pickFromCamera
  });

  final FileType type;
  final File image;
  final Function(File, FileType) pickFromGallery;
  final Function(File, FileType) pickFromCamera;

  @override
  Widget build(BuildContext context) {
    return type == FileType.Image ? 
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color:  Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 1,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: IconButton(
                onPressed: () {
                  pickFromGallery(image, type);
                }, 
                icon: const Icon(
                  Icons.camera,
                  size: 30,
                )
              ),
            ),
          ),
          const SizedBox(width: 30,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 1,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: IconButton(
                onPressed: () {
                  pickFromGallery(image, type);
                }, 
                icon: const Icon(
                  Icons.browse_gallery,
                  size: 30,
                )
              ),
            ),
          ),
        ],
      ) : 
      Container(
        width: 400,
        height: 60,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 1,
              blurStyle: BlurStyle.outer
            )
          ]
        ),
        child:  IconButton(
          onPressed: () {

          }, 
          icon: const Icon(Icons.file_open)
        ),
      ); 
  }
}