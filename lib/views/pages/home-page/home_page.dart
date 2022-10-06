import 'package:blog_admin/models/blog_model.dart';
import 'package:blog_admin/providers/auth_provider.dart';
import 'package:blog_admin/providers/blog_provider.dart';
import 'package:blog_admin/utils/toast.dart';
import 'package:blog_admin/views/pages/add-blog-page/add_blog_page.dart';
import 'package:blog_admin/views/pages/launcher_page.dart';
import 'package:blog_admin/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<BlogProvider>().getBlogList();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog List'),
        actions: [
          IconButton(
            onPressed: () {
              showLoadingDialog(context);
              context.read<BlogProvider>().getBlogList().then((value) {
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: "Logout",
          ),
          IconButton(
            onPressed: () {
              showLoadingDialog(context);
              context.read<AuthProvider>().logout().then(
                (value) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName);
                },
              ).onError((error, stackTrace) {
                showToast(context, 'Logout Failed');
              });
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddBlogPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Consumer<BlogProvider>(
          builder: (context, blogProvider, child) {
            List<BlogModel> blogs = blogProvider.blogs;
            return blogs.isEmpty
                ? const Text('No Blogs')
                : ListView.builder(
                    itemCount: blogs.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: (){},

                      title: Text(blogs[index].title!),
                      subtitle: Text(blogs[index].subTitle!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AddBlogPage.routeName, arguments: blogs[index]);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showLoadingDialog(context);
                              context.read<BlogProvider>().deleteBlog(blogs[index].id!).then((value) {
                                if (value){
                                  showToast(context, 'Blog Deleted');
                                }
                                else{
                                  showToast(context, 'Failed To Deleted Blog');
                                }
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
