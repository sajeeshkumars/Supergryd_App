// // ignore_for_file: must_be_immutable
//
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../generated/assets.dart';
//
//
// class CommonImageView extends StatelessWidget {
//   ///[url] is required parameter for fetching network image
//   String? url;
//   String? imagePath;
//   String? svgPath;
//   File? file;
//   double? height;
//   double? width;
//   Color? color;
//   final BoxFit fit;
//   final String placeHolder;
//   final bool? isCircleImage;
//
//   ///a [CommonNetworkImageView] it can be used for showing any network images
//   /// it will shows the placeholder image if image is not found on network
//   CommonImageView({
//     this.url,
//     this.imagePath,
//     this.svgPath,
//     this.file,
//     this.height,
//     this.width,
//     this.color,
//     this.fit = BoxFit.contain,
//     this.placeHolder = "packages/mynewpackage/${Assets.imagesImageNotFound}",
//     this.isCircleImage = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildImageView();
//   }
//
//   Widget _buildImageView() {
//     if (svgPath != null && svgPath!.isNotEmpty) {
//       return Container(
//         height: height,
//         width: width,
//         child: SvgPicture.asset(
//           svgPath!,
//           height: height,
//           width: width,
//           fit: fit,
//           color: color,
//         ),
//       );
//     } else if (file != null && file!.path.isNotEmpty) {
//       return Image.file(
//         file!,
//         height: height,
//         width: width,
//         fit: fit,
//         color: color,
//       );
//     } else if (url != null) {
//       RegExp regExp = RegExp(r"(\d+)\.(jpg|jpeg|png|PNG|JPEG|JPG)");
//       Match? match = regExp.firstMatch(url!);
//       String? id = match?.group(1);
//       print('imege key id $id');
//       if (isCircleImage!) {
//         return ClipOval(
//           child: CachedNetworkImage(
//             repeat: ImageRepeat.noRepeat,
//             height: height,
//             width: width,
//             fit: fit,
//             imageUrl: url!,cacheKey: id,
//             imageBuilder: (context, imageProvioder) {
//               return Container(
//                 decoration: BoxDecoration(
//                   image:
//                   DecorationImage(image: imageProvioder, fit: BoxFit.cover),
//                 ),
//               );
//             },
//             placeholder: (context, url) => Container(
//               height: 30,
//               width: 30,
//               child: LinearProgressIndicator(
//                 color: Colors.grey.shade200,
//                 backgroundColor: Colors.grey.shade100,
//               ),
//             ),
//             errorWidget: (context, url, error) =>     placeHolder == "packages/mynewpackage/${Assets.imagesImageNotFound}"
//                 ? Image.asset(
//               placeHolder,
//               height: height,
//               width: width,
//               fit: fit,
//             )
//                 : SvgPicture.asset(
//               placeHolder,
//               height: 10,
//               width: 10,
//               fit: BoxFit.contain,
//             ),
//           ),
//         );
//       }
//       return Image.network(
//         height: height,
//         width: width,
//         fit: fit,
//          url!,
//         // cacheKey: id,
//         // imageBuilder: (context, imageProvioder) {
//         //   return Container(
//         //     decoration: BoxDecoration(
//         //       image:
//         //       DecorationImage(image: imageProvioder, fit: BoxFit.cover),
//         //     ),
//         //   );
//         // },
//         // placeholder: (context, url) => Container(
//         //   height: 30,
//         //   width: 30,
//         //   child: LinearProgressIndicator(
//         //     color: Colors.grey.shade200,
//         //     backgroundColor: Colors.grey.shade100,
//         //   ),
//         // ),
//         // errorWidget: (context, url, error) =>     placeHolder == "packages/mynewpackage/${Assets.imagesImageNotFound}"
//         //     ? Image.asset(
//         //   placeHolder,
//         //   height: height,
//         //   width: width,
//         //   fit: fit,
//         // )
//         //     : SvgPicture.asset(
//         //   placeHolder,
//         //   height: 10,
//         //   width: 10,
//         //   fit: BoxFit.contain,
//         // ),
//       );
//     } else if (imagePath != null && imagePath!.isNotEmpty) {
//       return Image.asset(
//
//         imagePath!,
//         height: height,
//         width: width,
//         fit: fit,
//       );
//     }
//     return SizedBox();
//   }
// }
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../generated/assets.dart';

class CommonImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  Color? color;
  final BoxFit fit;
  final String placeHolder;
  final bool? isCircleImage;
  final String? cacheKey;

  ///a [CommonNetworkImageView] it can be used for showing any network images
  /// it will shows the placeholder image if image is not found on network
  CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.placeHolder = "packages/mynewpackage/${Assets.imagesImageNotFound}",
    this.isCircleImage = false,
    this.cacheKey,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.network(
          placeholderBuilder: (context) => SizedBox(
            height: 30,
            width: 30,
            // child: LinearProgressIndicator(
            //   color: Colors.grey.shade200,
            //   backgroundColor: Colors.grey.shade100,
            // ),
            child: CircularProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
              strokeWidth: 1,
            ),
          ),
          svgPath!,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    } else if (url != null) {
      // RegExp regExp = RegExp(r"(\d+)\.(jpg|jpeg|png|PNG|JPEG|JPG)");
      // Match? match = regExp.firstMatch(url!);
      // String? id = match?.group(1);
      // print('imege key id $id');
      if (isCircleImage!) {
        return ClipOval(
          child: CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: url!,
            cacheKey: cacheKey,
            imageBuilder: (context, imageProvioder) {
              return Container(
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvioder, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => placeHolder ==
                    "packages/mynewpackage/${Assets.imagesImageNotFound}"
                ? Image.asset(
                    placeHolder,
                    height: height,
                    width: width,
                    fit: fit,
                  )
                : SvgPicture.asset(
                    placeHolder,
                    height: 10,
                    width: 10,
                    fit: BoxFit.contain,
                  ),
          ),
        );
      }
      return CachedNetworkImage(
        height: height,
        width: width,
        fit: fit,
        imageUrl: url!,
        cacheKey: cacheKey,
        imageBuilder: (context, imageProvioder) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvioder, fit: BoxFit.cover),
            ),
          );
        },
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: LinearProgressIndicator(
            color: Colors.grey.shade200,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) =>
            placeHolder == "packages/mynewpackage/${Assets.imagesImageNotFound}"
                ? Image.asset(
                    placeHolder,
                    height: height,
                    width: width,
                    fit: fit,
                  )
                : SvgPicture.asset(
                    placeHolder,
                    height: 10,
                    width: 10,
                    fit: BoxFit.contain,
                  ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
      );
    }
    return const SizedBox();
  }
}
