//
//
//
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_filex/open_filex.dart';
//
// import 'package:paintlib/Utils/constraint.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'constant_utils.dart';
//
//
//
//
//
//
//
// class FileDownloadController extends GetxController {
//   var downloadProgress = 0.0.obs; // Observable for progress tracking
//   var isDownloading = false.obs; // Observable for download status
//
//
//
//
//
//   Future<void> downloaddairyFile(String url, String fileName, String token, String type,) async {
//
//
//     try {
//       // Request storage/media permission
//       final status = await Permission.mediaLibrary.request();
//       if (status != PermissionStatus.granted) {
//         print("Permission Denied");
//         showToastFail("Permission Denied: Media library access is required.");
//         return;
//       }
//
//       // Determine base directory
//       Directory baseDir;
//       if (Platform.isAndroid) {
//         baseDir = (await getExternalStorageDirectory())!;
//       } else if (Platform.isIOS) {
//         baseDir = Directory('${(await getApplicationDocumentsDirectory()).path}/Paintlib');
//       } else {
//         throw Exception("Unsupported platform");
//       }
//
//       if (!await baseDir.exists()) {
//         await baseDir.create(recursive: true);
//       }
//
//       // Determine file extension
//       final extension = url.split('.').last;
//       final filePath = "${baseDir.path}/$fileName.$extension";
//
//       // Download file
//       final request = http.Request('GET', Uri.parse(url));
//       // request.headers.addAll({'Authorization': 'Bearer $token'});
//
//       final response = await http.Client().send(request);
//
//       if (response.statusCode == 200) {
//         final file = File(filePath);
//         await response.stream.pipe(file.openWrite());
//
//         print("Download Completed: $filePath");
//         showToastSuccess("Download Completed: $fileName.$extension");
//
//         // Open file
//         await OpenFilex.open(filePath);
//       } else {
//         print("Download Failed: ${response.statusCode}");
//         showToastFail("Download Failed: Status ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error during file download: $e");
//       showToastFail("Error: $e");
//     } finally {
//       //  isDownloading = false;
//     }
//   }
//
//   /// previous working in dairy section download
//   // Future<void> downloaddairyFile(String url, String fileName, String token,String type) async {
//   //   isDownloading.value = true;
//   //   //  String admintoken = await   SharedPrefHelper().get("admintoken");
//   //   Permission _permission = Permission.mediaLibrary;
//   //
//   //   try {
//   //     final result = await _permission.request();
//   //
//   //     if (result == PermissionStatus.granted) {
//   //       Directory? downloadsDirectory;
//   //       if (Platform.isAndroid) {
//   //         downloadsDirectory = Directory('/storage/emulated/0/Download');
//   //         if (!await downloadsDirectory.exists()) {
//   //           downloadsDirectory = await getExternalStorageDirectory();
//   //         }
//   //       } else if (Platform.isIOS) {
//   //         downloadsDirectory = await getApplicationDocumentsDirectory();
//   //         print("This is iOS platform, downloading to: ${downloadsDirectory.path}");
//   //       }
//   //
//   //
//   //       //final filePath = "${downloadsDirectory!.path}/$fileName.$type";
//   //       final filePath = "${downloadsDirectory!.path}/$fileName.$type";
//   //
//   //       final request = http.Request('GET', Uri.parse(url));
//   //       request.headers.addAll({
//   //         'Authorization': 'Bearer $token',
//   //       });
//   //
//   //       final response = await http.Client().send(request);
//   //
//   //       if (response.statusCode == 200) {
//   //         final file = File(filePath);
//   //         await response.stream.pipe(file.openWrite());
//   //
//   //         // Get.snackbar("Download Completed", ": $filePath");
//   //         showToastSuccess("Download Completed"+": $filePath");
//   //         OpenFilex.open(filePath); // Open after download
//   //       } else {
//   //         Get.snackbar('Download Failed', 'Status: ${response.statusCode}');
//   //         showToastFail('Download Failed' + '${response.statusCode}');
//   //       }
//   //     } else {
//   //       showToastFail('Permission Denied' + 'Storage permission is required to download the file.');
//   //
//   //     }
//   //   }on SocketException catch (e) {
//   //     isLoading.value= false;
//   //     print('SocketException: $e');
//   //     showToastFail("Please check your internet");
//   //
//   //   } catch (e) {
//   //     print("error aa gyai diary me : " +  e.toString());
//   //     Get.snackbar('Error', 'An error occurred: $e');
//   //   } finally {
//   //     isDownloading.value = false;
//   //     downloadProgress.value = 0.0;
//   //   }
//   // }
//
//
//   /// commented on 19 aug
//   // Future<void> downloadFile(
//   //     String url,
//   //     String fileName,
//   //     String token,
//   //     String type,
//   //     ) async {
//   //   isDownloading.value = true;
//   //
//   //   Permission _permission = Permission.mediaLibrary;
//   //
//   //   try {
//   //     final result = await _permission.request();
//   //
//   //     if (result == PermissionStatus.granted) {
//   //       Directory? baseDir;
//   //
//   //       if (Platform.isAndroid) {
//   //         baseDir = Directory('/storage/emulated/0/Download/SchoolSphere');
//   //       } else if (Platform.isIOS) {
//   //         baseDir = Directory('${(await getApplicationDocumentsDirectory()).path}/SchoolSphere');
//   //       }
//   //
//   //       if (baseDir == null) {
//   //         showToastFail("Couldn't determine download directory.");
//   //         return;
//   //       }
//   //
//   //       if (!await baseDir.exists()) {
//   //         await baseDir.create(recursive: true);
//   //       }
//   //
//   //       final filePath = "${baseDir.path}/$fileName${type == "export" ? "" : ".pdf"}";
//   //
//   //       final request = http.Request('GET', Uri.parse(url));
//   //       request.headers.addAll({
//   //         'Authorization': 'Bearer $token',
//   //       });
//   //
//   //       final response = await http.Client().send(request);
//   //
//   //       print("Downloading status: ${response.statusCode} | URL: $url");
//   //
//   //       if (response.statusCode == 200) {
//   //         final file = File(filePath);
//   //         await response.stream.pipe(file.openWrite());
//   //
//   //         showToastSuccess("Download Completed: please check School Sphere folder\n$fileName${type == "export" ? "" : ".pdf"}");
//   //
//   //         // Delay opening file to let toast show properly
//   //         Future.delayed(Duration(seconds: 3), () {
//   //           OpenFilex.open(filePath);
//   //         });
//   //       } else {
//   //         showToastFail('Download Failed: ${response.statusCode}');
//   //       }
//   //     } else {
//   //       showToastFail('Permission Denied: Storage permission is required.');
//   //     }
//   //   } on SocketException catch (e) {
//   //     isLoading.value = false;
//   //     print('SocketException: $e');
//   //     showToastFail("Please check your internet");
//   //   } catch (e) {
//   //     print("❌ Error: $e");
//   //     showToastFail("An error occurred: $e");
//   //   } finally {
//   //     isDownloading.value = false;
//   //     downloadProgress.value = 0.0;
//   //   }
//   // }
//
//
//   /// previous download file for school subscription opened 29 aug
//
//
//   Future<void> downloadFile(String url, String fileName, String token,String type) async {
//     isDownloading.value = true;
//     //  String admintoken = await   SharedPrefHelper().get("admintoken");
//     Permission _permission = Permission.mediaLibrary;
//
//     try {
//       final result = await _permission.request();
//
//       if (result == PermissionStatus.granted) {
//         Directory? downloadsDirectory;
//         if (Platform.isAndroid) {
//           downloadsDirectory = Directory('/storage/emulated/0/Download');
//           if (!await downloadsDirectory.exists()) {
//             downloadsDirectory = await getExternalStorageDirectory();
//           }
//         } else if (Platform.isIOS) {
//           downloadsDirectory = await getApplicationDocumentsDirectory();
//           print("This is iOS platform, downloading to: ${downloadsDirectory.path}");
//         }
//
//
//         final filePath = "${downloadsDirectory!.path}/$fileName${type=="export"?"" : ".pdf" }";
//
//         final request = http.Request('GET', Uri.parse(url));
//         request.headers.addAll({
//           'Authorization': 'Bearer $token',
//         });
//
//         final response = await http.Client().send(request);
//
//
//         print("downloading testin  : " +  response.statusCode.toString()  +  " : url is : " + url);
//
//         if (response.statusCode == 200) {
//           final file = File(filePath);
//           await response.stream.pipe(file.openWrite());
//
//           // Get.snackbar("Download Completed", ": $filePath");
//           showToastSuccess("Download Completed"+": $filePath");
//           OpenFilex.open(filePath); // Open after download
//         } else {
//           //  Get.snackbar('Download Failed', 'Status: ${response.statusCode}');
//           showToastFail('Download Failed' + '${response.statusCode}');
//         }
//       } else {
//         showToastFail('Permission Denied' + 'Storage permission is required to download the file.');
//
//       }
//     }on SocketException catch (e) {
//       isLoading.value= false;
//       print('SocketException: $e');
//       showToastFail("Please check your internet");
//
//     } catch (e) {
//       print("error aa gyai : " +  e.toString());
//       showToastFail('Error'+ 'An error occurred: $e');
//
//     } finally {
//       isDownloading.value = false;
//       downloadProgress.value = 0.0;
//     }
//   }
//
//   Future<void> downloadFilexport(String url, String fileName) async {
//     isDownloading.value = true;
//     Permission _permission = Permission.mediaLibrary;
//
//     try {
//       // start new
//
//       final result = await _permission.request();
//
//       if (result == PermissionStatus.granted) {
//         Directory? downloadsDirectory;
//         if (Platform.isAndroid) {
//           downloadsDirectory = Directory('/storage/emulated/0/Download');
//           if (!await downloadsDirectory.exists()) {
//             downloadsDirectory = await getExternalStorageDirectory();
//           }
//         } else if (Platform.isIOS) {
//           downloadsDirectory = await getApplicationDocumentsDirectory();
//           print("This is iOS platform, downloading to: ${downloadsDirectory.path}");
//         }
//
//         final filePath = "${downloadsDirectory!.path}/$fileName.csv";
//
//         final response = await http.Client().send(http.Request('GET', Uri.parse(url)));
//
//         if (response.statusCode == 200) {
//           final file = File(filePath);
//           await response.stream.pipe(file.openWrite());
//           showToastSuccess("Download Completed: $filePath");
//           // Get.snackbar("Download Completed",": $filePath");
//           // Open the file after download completes
//           OpenFilex.open(filePath);  // This will open the file automatically
//         } else {
//           showToastFail('Download Failed: Status ${response.statusCode}');
//         }
//
//         if (result == null) {
//
//           return;
//         } else {
//
//
//
//         }
//       } else {}
//
//
//
//
//
//
//     } on SocketException catch (e) {
//       isLoading.value= false;
//       print('SocketException: $e');
//       showToastFail("Please check your internet");
//
//     } catch (e) {
//       showToastFail('Error: An error occurred: $e');
//     } finally {
//       isDownloading.value = false;
//       downloadProgress.value = 0.0;
//     }
//   }
//
//
//
//
//   var isLoading = false.obs;
//   var fileurlis= "".obs;
//
//   Future<void> exportExpense(String urls, String fileName, String token,String type) async {
//     isLoading.value = true;
//
//     final url = Uri.parse(
//       urls.toString(),
//     );
//
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//
//
//         // Handle the URL for the exported file
//         String? fileUrl = jsonResponse["fileUrl"];
//         fileurlis.value = jsonResponse["fileUrl"];
//         if (fileUrl != null) {
//           // Perform actions with the fileUrl, such as displaying or downloading the file
//           print("Exported file URL: $fileUrl");
//
//           downloadFilexport(fileurlis.value,fileurlis.value.split('/').last.toString());
//         } else {
//           print("File URL is not available in response.");
//           showToastFail("File URL is not available in response.");
//         }
//       } else {
//         print("Failed to export expense: ${response.statusCode}");
//         showToastFail("Failed to export expense: Status ${response.statusCode}");
//       }
//     } on SocketException catch (e) {
//       isLoading.value= false;
//       print('SocketException: $e');
//       showToastFail("Please check your internet");
//
//     } catch (e) {
//       print("Error exporting expense: $e");
//       showToastFail("Error exporting expense: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
//
// }
//
//
// /// for web and gunit
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:open_filex/open_filex.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:school/Utils/constant_utils.dart';
// // import 'package:school/Utils/shared_prehelper.dart';
// // import 'package:universal_html/html.dart' as html;
// //
// // class FileDownloadController extends GetxController {
// //   var downloadProgress = 0.0.obs; // Observable for progress tracking
// //   var isDownloading = false.obs; // Observable for download status
// //   var isLoading = false.obs;
// //   var fileurlis = "".obs;
// //
// //   Future<void> downloaddairyFile(
// //       String url, String fileName, String token, String type) async {
// //     isDownloading.value = true;
// //
// //     try {
// //       if (kIsWeb) {
// //         // Web: Download file using browser's download mechanism
// //         final response = await http.get(
// //           Uri.parse(url),
// //           headers: {'Authorization': 'Bearer $token'},
// //         );
// //
// //         print("Web download status: ${response.statusCode} | URL: $url");
// //
// //         if (response.statusCode == 200) {
// //           final blob = html.Blob([response.bodyBytes]);
// //           final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
// //           final anchor = html.AnchorElement(href: downloadUrl)
// //             ..setAttribute('download', '$fileName.$type')
// //             ..click();
// //           html.Url.revokeObjectUrl(downloadUrl);
// //
// //           showToastSuccess("Download completed: $fileName.$type");
// //         } else {
// //           showToastFail('Download Failed: ${response.statusCode}');
// //         }
// //       } else {
// //         // Mobile: Save to public Downloads directory or app's private directory
// //         Directory? downloadDir;
// //         String finalFileName = '$fileName.$type';
// //
// //         if (Platform.isAndroid) {
// //           // Request storage permission for Android
// //           var status = await Permission.storage.request();
// //           if (status.isGranted) {
// //             downloadDir = Directory('/storage/emulated/0/Download/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           } else {
// //             showToastFail("Storage permission denied, saving to app directory");
// //             downloadDir = await getApplicationDocumentsDirectory();
// //             downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           }
// //         } else if (Platform.isIOS) {
// //           downloadDir = await getApplicationDocumentsDirectory();
// //           downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //           if (!await downloadDir.exists()) {
// //             await downloadDir.create(recursive: true);
// //           }
// //         } else {
// //           showToastFail("Unsupported platform");
// //           return;
// //         }
// //
// //         final String filePath = '${downloadDir.path}/$finalFileName';
// //         print("📂 Download path: $filePath");
// //
// //         // Download the file
// //         final response = await http.get(
// //           Uri.parse(url),
// //           headers: {'Authorization': 'Bearer $token'},
// //         );
// //
// //         print("📡 Mobile download status: ${response.statusCode}");
// //
// //         if (response.statusCode == 200) {
// //           final File file = File(filePath);
// //           await file.writeAsBytes(response.bodyBytes);
// //
// //           print("✅ File saved successfully to: $filePath");
// //           showToastSuccess(
// //               "✅ Download completed!\nFile saved in ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}/$finalFileName");
// //
// //           Future.delayed(Duration(seconds: 1), () async {
// //             try {
// //               final result = await OpenFilex.open(filePath);
// //               print("📖 File open result: ${result.message}");
// //             } catch (e) {
// //               print("⚠️ Could not auto-open file: $e");
// //               showToastSuccess(
// //                   "📁 File downloaded! Open from ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}");
// //             }
// //           });
// //         } else {
// //           showToastFail('❌ Download Failed: ${response.statusCode}');
// //         }
// //       }
// //     } on SocketException catch (e) {
// //       print('🌐 SocketException: $e');
// //       showToastFail("Please check your internet connection");
// //     } catch (e) {
// //       print("❌ Error in diary download: $e");
// //       showToastFail("Download failed: $e");
// //     } finally {
// //       isDownloading.value = false;
// //       downloadProgress.value = 0.0;
// //     }
// //   }
// //
// //   Future<void> downloadFile(
// //       String url, String fileName, String token, String type) async {
// //     isDownloading.value = true;
// //
// //     try {
// //       if (kIsWeb) {
// //         // Web: Download file using browser's download mechanism
// //         final response = await http.get(
// //           Uri.parse(url),
// //           headers: {'Authorization': 'Bearer $token'},
// //         );
// //
// //         print("Web download status: ${response.statusCode} | URL: $url");
// //
// //         if (response.statusCode == 200) {
// //           String finalFileName;
// //           String mimeType;
// //
// //           if (type == "export") {
// //             finalFileName = fileName;
// //             if (fileName.toLowerCase().endsWith('.xlsx')) {
// //               mimeType =
// //               'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
// //             } else if (fileName.toLowerCase().endsWith('.csv')) {
// //               mimeType = 'text/csv';
// //             } else {
// //               finalFileName = '$fileName.xlsx';
// //               mimeType =
// //               'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
// //             }
// //           } else {
// //             finalFileName = '$fileName.pdf';
// //             mimeType = 'application/pdf';
// //           }
// //
// //           final blob = html.Blob([response.bodyBytes], mimeType);
// //           final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
// //           final anchor = html.AnchorElement(href: downloadUrl)
// //             ..setAttribute('download', finalFileName)
// //             ..click();
// //           html.Url.revokeObjectUrl(downloadUrl);
// //
// //           showToastSuccess("Download completed: $finalFileName");
// //         } else {
// //           showToastFail('Download Failed: ${response.statusCode}');
// //         }
// //       } else {
// //         // Mobile: Save to public Downloads directory or app's private directory
// //         Directory? downloadDir;
// //         String finalFileName = type == "export" ? fileName : '$fileName.pdf';
// //
// //         if (Platform.isAndroid) {
// //           var status = await Permission.storage.request();
// //           if (status.isGranted) {
// //             downloadDir = Directory('/storage/emulated/0/Download/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           } else {
// //             showToastFail("Storage permission denied, saving to app directory");
// //             downloadDir = await getApplicationDocumentsDirectory();
// //             downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           }
// //         } else if (Platform.isIOS) {
// //           downloadDir = await getApplicationDocumentsDirectory();
// //           downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //           if (!await downloadDir.exists()) {
// //             await downloadDir.create(recursive: true);
// //           }
// //         } else {
// //           showToastFail("Unsupported platform");
// //           return;
// //         }
// //
// //         final String filePath = '${downloadDir.path}/$finalFileName';
// //         print("📂 Download path: $filePath");
// //
// //         // Download the file
// //         final response = await http.get(
// //           Uri.parse(url),
// //           headers: {'Authorization': 'Bearer $token'},
// //         );
// //
// //         print("📡 Mobile download status: ${response.statusCode}");
// //
// //         if (response.statusCode == 200) {
// //           final File file = File(filePath);
// //           await file.writeAsBytes(response.bodyBytes);
// //
// //           print("✅ File saved successfully to: $filePath");
// //           showToastSuccess(
// //               "✅ Download completed!\nFile saved in ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}/$finalFileName");
// //
// //           Future.delayed(Duration(seconds: 1), () async {
// //             try {
// //               final result = await OpenFilex.open(filePath);
// //               print("📖 File open result: ${result.message}");
// //             } catch (e) {
// //               print("⚠️ Could not auto-open file: $e");
// //               showToastSuccess(
// //                   "📁 File downloaded! Open from ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}");
// //             }
// //           });
// //         } else {
// //           showToastFail('❌ Download Failed: ${response.statusCode}');
// //         }
// //       }
// //     } on SocketException catch (e) {
// //       print('🌐 SocketException: $e');
// //       showToastFail("Please check your internet connection");
// //     } catch (e) {
// //       print("❌ Error: $e");
// //       showToastFail("Download failed: $e");
// //     } finally {
// //       isDownloading.value = false;
// //       downloadProgress.value = 0.0;
// //     }
// //   }
// //
// //   Future<void> downloadFilexport(String url, String fileName,
// //       {String? token}) async {
// //     isDownloading.value = true;
// //
// //     try {
// //       if (kIsWeb) {
// //         // Web: Download file using browser's download mechanism
// //         Map<String, String> headers = {};
// //         if (token != null && token.isNotEmpty) {
// //           headers['Authorization'] = 'Bearer $token';
// //         }
// //
// //         final response = await http.get(Uri.parse(url), headers: headers);
// //
// //         print("Web download status: ${response.statusCode} | URL: $url");
// //         print("Web download headers: $headers");
// //         print("Response content-type: ${response.headers['content-type']}");
// //
// //         if (response.statusCode == 200) {
// //           // Ensure proper file extension
// //           String finalFileName = fileName;
// //           if (!fileName.toLowerCase().endsWith('.xlsx') &&
// //               !fileName.toLowerCase().endsWith('.xls') &&
// //               !fileName.toLowerCase().endsWith('.csv')) {
// //             finalFileName = '$fileName.xlsx'; // Default to Excel format
// //           }
// //
// //           // Create blob with proper MIME type
// //           String mimeType;
// //           if (finalFileName.toLowerCase().endsWith('.csv')) {
// //             mimeType = 'text/csv';
// //           } else if (finalFileName.toLowerCase().endsWith('.xlsx')) {
// //             mimeType =
// //             'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
// //           } else if (finalFileName.toLowerCase().endsWith('.xls')) {
// //             mimeType = 'application/vnd.ms-excel';
// //           } else {
// //             mimeType = 'application/octet-stream';
// //           }
// //
// //           final blob = html.Blob([response.bodyBytes], mimeType);
// //           final downloadUrl = html.Url.createObjectUrlFromBlob(blob);
// //           final anchor = html.AnchorElement(href: downloadUrl)
// //             ..download = finalFileName
// //             ..style.display = 'none';
// //
// //           html.document.body!.append(anchor);
// //           anchor.click();
// //           anchor.remove();
// //           html.Url.revokeObjectUrl(downloadUrl);
// //
// //           showToastSuccess("Download completed: $finalFileName");
// //           print("✅ File downloaded successfully: $finalFileName");
// //         } else {
// //           print("Web download error response: ${response.body}");
// //           showToastFail('Download Failed: ${response.statusCode}');
// //         }
// //       } else {
// //         // Mobile: Save to public Downloads directory or app's private directory
// //         Directory? downloadDir;
// //         String finalFileName = fileName;
// //
// //         // Ensure proper file extension
// //         if (!fileName.toLowerCase().endsWith('.xlsx') &&
// //             !fileName.toLowerCase().endsWith('.xls') &&
// //             !fileName.toLowerCase().endsWith('.csv')) {
// //           finalFileName = '$fileName.xlsx';
// //         }
// //
// //         if (Platform.isAndroid) {
// //           var status = await Permission.storage.request();
// //           if (status.isGranted) {
// //             downloadDir = Directory('/storage/emulated/0/Download/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           } else {
// //             showToastFail("Storage permission denied, saving to app directory");
// //             downloadDir = await getApplicationDocumentsDirectory();
// //             downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //             if (!await downloadDir.exists()) {
// //               await downloadDir.create(recursive: true);
// //             }
// //           }
// //         } else if (Platform.isIOS) {
// //           downloadDir = await getApplicationDocumentsDirectory();
// //           downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //           if (!await downloadDir.exists()) {
// //             await downloadDir.create(recursive: true);
// //           }
// //         } else {
// //           showToastFail("Unsupported platform");
// //           return;
// //         }
// //
// //         final filePath = '${downloadDir.path}/$finalFileName';
// //         print("Download path: $filePath");
// //
// //         final request = http.Request('GET', Uri.parse(url));
// //         if (token != null && token.isNotEmpty) {
// //           request.headers['Authorization'] = 'Bearer $token';
// //         }
// //
// //         final response = await http.Client().send(request);
// //         print("Mobile download status: ${response.statusCode} | URL: $url");
// //
// //         if (response.statusCode == 200) {
// //           final file = File(filePath);
// //           await response.stream.pipe(file.openWrite());
// //
// //           showToastSuccess(
// //               "Download completed!\nFile saved to: ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}/$finalFileName");
// //           print("✅ File saved to: $filePath");
// //
// //           Future.delayed(Duration(seconds: 2), () async {
// //             try {
// //               final result = await OpenFilex.open(filePath);
// //               print("📖 File open result: ${result.message}");
// //             } catch (e) {
// //               print("⚠️ Could not auto-open file: $e");
// //               showToastSuccess(
// //                   "File saved! Open from ${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}");
// //             }
// //           });
// //         } else {
// //           showToastFail('Download Failed: ${response.statusCode}');
// //         }
// //       }
// //     } on SocketException catch (e) {
// //       print('SocketException: $e');
// //       showToastFail("Please check your internet connection");
// //     } catch (e) {
// //       print("❌ Error: $e");
// //       showToastFail("An error occurred: $e");
// //     } finally {
// //       isDownloading.value = false;
// //       downloadProgress.value = 0.0;
// //     }
// //   }
// //
// //   Future<void> exportExpense(
// //       String urls, String fileName, String token, String type) async {
// //     isLoading.value = true;
// //
// //     final url = Uri.parse(urls);
// //
// //     try {
// //       final response = await http.get(
// //         url,
// //         headers: {'Authorization': 'Bearer $token'},
// //       );
// //
// //       print("Export expense status: ${response.statusCode} | URL: $urls");
// //
// //       if (response.statusCode == 200) {
// //         final jsonResponse = json.decode(response.body);
// //         String? fileUrl = jsonResponse["fileUrl"];
// //         fileurlis.value = fileUrl ?? "";
// //
// //         if (fileUrl != null) {
// //           print("Exported file URL: $fileUrl");
// //           String finalFileName = fileName;
// //           if (!fileName.contains('.')) {
// //             finalFileName = '$fileName.xlsx';
// //           }
// //           await downloadFilexport(fileUrl, finalFileName, token: token);
// //         } else {
// //           showToastFail("File URL is not available in response.");
// //         }
// //       } else {
// //         showToastFail("Failed to export expense: ${response.statusCode}");
// //       }
// //     } on SocketException catch (e) {
// //       print('SocketException: $e');
// //       showToastFail("Please check your internet");
// //     } catch (e) {
// //       print("Error exporting expense: $e");
// //       showToastFail("An error occurred: $e");
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //   Future<void> showDownloadedFiles() async {
// //     try {
// //       Directory downloadDir;
// //       if (Platform.isAndroid) {
// //         downloadDir = Directory('/storage/emulated/0/Download/SchoolSphere');
// //         if (!await downloadDir.exists()) {
// //           downloadDir = await getApplicationDocumentsDirectory();
// //           downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //         }
// //       } else if (Platform.isIOS) {
// //         downloadDir = await getApplicationDocumentsDirectory();
// //         downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //       } else {
// //         showToastFail("Unsupported platform");
// //         return;
// //       }
// //
// //       if (await downloadDir.exists()) {
// //         final List<FileSystemEntity> files = downloadDir.listSync();
// //         if (files.isNotEmpty) {
// //           showToastSuccess(
// //               "📁 Downloaded files location:\n${downloadDir.path}");
// //           for (var file in files) {
// //             print("📄 Downloaded file: ${file.path}");
// //           }
// //         } else {
// //           showToastSuccess("📁 No downloaded files found");
// //         }
// //       } else {
// //         showToastSuccess("📁 No downloads folder found");
// //       }
// //     } catch (e) {
// //       print("Error checking downloads: $e");
// //       showToastFail("Could not access downloads folder");
// //     }
// //   }
// //
// //   Future<String> getAppDownloadPath() async {
// //     Directory appDir = await getApplicationDocumentsDirectory();
// //     Directory schoolSphereDir = Directory('${appDir.path}/SchoolSphere');
// //
// //     if (!await schoolSphereDir.exists()) {
// //       await schoolSphereDir.create(recursive: true);
// //     }
// //
// //     return schoolSphereDir.path;
// //   }
// //
// //   Future<void> showDownloadLocation() async {
// //     if (kIsWeb) {
// //       showToastSuccess("Files are downloaded to your browser's default download location");
// //       return;
// //     }
// //
// //     try {
// //       Directory downloadDir;
// //       if (Platform.isAndroid) {
// //         downloadDir = Directory('/storage/emulated/0/Download/SchoolSphere');
// //         if (!await downloadDir.exists()) {
// //           downloadDir = await getApplicationDocumentsDirectory();
// //           downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //         }
// //       } else if (Platform.isIOS) {
// //         downloadDir = await getApplicationDocumentsDirectory();
// //         downloadDir = Directory('${downloadDir.path}/SchoolSphere');
// //       } else {
// //         showToastFail("Unsupported platform");
// //         return;
// //       }
// //
// //       if (await downloadDir.exists()) {
// //         showToastSuccess(
// //             "Files are saved in:\n${Platform.isAndroid ? 'Downloads/SchoolSphere' : 'Files app/SchoolSphere'}");
// //       } else {
// //         showToastSuccess("No downloads folder found. Download a file first.");
// //       }
// //     } catch (e) {
// //       print("Error accessing downloads: $e");
// //       showToastFail("Could not access downloads folder");
// //     }
// //   }
// // }
