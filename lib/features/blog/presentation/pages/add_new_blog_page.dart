import 'dart:developer';
import 'dart:io';

import 'package:bloggy/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggy/core/common/widgets/loader.dart';
import 'package:bloggy/core/constants/constants.dart';
import 'package:bloggy/core/theme/app_pallete.dart';
import 'package:bloggy/core/utils/pick_image.dart';
import 'package:bloggy/core/utils/show_snackbar.dart';
import 'package:bloggy/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:bloggy/features/blog/presentation/pages/blog_page.dart';
import 'package:bloggy/features/blog/presentation/widgets/blog_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => AddNewBlogPage());
  }

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? selectedImage;
  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() && selectedImage != null && selectedTopics.isNotEmpty) {
      final posterId = (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      log((context.read<AppUserCubit>().state as AppUserLoggedIn).user.id);

      context.read<BlogBloc>().add(BlogUpload(
            image: selectedImage!,
            title: titleController.text.trim(),
            content: contentController.text.trim(),
            topics: selectedTopics,
            posterId: posterId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.done_rounded),
            onPressed: () => uploadBlog(),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    selectedImage != null
                        ? GestureDetector(
                            onTap: () => selectImage(),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => selectImage(),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder, size: 40),
                                  Text(
                                    'Select Your Image',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: Constants.categories
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }

                                    setState(() {});
                                  },
                                  child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppPallete.gradient1,
                                            )
                                          : null,
                                      side: selectedTopics.contains(e)
                                          ? null
                                          : BorderSide(
                                              color: AppPallete.borderColor,
                                            )),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Title',
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog Content',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
