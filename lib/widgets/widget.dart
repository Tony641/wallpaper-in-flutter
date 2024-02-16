
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dretmox_walpaper/veiws/image_view.dart';
import 'package:flutter/material.dart';
 
import '../model/wallpaper_model.dart';

//
// Widget brandname(){
//   return RichText(text: TextSpan(
//
//     children: [
//       TextSpan( text: 'Dretmox',style: TextStyle(fontSize: 16,color:Colors.black87,fontWeight: FontWeight.bold)),
//       TextSpan(
//         text: "Wallpaper",style: TextStyle(
//         fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue
//       )
//       )
//     ]
//   ));
// }
Widget brandNaMe(){
  return const Text.rich(
    TextSpan(


      children: [
        TextSpan(
          text: "Wallpaper",
      style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
    ),
        TextSpan(
          text:   "Hub",
          style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
        )


      ]
    )
  );
}
Widget brandName() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize : MainAxisSize.min,
    children: <Widget>[
  Text(
  "Wallpaper",
    style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
  ),
  Text(
  "Hub",
  style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
  )
  ],
  );
}
//
// Widget wallpaperList({required List<WallpaperModel> wallpapers,context}){
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 16),
//     child: GridView.count(
//       shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         childAspectRatio: 0.6,
//         mainAxisSpacing: 6,
//         crossAxisSpacing: 6,
//         crossAxisCount: 2,
//     children: wallpapers.map((wallpaper){
//       return  GestureDetector(
//         onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageView(imageUrl:  wallpaper.src!.portrait)));
//         },
//         child: Hero(
//           tag: wallpaper.src!.portrait,
//           child: GridTile(child:  Container(
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(wallpaper.src!.portrait,fit: BoxFit.cover,)),
//           )),
//         ),
//       );
//     }).toList(),
//     ),
//   );
//}
Widget wallpapersList({required List<PhotosModel> wallpapers, context}){
  return Container(

    child: GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FullScreen(
                    imageUrl: wallpaper.src!.portrait,
                  )
              ));
            },
            child: Hero(
              tag: wallpaper.src!.portrait,
              child: Container(


                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),

                    child:    CachedNetworkImage( fit: BoxFit.cover, imageUrl: wallpaper.src!.portrait,)),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}