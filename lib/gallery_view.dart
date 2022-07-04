import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:thegreatkabab/const/colors.dart';

class GalleryViewPage extends StatelessWidget {

  GalleryViewPage(this.imageUrl) : super();

  final String imageUrl;
  static const colors= AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom view'),
        backgroundColor: colors.redtheme,
        leading: IconButton(
          // icon: Text('Back', textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
            icon: const Icon(Icons.close),
            color: Colors.white,
            onPressed:() {
              Navigator.pop(context, 'Yep!');
              // Navigator.of(context).pop();
            }),
      ),

      body: PhotoView(
        imageProvider: NetworkImage(
          imageUrl,
        ),
        // Contained = the smallest possible size to fit one dimension of the screen
        minScale: PhotoViewComputedScale.contained * 0.8,
        // Covered = the smallest possible size to fit the whole screen
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: true,
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        /*loadingChild: Center(
          child: CircularProgressIndicator(),
        ),*/
      ),
    );
  }
}