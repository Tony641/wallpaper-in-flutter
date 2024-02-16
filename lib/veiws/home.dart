import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dretmox_walpaper/data/data.dart';
import 'package:dretmox_walpaper/model/wallpaper_model.dart';
import 'package:dretmox_walpaper/veiws/categorie.dart';
import 'package:dretmox_walpaper/veiws/search.dart';
import 'package:dretmox_walpaper/widgets/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
 

import '../model/categories_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController=TextEditingController();
  List<CategoriesModel> categories=[];
  List<PhotosModel> wallpapers=[];
  late bool _loading;



//   getTrendingWallpapers() async{
//     var response=await http.get("https://api.pexels.com/v1/curated?per_page=1" as Uri,
//     headers: {
//       "Authorization" : apiKey
//     }
//     );
//     Map<String,dynamic> jsonData= jsonDecode(response.body);
//     jsonData["photos"].forEach((element){
// WallpaperModel wallpaperModel=new WallpaperModel();
// wallpaperModel=WallpaperModel.fromMap(element);
// wallpapers.add(wallpaperModel);
//     });
//     setState(() {
//
//     });
//   }
  getTrendingWallpaper() async {
    await http.get(Uri.parse(
        "https://api.pexels.com/v1/curated?per_page=1000" ),
        headers: {"Authorization": apiKEY}).then((value) {


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
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getTrendingWallpaper();
 
    _loading=true;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         title: brandName(),
         centerTitle: true,
         elevation: 0.0,
       ),
      body: _loading?const Center(child: SizedBox(
        width: 80,
          height: 80,
          child: LoadingIndicator(indicatorType:  Indicator.ballSpinFadeLoader,colors: [Colors.white70,Colors.redAccent,Colors.yellow,Colors.cyanAccent,Colors.black87,Colors.blue],strokeWidth: 1,))): SingleChildScrollView(
        child: Container(

          child:  Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                      search: searchController.text,
                                    )));
                          }
                        },
                        child: Container(child: const Icon(Icons.search)))
                  ],
                ),
              ),

              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   margin: const EdgeInsets.symmetric(horizontal: 24),
              //   decoration: BoxDecoration(
              //     color: const Color(0xfff5f8fd),
              //     borderRadius: BorderRadius.circular(30),
              //   ),
              //   child:  Row(
              //     children: [
              //        Expanded(
              //         child: TextField(
              //           controller: searchController,
              //           decoration: InputDecoration(
              //             hintText: 'search wallpaper',
              //             border: InputBorder.none
              //           ),
              //         ),
              //       ),
              //        GestureDetector(
              //            onTap: (){
              //              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(searchquery: searchController.text,)));
              //            },
              //            child: Container(child: Icon(Icons.search)))
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16,),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:categories.length,itemBuilder:  (context,index){
                  return CategoriesTile(imgUrls: categories[index].imageUrl!, categorie: categories[index].categoriesName!);

                }),
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
// class CategoriesTile extends StatelessWidget {
//  String imageUrl;
//  String title;
//  CategoriesTile({
//    required this.imageUrl,
//    required this.title
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return   GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder:  (context)=>Categorie(categriename:  title.toLowerCase())));
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 4),
//         child: Stack(
//           children: [
//              ClipRRect(
//                borderRadius: BorderRadius.circular(8),
//                child: Image.network(imageUrl,height: 50,width: 100,fit: BoxFit.cover,),
//              ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.black26,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//
//               height: 50,width: 100,
//               alignment: Alignment.center,
//               child: Text(title,style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16
//               ),),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//}
class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  const CategoriesTile({super.key, required this.imgUrls, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                  categorie: categorie,imgUrl: imgUrls,
                )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    :  CachedNetworkImage(
                  imageUrl: imgUrls,

                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 4,
            ),
            Container(
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  categorie,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Overpass'),
                )),
          ],
        )
            : Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    :  CachedNetworkImage(
                  imageUrl: imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  categorie ?? "Yo Yo",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Overpass'),
                ))
          ],
        ),
      ),
    );
  }
}
