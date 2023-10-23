import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImageGallery extends HookWidget {
  const ImageGallery({
    super.key,
    required this.images
  });
  
  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    var index = useState(0);
    var pics = useState(images);

    return SizedBox.expand(
      child: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            if(index.value > 0) {
              index.value = index.value - 1;
            }
          }

          // Swiping in left direction.
          if (details.delta.dx < 0) {
            if(index.value < (pics.value.length -  1)) {
              index.value = index.value + 1;
            }
          }
        },
        child: Container(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 200,),
                Image.network(
                  pics.value[index.value],
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 10,),
                MyText(
                  text: "${index.value + 1}/${pics.value.length}", 
                  size: 12
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}