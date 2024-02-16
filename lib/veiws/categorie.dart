import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

import '../data/data.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';

// class Categorie extends StatefulWidget {
//   final String categriename;
//   Categorie({
//     required this.categriename
// });
//
//   @override
//   State<Categorie> createState() => _CategorieState();
// }
// List<WallpaperModel> wallpapers=[];
//
// class _CategorieState extends State<Categorie> {
//   getSearchWallpapers(String query) async{
//     var response=await http.get("https://api.pexels.com/v1/search?query=$query&per_page=1" as Uri,
//         headers: {
//           "Authorization" : apiKEY
//         }
//     );
//     Map<String,dynamic> jsonData= jsonDecode(response.body);
//     jsonData["photos"].forEach((element){
//       WallpaperModel wallpaperModel=new WallpaperModel();
//       wallpaperModel=WallpaperModel.fromMap(element);
//       wallpapers.add(wallpaperModel);
//     });
//     setState(() {
//
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSearchWallpapers(widget.categriename);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: brandName(),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body:  SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//
//               SizedBox(height: 16,),
//               wallpapersList(wallpapers: wallpapers,context: context),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class CategorieScreen extends StatefulWidget {
  final String categorie;
  final String imgUrl;

  const CategorieScreen({super.key, required this.categorie,required this.imgUrl});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotosModel> wallpapers =  [];
  late bool _loading;


  getCategorieWallpaper() async {
    await http.get(Uri.parse(
        "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=1000&page=100",),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        wallpapers.add(photosModel);

        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {
        _loading=false;
      });
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
    _loading=true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandNaMe(),
        elevation: 0.0,
        centerTitle: true,

      ),
            body:  _loading?const Center(child: SizedBox(
                height: 80,
                width: 80,
                child: LoadingIndicator(indicatorType:  Indicator.ballSpinFadeLoader,colors: [Colors.white70,Colors.redAccent,Colors.yellow,Colors.cyanAccent,Colors.black87,Colors.blue],strokeWidth: 1,))): SingleChildScrollView(
        child: Container(
          child: Column(

            children: [
              const SizedBox(height: 20,),
              Stack(
                children: [
                  CachedNetworkImage(

                      height:200,
                      width:MediaQuery.of(context).size.width,
                      fit:BoxFit.cover,

imageUrl: widget.imgUrl,
                      ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black38,

                    ),
                    height:200,
                    width:MediaQuery.of(context).size.width,


                  ),

                   Column(

                     children: [

                       Container(
                         height:200,
                         width:MediaQuery.of(context).size.width,
                         alignment: Alignment.center,
                         child: Row(

                           mainAxisSize: MainAxisSize.max,
                           //crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(widget.categorie,style: const TextStyle(
                                 fontSize: 35,color: Colors.white,fontWeight: FontWeight.w600
                             ),),
                           ],
                         ),
                       )
                     ],
                   )
                ],
              ),

              const SizedBox(height: 16,),
              wallpapersList(wallpapers: wallpapers,context: context),

            ],
          ),
        ),
      ),
    );
  }
}