import 'package:blog_admin/models/blog_model.dart';
import 'package:blog_admin/providers/blog_provider.dart';
import 'package:blog_admin/utils/helper_functions.dart';
import 'package:blog_admin/utils/toast.dart';
import 'package:blog_admin/views/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/date_picker.dart';
import '../../widgets/loading_widget.dart';

class AddBlogPage extends StatelessWidget {
  static const routeName = '/add_blog';

  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final slugController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final categoryIdController = TextEditingController();

  BlogModel? blog;

  final globalKey = GlobalKey<FormState>();

  AddBlogPage({Key? key}) : super(key: key);

  void setText(BuildContext context) {
    titleController.text = blog!.title!;
    subTitleController.text = blog!.subTitle!;
    slugController.text = blog!.slug!;
    descriptionTextController.text = blog!.description!;
    categoryIdController.text = blog!.categoryId!;
    context.read<BlogProvider>().selectedDate = DateTime.tryParse(blog!.date!);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      blog = ModalRoute.of(context)!.settings.arguments as BlogModel;
      setText(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(blog == null ? 'Add Blog' : 'Update Blog'),
        actions: [
          TextButton(
            onPressed: () {
              onPressed(context) ;
            },
            child: Text(
              blog == null ? 'Save' : 'Update',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomFormField(
              controller: categoryIdController,
              isPrefIcon: false,
              labelText: 'Category Id',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: titleController,
              isPrefIcon: false,
              labelText: 'Title',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: subTitleController,
              isPrefIcon: false,
              labelText: 'Sub Title',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: slugController,
              isPrefIcon: false,
              labelText: 'Slug',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: descriptionTextController,
              isPrefIcon: false,
              maxLine: 3,
              labelText: 'Description',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      datePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        onSelect: (dateTime) {
                          context.read<BlogProvider>().setDate(dateTime);
                        },
                      );
                    },
                    child: const Text(
                      'Select Date',
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<BlogProvider>(
                    builder: (context, blogProvider, child) => Text(
                      blogProvider.selectedDate == null
                          ? 'No date selected'
                          : getFormattedDateTime(
                              dateTime: blogProvider.selectedDate!),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void reset(BuildContext context) {
    titleController.clear();
    subTitleController.clear();
    slugController.clear();
    descriptionTextController.clear();
    categoryIdController.clear();
    context.read<BlogProvider>().reset();
  }

  void onPressed(BuildContext context) async {
    final blogProvider = context.read<BlogProvider>();

    if (globalKey.currentState!.validate()) {
      showLoadingDialog(context);

      try {
        BlogModel blogModel = BlogModel(
          title: titleController.text.trim(),
          subTitle: subTitleController.text.trim(),
          slug: slugController.text.trim(),
          description: descriptionTextController.text.trim(),
          categoryId: categoryIdController.text.trim(),
          date: getFormattedDateTime(
              dateTime: context.read<BlogProvider>().selectedDate!,
              pattern: 'yyyy-MM-dd'),
        );
        bool isSuccess = blog == null
            ? await blogProvider.storeBlog(blogModel)
            : await blogProvider.updateBlog(blog!.id!, blogModel);

        if (!isSuccess) {
          return;
        }
        // ignore: use_build_context_synchronously
        showToast(context, 'Success');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        reset(context);
      } catch (error) {
        showToast(context, 'Failed');
        context.read<BlogProvider>().reset();
        print('error saving blog: $error');
      } finally {
        Navigator.pop(context);
      }
    } else {
      showToast(context, 'Field must not be empty');
    }
  }
}
