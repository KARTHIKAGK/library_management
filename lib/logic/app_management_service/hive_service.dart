import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:library_management/data/data_model/book_model.dart';
import 'package:library_management/data/data_model/user_model.dart';

import '../../data/data_model/member_model.dart';




class HiveService{
  Box<UserModel>? userBox;
  Box<MemberModel>? memberBox;
  Box<BookModel>? bookBox;
  // Box<StyleModel>? styleBox;
  // Box<FabricModel>? fabricBox;
  //Box<TrashModel>? trashBox;
  


  init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(MemberModelAdapter());
    // Hive.registerAdapter(MeasurementProfileModelAdapter());
    // Hive.registerAdapter(TrashModelAdapter()); 
    Hive.registerAdapter(BookModelAdapter());
    // Hive.registerAdapter(StyleModelAdapter());
    // Hive.registerAdapter(FabricModelAdapter());
    userBox=await Hive.openBox<UserModel>("userBox");
    memberBox=await Hive.openBox<MemberModel>("memberBox");
    bookBox=await Hive.openBox<BookModel>("bookBox");
    // styleBox=await Hive.openBox<StyleModel>("styleBox");
    // fabricBox=await Hive.openBox<FabricModel>("fabricBox");
   // trashBox=await Hive.openBox<TrashModel>("trashBox");
    //print("trashbox");
}
   
  clearAllBox()
  {
    userBox?.clear();
    memberBox?.clear();
    bookBox?.clear();
    // styleBox?.clear();
    // fabricBox?.clear();
     //trashBox?.clear();
  }
}
