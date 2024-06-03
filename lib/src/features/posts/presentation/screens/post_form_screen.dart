import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openstack/src/constants/enums.dart';
import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:openstack/src/features/posts/presentation/controllers/post_form_controller.dart';
import 'package:openstack/src/features/posts/presentation/controllers/post_form_screen_controller.dart';
import 'package:openstack/src/features/posts/presentation/providers/post_providers.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_button_decorated.dart';
import 'package:openstack/src/shared/widgets/outline_reactive_text_field.dart';
import 'package:openstack/src/shared/widgets/outline_reactive_text_field_multiline.dart';
import 'package:openstack/src/theme/app_icons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PostFormScreen extends HookConsumerWidget {
  const PostFormScreen({
    super.key,
    this.post,
  });

  final PostEntity? post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formController = ref.watch(postFormControllerProvider(post: post));
    final formNotifier =
        ref.watch(postFormControllerProvider(post: post).notifier);
    return Scaffold(
      body: GestureDetector(
        onTap: () => formNotifier.unfocus(),
        child: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                _AppBarView(post),
                const Gap(20),
                Text(
                  post != null ? 'Edit Post' : 'New Post',
                  style: context.textTheme.heading3Bold,
                ),
                const Gap(20),
                ReactiveForm(
                  formGroup: formController.formGroup,
                  child: Column(
                    children: [
                      OutlineReactiveTextField(
                        hintText: 'Post Title',
                        prefixIcon: const Icon(AppIcons.smallcaps_outline),
                        formControlName: PostFormControl.title.key,
                      ),
                      const Gap(20),
                      OutlineReactiveTextFieldMultiline(
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 150,
                        keyboardType: TextInputType.multiline,
                        hintText: 'Post Description',
                        prefixIcon: const Icon(AppIcons.edit_2_outline),
                        formControlName: PostFormControl.summary.key,
                      ),
                      const Gap(20),
                      OutlineReactiveTextField(
                        hintText: 'Post Source URL',
                        prefixIcon: const Icon(AppIcons.link_2_outline),
                        formControlName: PostFormControl.sourceUrl.key,
                      ),
                      const Gap(20),
                      _PopUpMenuView(post),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarView extends ConsumerWidget {
  const _AppBarView(this.post);

  final PostEntity? post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenController = ref.watch(postFormScreenControllerProvider);
    final screenNotifier = ref.watch(postFormScreenControllerProvider.notifier);
    final formController = ref.watch(postFormControllerProvider(post: post));
    return Row(
      children: [
        FilledButtonDecorated(
          title: 'Cancel',
          color: Colors.transparent,
          style:
              context.textTheme.body1Bold.tsColor(context.colors.brandBlueDeep),
          onPressed: () => screenNotifier.cancel(),
        ),
        const Spacer(),
        if (formController.isValid && formController.isDirty)
          FilledButtonDecorated(
            title: 'Post',
            height: 40,
            loadingIconSize: 15,
            isLoading: screenController.isLoading,
            color: context.colors.brandBlack,
            onPressed: () {
              if (screenController.isLoading) return null;
              if (post == null) {
                screenNotifier.createPost(post);
              } else {
                screenNotifier.updatePost(post!);
              }
            },
          ),
      ],
    );
  }
}

class _PopUpMenuView extends HookConsumerWidget {
  const _PopUpMenuView(
    this.post,
  );

  final PostEntity? post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageFileHook = useState<File?>(null);
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(25),
      color: Colors.transparent,
      child: PopupMenuButton(
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        color: context.colors.greyGrey200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.zero,
        offset: const Offset(0, 200),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<ImageSource>(
              value: ImageSource.gallery,
              height: 30,
              child: _Item(
                title: 'Photo Library',
                icon: AppIcons.gallery_outline,
              ),
            ),
            const PopupMenuItem<ImageSource>(
              value: ImageSource.files,
              height: 30,
              child: _Item(
                title: 'Choose File',
                icon: AppIcons.folder_open_outline,
              ),
            ),
          ];
        },
        onSelected: (source) async {
          final pickedImageFile = await ref
              .read(postFormControllerProvider(post: post).notifier)
              .pickImage(source);
          imageFileHook.value = pickedImageFile;
        },
        child: _ThumbnailView(
          imageFileHook.value,
          post,
        ),
      ),
    );
  }
}

class _ThumbnailView extends ConsumerWidget {
  const _ThumbnailView(
    this.pickedImageFile,
    this.post,
  );

  final File? pickedImageFile;
  final PostEntity? post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnailUrl = (post?.thumbnailId == null)
        ? null
        : ref.watch(FetchPostFileUrlProvider(post!.thumbnailId!)).valueOrNull;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: pickedImageFile != null
            ? DecorationImage(
                image: FileImage(pickedImageFile!),
                fit: BoxFit.cover,
              )
            : thumbnailUrl != null
                ? DecorationImage(
                    image: NetworkImage(thumbnailUrl),
                    fit: BoxFit.cover,
                  )
                : null,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: context.colors.greyGrey200,
          width: 2,
        ),
      ),
      child: pickedImageFile == null && thumbnailUrl == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  AppIcons.gallery_outline,
                  size: 18,
                ),
                const Gap(5),
                Text(
                  'Upload Image',
                  style: context.textTheme.body1Bold,
                ),
              ],
            )
          : null,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Icon(
          icon,
          size: 20,
        ),
      ],
    );
  }
}
