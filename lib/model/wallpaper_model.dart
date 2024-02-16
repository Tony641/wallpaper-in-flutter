// class WallpaperModel{
//   String ?photographer;
//   String ?photographer_url;
//   int  ?photographer_id;
//   SrcModel ?src;
//   WallpaperModel({
//     this.photographer,
//     this.photographer_id,
//      this.src,
//     this.photographer_url
// });
// factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
//   return WallpaperModel(
//     src: jsonData["src"],
//     photographer_url: jsonData["photographer_url"],
//     photographer_id: jsonData["photographer_id"],
//     photographer: jsonData["photographer"]
//   );}
// }
// class SrcModel{
//   String original;
//   String small;
//   String portrait;
//   SrcModel({
//     required this.original,
//     required this.portrait,
//     required this.small
// });
//   factory SrcModel.fromMap(Map<String,dynamic> jsonData){
//     return SrcModel(original:  jsonData["original"], portrait: jsonData["portrait"], small: jsonData["small"]);
//   }
// }
class PhotosModel {
  String ?url;
  String ?photographer;
  String ?photographerUrl;
  int ?photographerId;
  SrcModel ?src;

  PhotosModel(
      {this.url,
        this.photographer,
        this.photographerId,
         this.photographerUrl,
         this.src});

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({required this.portrait, required this.landscape, required this.large, required this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}