import 'dart:convert';
import 'dart:html' as html;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class DatabaseManager {
  var _newsImageStorageReference;
  var _eventsImageStorageReference;
  var _newsStoreCollection;
  var _profileImageRef;
  var _adStoreRef;
  static final DatabaseManager _object = new DatabaseManager();

  DatabaseManager() {
    if (kIsWeb) {
      _newsImageStorageReference = FirebaseStorage.instance.ref('images/news/');
      _eventsImageStorageReference =
          FirebaseStorage.instance.ref('images/events/');
      _profileImageRef = FirebaseStorage.instance.ref('images/profilePhoto/');
      _adStoreRef = FirebaseStorage.instance.ref('images/ads/');
    } else {
      Firebase.initializeApp(
          options: const FirebaseOptions(
        apiKey: "AIzaSyCIMT9JETU32TCv9pJHKU4VNjETQ3CmP7Y",
        authDomain: "vpma-nagpur.firebaseapp.com",
        databaseURL: "https://vpma-nagpur.firebaseio.com",
        projectId: "vpma-nagpur",
        storageBucket: "vpma-nagpur.appspot.com",
        messagingSenderId: "918410724639",
        appId: "1:918410724639:web:a1005174e9443f46d59c2a",
      ));
      _newsImageStorageReference =
          FirebaseStorage.instance.ref().child('images/news');
      _profileImageRef =
          FirebaseStorage.instance.ref().child('images/profilePhoto/');
      _adStoreRef = FirebaseStorage.instance.ref().child('images/ads/');
      _eventsImageStorageReference =
          FirebaseStorage.instance.ref().child('images/events/');
    }
    // _newsStoreCollection = Firestore.instance.collection('news');
  }
  static DatabaseManager get getDbReference => _object;

  Future uploadProfileImage(String uID, html.File image,
      {bool isSelf = false}) async {
    String? imageExtension;
    try {
      await _profileImageRef.child('$uID.png').delete();
    } catch (e) {
      try {
        await _profileImageRef.child('$uID.PNG').delete();
      } catch (e) {
        try {
          await _profileImageRef.child('$uID.jpg').delete();
        } catch (e) {
          try {
            await _profileImageRef.child('$uID.JPG').delete();
          } catch (e) {
            try {
              await _profileImageRef.child('$uID.JPEG').delete();
            } catch (e) {
              try {
                await _profileImageRef.child('$uID.jpeg').delete();
              } catch (e) {
                print(e);
              }
            }
          }
        }
      }
    }
    if (image.name.contains('.png')) {
      imageExtension = '.png';
    } else if (image.name.contains('.PNG')) {
      imageExtension = '.PNG';
    } else if (image.name.contains('.jpg')) {
      imageExtension = '.jpg';
    } else if (image.name.contains('.JPG')) {
      imageExtension = '.JPG';
    } else if (image.name.contains('.jpeg')) {
      imageExtension = '.jpeg';
    } else if (image.name.contains('.JPEG')) {
      imageExtension = '.JPEG';
    }
    try {
      UploadTask uploadTask =
          await _profileImageRef.child(uID + imageExtension!).put(image).future;
      Uri imageURL = Uri.parse(await uploadTask.snapshot.ref.getDownloadURL());

      Future<UserData> futureUser = fetchCurrentUserData(uID);
      UserData currentUser = await futureUser;

      final response = await http.put(
        Uri.parse('${url}memberDatabse/$uID/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          "id": currentUser.id,
          "activeStatus": currentUser.activeStatus,
          "blacklisted": currentUser.blacklisted,
          "contact": currentUser.contact,
          "email": currentUser.email,
          "gstNo": currentUser.gstNo,
          "memberName": currentUser.memberName,
          "memberType": currentUser.memberType,
          "password": currentUser.password,
          "renewalDate": currentUser.renewalDate,
          "shopAddress": currentUser.shopAddress,
          "shopName": currentUser.shopName,
          "userImage": imageURL.toString()
        },
      );
      if (response.statusCode == 200) {
        return imageURL.toString();
      }
      return true;
    } catch (e) {
      print('Image Uploading\n\n' + e.toString());
      return false;
    }
  }
}

Future<UserData> fetchCurrentUserData(String id) async {
  final response = await http.get(
    Uri.parse('${url}memberDatabse/$id/'),
  );

  if (response.statusCode == 200) {
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("");
  }
}
