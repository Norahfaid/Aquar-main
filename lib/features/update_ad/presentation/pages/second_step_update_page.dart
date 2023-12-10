import 'dart:io';

import 'package:aquar/core/constant/dimenssions/screenutil.dart';
import 'package:aquar/core/widgets/space.dart';
import 'package:aquar/features/annoncements/presentation/widgets/dotted_border_widget.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/domain/models/filter.dart';
import '../../../home/presentation/cubit/update_annoncement/cubit/update_annoncement_cubit.dart';
import '../../../home/presentation/pages/video_screen.dart';
import '../../../home/presentation/widgets/delete_image_dialog.dart';
import '../../../settings/presentation/pages/modification_data_screen.dart';

class SecondStepUpdatePage extends StatefulWidget {
  final AnnounceData data;
  const SecondStepUpdatePage({super.key, required this.data});

  @override
  State<SecondStepUpdatePage> createState() => _SecondStepUpdatePageState();
}

class _SecondStepUpdatePageState extends State<SecondStepUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateAnnoncementCubit>();

    List<dartz.Either<File, ImageFilter>?> imageFileList =
        context.watch<UpdateAnnoncementCubit>().imageFileList;
    return Form(
      key: bloc.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr("featured_image_of_he_property"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),
          // DottedBorderWidget(title: tr("add_pic")),
          BlocBuilder<UpdateAnnoncementCubit, UpdateAnnoncementState>(
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          // color: Colors.grey.shade300,
                          height: 250,
                          padding: const EdgeInsets.all(20),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            // clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 50,
                                height: 6,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(children: [
                                SelectPhoto(
                                  onTap: () {
                                    bloc.getImage(
                                      context,
                                      ImageSource.gallery,
                                    );
                                    Navigator.pop(context);
                                  },
                                  icon: Icons.image,
                                  textLabel: tr('Browse_Gallery'),
                                ),
                                const SizedBox(height: 20),
                                SelectPhoto(
                                  onTap: () {
                                    bloc.getImage(context, ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  icon: Icons.camera_alt_outlined,
                                  textLabel: tr('camera'),
                                ),
                              ])
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DottedBorderWidget(title: tr("add_image")),
                      bloc.updateAnnoncementParams.icon == null
                          ? Container()
                          : bloc.updateAnnoncementParams.icon!.isLeft()
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Image.file(
                                    bloc.updateAnnoncementParams.icon!
                                        .swap()
                                        .getOrElse(() => File("")),
                                    height: 115,
                                    fit: BoxFit.fill,
                                    width: screenWidth,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Image.network(
                                    bloc.updateAnnoncementParams.icon!
                                        .getOrElse(() => ""),
                                    height: 115,
                                    fit: BoxFit.fill,
                                    width: screenWidth,
                                  ),
                                )
                      // )
                    ],
                  ));
            },
          ),
          const Space(height: 20),
          Text(
            tr("pictures_of_the_property"),
            style: TextStyles.textViewBold15.copyWith(color: textColor),
          ),
          const Space(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () async {
                context.read<UpdateAnnoncementCubit>().selectImages();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: mainColor),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: mainColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tr("upload_image"),
                    style: TextStyles.textViewBold16.copyWith(color: mainColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (imageFileList.isNotEmpty)
            SizedBox(
              width: screenWidth,
              // height: 200,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: imageFileList.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 2.4),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: bloc.updateAnnoncementParams.images![index]
                                  .isLeft()
                              ? Image.file(
                                  imageFileList[index]!
                                      .swap()
                                      .getOrElse(() => File("")),
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: 120,
                                )
                              : Image.network(
                                  imageFileList[index]!
                                      .getOrElse(() => ImageFilter(
                                          url: "",
                                          delete: DeleteImageFilter(
                                              href: '', method: DeleteImageMethod.delete),
                                          id: 1))
                                      .url,
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: 120,
                                ),
                        ),
                      ),
                      Positioned(
                        left: -5,
                        // top: -10,
                        child: IconButton(
                          onPressed: () {
                            // log("${widget.data.images[index].id}indexxxxxxxxxxxxx");
                            // log("indexxxxxxxxxxxxx");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return bloc.updateAnnoncementParams
                                          .images![index]
                                          .isRight()
                                      ? DeleteImageDialoug(
                                          imageId:
                                              widget.data.aqarImages[index].id,
                                          index: index,
                                        )
                                      : DeleteImageDialoug(
                                          index: index,
                                        );
                                });
                          },
                          icon: const Icon(
                            Icons.highlight_remove_outlined,
                            size: 35,
                            color: redColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          const Space(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("video_of_the_property"),
                style: TextStyles.textViewBold15.copyWith(color: textColor),
              ),
              if (!bloc.ifNoVideo())
                InkWell(
                  onTap: () {
                    sl<AppNavigator>().push(
                        screen: AdsEquipmentsScreen(
                      videoUrl: bloc.updateAnnoncementParams.video!
                          .getOrElse(() => ""),
                    ));
                  },
                  child: const Icon(
                    Icons.video_camera_back,
                    color: mainColor,
                    size: 30,
                  ),
                ),
            ],
          ),
          const Space(
            height: 10,
          ),
          BlocBuilder<UpdateAnnoncementCubit, UpdateAnnoncementState>(
            builder: (context, state) {
              return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          // color: Colors.grey.shade300,
                          height: 250,
                          padding: const EdgeInsets.all(20),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            // clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 50,
                                height: 6,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(children: [
                                SelectPhoto(
                                  onTap: () {
                                    bloc.getVideo(
                                      context,
                                      ImageSource.gallery,
                                    );
                                    Navigator.pop(context);
                                  },
                                  icon: Icons.video_call_outlined,
                                  textLabel: tr('Browse_Gallery'),
                                ),
                                // const SizedBox(
                                //     height: 20),
                                // SelectPhoto(
                                //   onTap: () {
                                //     bloc.getImage(
                                //         context,
                                //         ImageSource
                                //             .camera);
                                //     Navigator.pop(
                                //         context);
                                //   },
                                //   icon: Icons
                                //       .camera_alt_outlined,
                                //   textLabel:
                                //   tr('camera'),
                                // ),
                              ])
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DottedBorderWidget(
                          title: bloc.ifNoVideo()
                              ? tr("add_video")
                              : tr("video_uploaded_successfully"),
                          icon: bloc.ifNoVideo()
                              ? Icons.cloud_upload_outlined
                              : Icons.done_all),

                      // bloc.addAnnoncementParams.video==null?Container(
                      // ):
                      // // DottedBorderFilledWidget(widget:
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.all(Radius.circular(12)),
                      //   child: VideoPlayer.file(bloc.addAnnoncementParams.video!,
                      //
                      //     height: 115,fit:BoxFit.fill,
                      //     width: screenWidth,),
                      // )
                      // )
                    ],
                  ));
            },
          ),
          // DottedBorderWidget(title: tr("add_video")),

          const Space(height: 20),
          Container(
            width: screenWidth,
            height: .5,
            color: greyColor,
          ),
          // FittedBox(
          //   child: Row(
          //     children: [
          //       Container(
          //         width: screenWidth / 2,
          //         height: .5,
          //         color: greyColor,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: Text(
          //           tr("or"),
          //           style: TextStyles.textViewBold15.copyWith(color: white),
          //         ),
          //       ),
          //       Container(
          //         width: screenWidth / 2,
          //         height: .5,
          //         color: greyColor,
          //       ),
          //     ],
          //   ),
          // ),
          const Space(height: 10),
          MasterTextField(
            hintText: tr("youtube_link"),
            fieldWidth: screenWidth,
            controller: bloc.videoLinkController,
            keyboardType: TextInputType.text,
            width: screenWidth,
            fillColor: lightBlackColor,
            filled: true,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onChanged: (String value) {},
          ),
          // const Space(boxHeight: 10),
        ],
      ),
    );
  }
}
