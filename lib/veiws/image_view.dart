

//import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gal/gal.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:image/image.dart' as img;

class FullScreen extends StatefulWidget {
 final String imageUrl;
 const FullScreen({super.key, 
   required this.imageUrl
});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  
  Future<void> _saveFile(String url) async {
    Dio dio=Dio();
    try{
      Response response=await dio.get(url,options: Options(responseType: ResponseType.bytes));
      Directory appDir=await getApplicationCacheDirectory();
      String filename=url.split('/').last;
      String filepath='${appDir.path}/$filename';
      File file= File(filepath);
      await file.writeAsBytes(response.data);
      
      //WallpaperManager.setWallpaperFromFile(filepath, WallpaperManager.BOTH_SCREEN);
      await Wallpaper.homeScreen(imageName: filepath,options: RequestSizeOptions.RESIZE_FIT,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height );
    }
    catch(error){

    }

  }
   void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
    toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16

    );

     
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Stack(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              

              decoration: BoxDecoration(


                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      //image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //_save();

                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xfff1c1b1b).withOpacity(.5),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            height: 50,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height / 2,

                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 6),
                            width: MediaQuery
                                .of(context)
                                .size
                                .height / 2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white60, width: 1),
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ]
                                )
                            ),
                            child: Column(

                              children: [
                                GestureDetector(
                                    onTap: () {
                                     
                                      
                                      _saveFile(widget.imageUrl);
                                       showToastMessage('wallpaper saved successfully');
                                     //_save();
                                      //setWallpaper();
                                      Navigator.pop(context);
                                    },
                                    child: const Center(child: Text(
                                      'Set Wallpaper', style: TextStyle(
                                        fontSize: 25, color: Colors.white70),)))
                              ],),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: const Text('Cancel', style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20
                        ),),
                      ),
                    ),

                    const SizedBox(height: 10,)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



//   _save() async {
// //     var status=await Permission.storage.request();
// //     if(status.isGranted){
// // var response=await Dio().get(widget.imageUrl,options: Options(responseType: ResponseType.bytes));
// // final result=await ImageGallerySaver.saveImage(
// //   Uint8List.fromList(response.data),
// //   quality: 60,
// //   name: "Dretomx"
// // );
// // var imagePath=await DefaultCacheManager().getSingleFile(widget.imageUrl);
// //
// // int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
// // await WallpaperManager.setWallpaperFromFile(imagePath.path, location);
// //
// //     }

//     var imagePath=await DefaultCacheManager().getSingleFile(widget.imageUrl);

//     //final imagePath = '${Directory.systemTemp.path}/image.jpg';
//     //await Dio().download(imagePath.path,imagePath);
//     //await Gal.putImage(imagePath.path,album: 'Dretmox');
//     //var imagePath=await DefaultCacheManager().getSingleFile(widget.imageUrl);
//     int location = WallpaperManager.BOTH_SCREEN;
//     final http.Response response=await http.get(Uri.parse(widget.imageUrl));//can be Home/Lock Screen
//     //await Wallpaper.homeScreen(imageName: imagePath ,options: RequestSizeOptions.RESIZE_FIT,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height );
//      await WallpaperManager.setWallpaperFromFile(imagePath.path,location,);
     
//       //provide image path
      

// //
// //

//   }
//   Future<void> _setWallpaper()async {
//
//     http.Response response=await http.get(Uri.parse(widget.imageUrl));
//     if(response.statusCode==200){
//       Uint8List bytes=response.bodyBytes;
//       final image1=img.decodeImage( bytes);
//       final resizedImage=img.copyResize(image1!,height: 800 , width: 500,);
//       final savedpath=await _savedResizedImage(resizedImage);
//       int location=WallpaperManager.BOTH_SCREEN;
//       WallpaperManager.setWallpaperFromFile(savedpath ,location,);
//     }
//   }
//   Future<String> _savedResizedImage(img.Image image1) async {
//     final directory=await getTemporaryDirectory() ;
//   }
// // _save()async{
//   if(Platform.isAndroid) {
//     await _askPermission();
//   }
//   var response=await Dio().get(
//     widget.imageUrl,
//     options:Options(responseType:ResponseType.bytes));
//     final result=await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//
//  Navigator.pop(context);
// }
// _askPermission() async{
//
//   if(Platform.isIOS){
//     Map<PermissionGroup,PermissionStatus> permissions=
//     await PermissionHandler().requestPermissions([PermissionGroup.photos]);
//
//
//   }
//   else{
//     PermissionStatus permission=await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.storage);
//   }
// }
//}


// class ImgDetails extends StatefulWidget {
//   @override
//   _ImgDetailsState createState() => _ImgDetailsState();
// }
//
// class _ImgDetailsState extends State<ImgDetails> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   var imgPath  ;
//
//   String home = "Home Screen",
//       lock = "Lock Screen",
//       both = "Both Screen",
//       system = "System";
//
//   String _title = Get.arguments['title'];
//   String _imgUrl = Get.arguments['url'];
//   @override
//   Widget build(BuildContext context) {
//
//     final snackBar = SnackBar(
//       content: Text(_title),
//       duration: const Duration(seconds:3),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_title),
//         centerTitle: true,
//       ),
//       key: _scaffoldKey,
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: double.infinity,
//             child: InteractiveViewer(
//               maxScale: 6,
//               child: FadeInImage(
//                 image: NetworkImage(_imgUrl),
//                 placeholder: AssetImage('assets/img/img_ot_found.jpg'),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width*0.8,
//               height: MediaQuery.of(context).size.height*0.08,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Colors.purple , Colors.purpleAccent]
//                   )
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(icon: Icon(Icons.save_alt_rounded , color: Colors.white,size: 32), onPressed: (){
//                   }),
//                   IconButton(icon: Icon(Icons.imagesearch_roller, color: Colors.white,size: 32), onPressed: (){
//
//                     _modal();
//                   }),
//                   IconButton(icon: Icon(Icons.info_outline, color: Colors.white,size: 32,), onPressed: (){
//
//                     _scaffoldKey.currentState.showSnackBar(snackBar);
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _askPermission() async {
//     if (Platform.isAndroid) {
//
//       await PermissionHandler().requestPermissions([
//         PermissionGroup.storage,
//         PermissionGroup.camera,
//         PermissionGroup.location,
//       ]);
//     } else {
//       await PermissionHandler()
//           .checkPermissionStatus(PermissionGroup.storage);
//     }
//   }
//
//   _modal() {
//     showModalBottomSheet(
//
//         backgroundColor: Colors.white.withOpacity(0.2),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30,)),
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 130,
//             decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.8),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 )
//             ),
//
//             child: Column(
//
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 _createTile(context, 'Home Screen', Icons.home, _action1),
//                 SizedBox(height: 10,),
//                 _createTile(context, 'Lock Screen', Icons.lock, _action2),
//               ],
//             ),
//           );
//         }
//     );
//   }
//
//   ListTile _createTile(BuildContext context, String name, IconData icon,
//       Function action) {
//     return ListTile(
//       leading: Icon(icon,
//         color: Colors.blueAccent,),
//       title: Text(name,
//         style: TextStyle(
//             color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),),
//       onTap: () {
//         Navigator.pop(context);
//         action();
//       },
//     );
//   }
//
//   _action1() async {
//     if (Platform.isAndroid) {
//       await _askPermission();
//     }
//     var response = await Dio()
//         .get(_imgUrl, options: Options(responseType: ResponseType.bytes));
//     //await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//     home = await Wallpaper.homeScreen(_imgUrl);
//     final result = home = home;
//     print(result);
//   }
//
//   _action2() async {
//     if (Platform.isAndroid) {
//       await _askPermission();
//     }
//     var response = await Dio()
//         .get(_imgUrl, options: Options(responseType: ResponseType.bytes));
//     //await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//     home = await Wallpaper.lockScreen(_imgUrl);
//     final result = home = lock;
//     print(result);
//   }
//
//
// }}
}
