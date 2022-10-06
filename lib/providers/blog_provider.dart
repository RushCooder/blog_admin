import 'package:blog_admin/apis/blog_api.dart';
import 'package:blog_admin/models/blog_model.dart';
import 'package:flutter/material.dart';

class BlogProvider extends ChangeNotifier{
  List<BlogModel> blogs = [];
  DateTime? selectedDate;
  void reset(){
    selectedDate = null;
    notifyListeners();
  }
  void setDate(DateTime? dateTime) {
    print('date selected provider: $dateTime');
    selectedDate = dateTime;
    print('date: $selectedDate');
    notifyListeners();
  }


  //======================== api call ====================
  // create/store blog
  Future<bool> storeBlog(BlogModel blogModel) async {
    bool isStored = await BlogApi.storeBlog(blogModel);
    getBlogList();
    return isStored;
  }
  // get all blog
  Future<void> getBlogList() async {
    blogs = await BlogApi.getBlogList();
    notifyListeners();
  }
  // delete blog
  Future<bool> deleteBlog(num id) async {
    bool isDeleted = await BlogApi.deleteBlog(id);
    getBlogList();
    return isDeleted;
  }
  // update blog
  Future<bool> updateBlog(num id, BlogModel blogModel) async {
    bool isUpdated = await BlogApi.updateBlog(id, blogModel);
    getBlogList();
    return isUpdated;
  }


}