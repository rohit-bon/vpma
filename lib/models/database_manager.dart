// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:html' as html;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:vpma_nagpur/models/add_data.dart';
import 'package:vpma_nagpur/models/events_data.dart';
import 'package:vpma_nagpur/models/member_data.dart';
import 'package:vpma_nagpur/models/news_data.dart';
import 'package:vpma_nagpur/models/query_data.dart';
import 'package:vpma_nagpur/models/reply_data.dart';
import 'package:vpma_nagpur/models/uder_data.dart';
import 'package:vpma_nagpur/utils/constants.dart';

class DatabaseManager {
  dynamic _newsImageStorageReference;
  dynamic _eventsImageStorageReference;
  dynamic _newsStoreCollection;
  dynamic _profileImageRef;
  dynamic _adStoreRef;
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

  Future uploadAds(html.File image, html.File imageA) async {
    String? imageExtension;
    String? imageAExtension;

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

    if (imageA.name.contains('.png')) {
      imageAExtension = '.png';
    } else if (imageA.name.contains('.PNG')) {
      imageAExtension = '.PNG';
    } else if (imageA.name.contains('.jpg')) {
      imageAExtension = '.jpg';
    } else if (imageA.name.contains('.JPG')) {
      imageAExtension = '.JPG';
    } else if (imageA.name.contains('.jpeg')) {
      imageAExtension = '.jpeg';
    } else if (imageA.name.contains('.JPEG')) {
      imageAExtension = '.JPEG';
    }

    try {
      var imagename = FieldValue.serverTimestamp();
    } catch (e) {}
  }

  Future<bool> deleteAd(AdData _data) async {
    String uID = _data.published.toDate().toString() + '_1';
    String aID = _data.published.toDate().toString() + '_2';
    try {
      await _adStoreRef.child(uID + '.png').delete();
    } catch (e) {
      print(e);
      try {
        await _adStoreRef.child(uID + '.PNG').delete();
      } catch (e) {
        print(e);
        try {
          await _adStoreRef.child(uID + '.jpg').delete();
        } catch (e) {
          print(e);
          try {
            await _adStoreRef.child(uID + '.JPG').delete();
          } catch (e) {
            print(e);
            try {
              await _adStoreRef.child(uID + '.JPEG').delete();
            } catch (e) {
              print(e);
              try {
                await _adStoreRef.child(uID + '.jpeg').delete();
              } catch (e) {
                print(e);
              }
            }
          }
        }
      }
    }
    try {
      await _adStoreRef.child(aID + '.png').delete();
    } catch (e) {
      print(e);
      try {
        await _adStoreRef.child(aID + '.PNG').delete();
      } catch (e) {
        print(e);
        try {
          await _adStoreRef.child(aID + '.jpg').delete();
        } catch (e) {
          print(e);
          try {
            await _adStoreRef.child(aID + '.JPG').delete();
          } catch (e) {
            print(e);
            try {
              await _adStoreRef.child(aID + '.JPEG').delete();
            } catch (e) {
              print(e);
              try {
                await _adStoreRef.child(aID + '.jpeg').delete();
              } catch (e) {
                print(e);
              }
            }
          }
        }
      }
    }
    try {
      // await Firestore.instance
      //     .collection('adsData')
      //     .document(_data.adID)
      //     .delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String> getFirebaseImage(String imageLoc) async {
    try {
      var imageString =
          await _newsImageStorageReference.child(imageLoc).getDownloadURL();
      print(imageString.toString());
      return imageString.toString();
    } catch (e) {
      return '0';
    }
  }

  Future<bool> writeNews(NewsData data, bool isImage, html.File image) async {
    String imageExtension;

    if (isImage) {
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
        var imagename = FieldValue.serverTimestamp();
        data.published = imagename;

        // await _newsStoreCollection.add(data.toMap()).then((value) async {
        //   await _newsStoreCollection
        //       .document(value.documentID)
        //       .get()
        //       .then((value) async {
        //     String imageName = value.data['published'].toDate().toString();
        //     UploadTaskSnapshot uploadTask = await _newsImageStorageReference
        //         .child(imageName + imageExtension)
        //         .put(image)
        //         .future;
        //     Uri imageURL = await uploadTask.ref.getDownloadURL();
        //     Map<String, dynamic> data = {
        //       'image': imageURL.toString(),
        //     };
        //     await _newsStoreCollection
        //         .document(value.documentID)
        //         .updateData(data);
        //   });
        // }
        // );
        return true;
      } catch (e) {
        print('Uploading News\n\n' + e.toString());
        return false;
      }
    } else {
      try {
        data.published = FieldValue.serverTimestamp();
        // _newsStoreCollection.add(data.toMap());
        return true;
      } catch (e) {
        print('Uploading News\n\n' + e.toString());
        return false;
      }
    }
  }

  Future<bool> deleteNews(NewsData _data) async {
    if (_data.image != null || _data.image.toString() != 'null') {
      String imageName = _data.published.toDate().toString();
      try {
        await _newsImageStorageReference.child(imageName + '.png').delete();
      } catch (e) {
        print(e);
        try {
          await _newsImageStorageReference.child(imageName + '.PNG').delete();
        } catch (e) {
          print(e);
          try {
            await _newsImageStorageReference.child(imageName + '.jpg').delete();
          } catch (e) {
            print(e);
            try {
              await _newsImageStorageReference
                  .child(imageName + '.JPG')
                  .delete();
            } catch (e) {
              print(e);
              try {
                await _newsImageStorageReference
                    .child(imageName + '.JPEG')
                    .delete();
              } catch (e) {
                print(e);
                try {
                  await _newsImageStorageReference
                      .child(imageName + '.jpeg')
                      .delete();
                } catch (e) {
                  print(e);
                }
              }
            }
          }
        }
      }
      try {
        // await _newsStoreCollection.document(_data.newsID).delete();
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      try {
        // await _newsStoreCollection.document(_data.newsID).delete();
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  Stream<List<NewsData>> getNews() {
    Stream<List<NewsData>>? dataSnaps;
    // Stream<List<NewsData>> dataSnaps = Firestore.instance
    //     .collection('news')
    //     .orderBy('published', descending: true)
    //     .snapshots()
    //     .map((snapShots) =>
    //         snapShots.documents.map((doc) => NewsData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Stream<List<EventsData>> getEvents() {
    Stream<List<EventsData>>? dataSnaps;
    // = Firestore.instance
    //     .collection('events')
    //     .snapshots()
    //     .map((snapShots) =>
    //         snapShots.documents.map((doc) => EventsData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Future<bool> writeEvent(EventsData _data, List<html.File> _images) async {
    //_eventsImageStorageReference
    String imageExtension;
    List<String> imagesLink = [];
    if (_images.length == 0) {
      _data.eventDate = FieldValue.serverTimestamp().toString();
      try {
        // await Firestore.instance.collection('events').add(_data.toMap());
        return true;
      } catch (e) {
        print('Wirting News : \n' + e.toString());
        return false;
      }
    } else {
      _data.eventDate = DateTime.now() as String?;
      for (int i = 0; i < _images.length; i++) {
        html.File image = _images[i];
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
          String timeStamp = _data.eventDate!.toString();
          String folderName = _data.eventHead!.replaceAll(' ', '') +
              timeStamp.replaceAll('T', ' ');
          // String imageLoc =
          //     folderName + '_image_' + i.toString() + imageExtension;
          // UploadTaskSnapshot uploadTask = await _eventsImageStorageReference
          //     .child(imageLoc)
          //     .put(image)
          //     .future;
          // Uri imageURL = await uploadTask.ref.getDownloadURL();
          // imagesLink.add(imageURL.toString());
        } catch (e) {
          print('Uploading News\n\n' + e.toString());
          return false;
        }
      }
      _data.eventThumb = imagesLink[0];
      // await Firestore.instance
      //     .collection('events')
      //     .add(_data.toMap())
      //     .then((value) async {
      //   for (int i = 0; i < imagesLink.length; i++) {
      //     await Firestore.instance
      //         .collection('events')
      //         .document(value.documentID)
      //         .collection('imageGallery')
      //         .add({'imageURL': imagesLink[i]});
      //   }
      // });
      return true;
    }
  }

  Future<bool> deleteEvent(EventsData _data) async {
    if (_data.eventThumb != null || _data.eventThumb.toString() != 'null') {
      int i = 0;
      bool isLooped = true;
      while (isLooped) {
        // dynamic imageName = _data.eventHead!.replaceAll(' ', '') +
        //     _data.eventDate!.toDate().toString() +
        //     '_image_' +
        //     i.toString();

        try {
          await _eventsImageStorageReference.child('.png').delete();
        } catch (e) {
          print(e);
          try {
            await _eventsImageStorageReference.child('.PNG').delete();
          } catch (e) {
            print(e);
            try {
              await _eventsImageStorageReference.child('.jpg').delete();
            } catch (e) {
              print(e);
              try {
                await _eventsImageStorageReference.child('.JPG').delete();
              } catch (e) {
                print(e);
                try {
                  await _eventsImageStorageReference.child('.JPEG').delete();
                } catch (e) {
                  print(e);
                  try {
                    await _eventsImageStorageReference.child('.jpeg').delete();
                  } catch (e) {
                    print(e);
                    isLooped = false;
                  }
                }
              }
            }
          }
        }
        i++;
      }
      try {
        // await Firestore.instance
        //     .collection('events')
        //     .document(_data.eventId)
        //     .collection('imageGallery')
        //     .getDocuments()
        //     .then((value) async {
        //   value.documents.forEach((element) async {
        //     await Firestore.instance
        //         .collection('events')
        //         .document(_data.eventId)
        //         .collection('imageGallery')
        //         .document(element.documentID)
        //         .delete();
        //   });
        // });
      } catch (e) {
        print(e.toString());
      }
    }
    try {
      // await Firestore.instance
      //     .collection('events')
      //     .document(_data.eventId)
      //     .delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<List<AdData>> getAds() {
    Stream<List<AdData>>? dataSnaps;
    // = Firestore.instance
    //     .collection('adsData')
    //     .orderBy('published', descending: true)
    //     .snapshots()
    //     .map((snapshot) =>
    //         snapshot.documents.map((doc) => AdData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Stream<List<AdData>> getAdData() {
    Stream<List<AdData>>? dataSnaps;
    //  = Firestore.instance
    //     .collection('adsData')
    //     .orderBy('published', descending: true)
    //     .snapshots()
    //     .map((snapshot) =>
    //         snapshot.documents.map((doc) => AdData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Stream<List<QueryData>> getQueries() {
    Stream<List<QueryData>>? dataSnaps;
    //  = Firestore.instance
    //     .collection('memberQuery')
    //     .orderBy('msgDate', descending: true)
    //     .snapshots()
    //     .map((snapshot) =>
    //         snapshot.documents.map((doc) => QueryData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Future<bool> sendQueryReply(QueryData query, String reply) async {
    var date = DateTime.now();
    try {
      // await Firestore.instance
      //     .collection('memberQuery')
      //     .document(query.docID)
      //     .updateData({'reply': reply, 'replyDate': date});

      ReplyData _data = ReplyData(
        query: query.query,
        queryDate: query.msgDate,
        reply: reply,
        replyDate: date,
        viewed: false,
      );
      // await Firestore.instance
      //     .collection('memberDatabase')
      //     .document(query.memberID)
      //     .collection('queryReplies')
      //     .document(query.replyID)
      //     .updateData(_data.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendQuery(QueryData data) async {
    try {
      ReplyData _data = ReplyData(
        query: data.query,
        queryDate: data.msgDate,
        reply: '',
        replyDate: '',
      );

      // var response = await Firestore.instance
      //     .collection('memberDatabase')
      //     .document(data.memberID)
      //     .collection('queryReplies')
      //     .add(_data.toMap());

      // data.replyID = response.documentID;
      // await Firestore.instance.collection('memberQuery').add(data.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<List<ReplyData>> getQueryReply(String uId) {
    Stream<List<ReplyData>>? dataSnaps;
    // = Firestore.instance
    //     .collection('memberDatabase')
    //     .document(uId)
    //     .collection('queryReplies')
    //     .orderBy('queryDate', descending: true)
    //     .snapshots()
    //     .map((snapshot) =>
    //         snapshot.documents.map((doc) => ReplyData.fromDoc(doc)).toList());
    return dataSnaps!;
  }

  Stream<List<String>> getEventImages(String docId) {
    Stream<List<String>>? dataSnaps;
    // = Firestore.instance
    //     .collection('events')
    //     .document(docId)
    //     .collection('imageGallery')
    //     .snapshots()
    //     .map((snapshot) => snapshot.documents
    //         .map((doc) => doc.data['imageURL'].toString())
    //         .toList());
    return dataSnaps!;
  }

  Future<bool> changePassword(String email) async {
    try {
      // await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(UserData data) async {
    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: data.email, password: data.password);
      // FirebaseUser _user = await FirebaseAuth.instance.currentUser();

      if (data.userImage != null) {
        String uID = data.id.toString();
        try {
          await _profileImageRef.child(uID + '.png').delete();
        } catch (e) {
          try {
            await _profileImageRef.child(uID + '.PNG').delete();
          } catch (e) {
            try {
              await _profileImageRef.child(uID + '.jpg').delete();
            } catch (e) {
              try {
                await _profileImageRef.child(uID + '.JPG').delete();
              } catch (e) {
                try {
                  await _profileImageRef.child(uID + '.JPEG').delete();
                } catch (e) {
                  try {
                    await _profileImageRef.child(uID + '.jpeg').delete();
                  } catch (e) {
                    print(e);
                  }
                }
              }
            }
          }
        }
      }
      // await Firestore.instance
      //     .collection('memberDatabase')
      //     .document(data.userID)
      //     .delete();
      // _user.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setUpcomingEvent(String eventDesc) async {
    Map<String, dynamic> data = {
      'eventDesc': eventDesc,
    };
    try {
      // await Firestore.instance
      //     .collection('upComingEvent')
      //     .document('broadcast')
      //     .updateData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<String> getUpcomingEvent() {
    Stream<String>? dataSnaps;
    // = Firestore.instance
    //     .collection('upComingEvent')
    //     .document('broadcast')
    //     .snapshots()
    //     .map((snapshot) => snapshot.data['eventDesc'].toString());
    return dataSnaps!;
  }

  Stream<List<MemberData>> getMembers() {
    Stream<List<MemberData>>? dataSnaps;
    // = Firestore.instance
    //     .collection('memberDatabase')
    //     .orderBy('shopName')
    //     .snapshots()
    //     .map((snapShots) => snapShots.documents
    //         .map((doc) => MemberData.fromMap(doc.data, doc.documentID))
    //         .toList());
    return dataSnaps!;
  }

  Stream<List<UserData>> getUsersData() {
    var dataSnaps;
    // = Firestore.instance
    //     .collection('memberDatabase')
    //     .orderBy('shopName')
    //     .snapshots()
    //     .map((snapShots) => snapShots.documents
    //         .map((doc) => userData.fromDoc(doc.data, doc.documentID))
    //         .toList());

    return dataSnaps;
  }

  Future<bool> signOut() async {
    try {
      // SharedPreferences _cache = await SharedPreferences.getInstance();
      // _cache.clear();
      // await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUserContacts() async {
    String contacts = '';

    // var userDocuments =
    //     await Firestore.instance.collection('memberDatabase').getDocuments();

    // int documentLength = userDocuments.documents.length;
    // int count = 0;

    // userDocuments.documents.forEach((element) {
    //   if (element.data['activeStatus'] && !element.data['blacklisted']) {
    //     contacts = contacts + '91' + element.data['contact'];
    //     contacts = contacts + ',';
    //   }
    // });
    contacts = contacts.substring(0, (contacts.length - 1));
    return contacts;
  }

  Future updateMemberData(
      {UserData? oldData,
      UserData? newData,
      bool emailUpdate = false,
      bool passwordUpdate = false,
      bool isNew = false}) async {
    if (isNew) {
      try {
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //     email: newData.email, password: newData.password);
        // FirebaseUser _user = await FirebaseAuth.instance.currentUser();
        // if (newData.userType == 'normal') {
        //   await Firestore.instance
        //       .collection('memberDatabase')
        //       .document(_user.uid)
        //       .setData(newData.toMap());
        // } else if (newData.userType == 'admin') {
        //   await Firestore.instance
        //       .collection('adminUser')
        //       .document(_user.uid)
        //       .setData(newData.toMap());
        // }
        // await FirebaseAuth.instance.signOut();
        return true;
      } catch (e) {
        print('New Member Enrolling\n\n' + e.toString());
        return false;
      }
    } else {
      if (emailUpdate || passwordUpdate) {
        try {
          // await FirebaseAuth.instance.signInWithEmailAndPassword(
          //     email: oldData.email, password: oldData.password);
          // FirebaseUser _user = await FirebaseAuth.instance.currentUser();
          // if (emailUpdate) {
          //   await _user.updateEmail(newData.email);
          // }
          // if (passwordUpdate) {
          //   await _user.updatePassword(newData.password);
          // }
          // await FirebaseAuth.instance.signOut();
        } catch (e) {
          print('Updating email or password\n\n' + e.toString());
          return false;
        }
      }
      try {
        // if (oldData.userType == 'normal' && newData.userType == 'normal') {
        //   await Firestore.instance
        //       .collection('memberDatabase')
        //       .document(oldData.userID)
        //       .updateData(newData.toUpdateMap());
        //   try {
        //     await Firestore.instance
        //         .collection('adminUser')
        //         .document(oldData.userID)
        //         .updateData(newData.toUpdateMap());
        //   } catch (e) {
        //     print('Updating Normal member\n\n' + e.toString());
        //     return true;
        //   }
        // } else if (oldData.userType == 'admin' && newData.userType == 'admin') {
        //   await Firestore.instance
        //       .collection('adminUser')
        //       .document(oldData.userID)
        //       .updateData(newData.toUpdateMap());
        //   try {
        //     var check = await Firestore.instance
        //         .collection('memberDatabase')
        //         .document(oldData.userID)
        //         .get();
        //     if (check != null) {
        //       await Firestore.instance
        //           .collection('memberDatabase')
        //           .document(oldData.userID)
        //           .updateData(newData.toUpdateMap());
        //     }
        //   } catch (e) {
        //     print('Updating Admins\n\n' + e.toString());
        //     return true;
        //   }
        // } else if ((oldData.userType == 'normal' &&
        //     newData.userType == 'admin')) {
        //   newData.userType = 'normal';
        //   await Firestore.instance
        //       .collection('memberDatabase')
        //       .document(oldData.userID)
        //       .updateData(newData.toUpdateMap());
        //   newData.userType = 'admin';
        //   await Firestore.instance
        //       .collection('adminUser')
        //       .document(oldData.userID)
        //       .setData(newData.toMap());
        // }
        return true;
      } catch (e) {
        print('Parent Try\n\n' + e.toString());
        if (e.toString().contains('_FirebaseErrorWrapper')) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  // Functions Defined by me

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
}
