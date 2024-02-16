import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../data/data.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

class SearchView extends StatefulWidget {
  final String search;

  const SearchView({super.key, required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotosModel> wallpapers = [];
  TextEditingController searchController = TextEditingController();
  late bool loading;

  getSearchWallpaper(String search) async {
    await http.get(Uri.parse(
        "https://api.pexels.com/v1/search?query=$search&per_page=100&page=100" ),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      wallpapers.clear();
      jsonData["photos"].forEach((element) {

        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        wallpapers.add(photosModel);

        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {
loading=false;
      });
    });
  }

  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
    loading=true;
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
      appBar: AppBar(
        title: brandNaMe(),
        elevation: 0.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:loading?const Center(child: SizedBox(
          width: 80,
          height: 80,
          child: LoadingIndicator(indicatorType:  Indicator.ballSpinFadeLoader,colors: [Colors.white70,Colors.redAccent,Colors.yellow,Colors.cyanAccent,Colors.black87,Colors.blue],strokeWidth: 1,))):  SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
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

                          keyboardType: TextInputType.text,
                          controller: searchController,
                          decoration: const InputDecoration(

                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {


                          getSearchWallpaper(searchController.text,);
                        },
                        child: Container(child: const Icon(Icons.search)))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              wallpapersList(wallpapers: wallpapers,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
//class Search extends StatefulWidget {
//    final String searchquery;
//    Search({
//      required this.searchquery
// });
//
//
//
//   @override
//   State<Search> createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   TextEditingController searchController=TextEditingController();
//   List<WallpaperModel> wallpapers=[];
//
//   getSearchWallpapers(String query) async{
//     var response=await http.get("  https://api.pexels.com/v1/search?query=$query&per_page=1  " as Uri,
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
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSearchWallpapers(widget.searchquery);
//     searchController=widget.searchquery as TextEditingController;
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
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 margin: const EdgeInsets.symmetric(horizontal: 24),
//                 decoration: BoxDecoration(
//                   color: const Color(0xfff5f8fd),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child:  Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: searchController,
//                         decoration: InputDecoration(
//                             hintText: 'search wallpaper',
//                             border: InputBorder.none
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                         onTap: (){
//                           getSearchWallpapers(searchController.text);
//                          },
//                         child: Container(child: Icon(Icons.search)))
//                   ],
//                 ),
//               ),
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

