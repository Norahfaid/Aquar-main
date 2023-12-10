import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubit/delete_image/cubit/delete_image_cubit.dart';
import '../cubit/update_annoncement/cubit/update_annoncement_cubit.dart';

class DeleteImageDialoug extends StatefulWidget {
  final int index;
 final int? imageId;
  const DeleteImageDialoug({
    super.key,
    required this.index,
    this.imageId,
  });
  // final Function no;
  // final Function yes;

  @override
  State<DeleteImageDialoug> createState() => _DeleteImageDialougState();
}

class _DeleteImageDialougState extends State<DeleteImageDialoug> {
  bool isLoading = false;
  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightBlackColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor.withOpacity(.5)),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      actions: [
        Column(
          children: [
            const Space(
              height: 30,
            ),
            Text(
              tr("are_you_sure_to_delete_this_image"),
              style: TextStyles.textViewRegular16.copyWith(color: textColor),
            ),
            const Space(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()),
                  )
                : FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () async {
                              toggleIsLoading();
                              await sl<AppNavigator>().pop();
                              toggleIsLoading();
                              //  sl<AppNavigator>().pop();
                            },
                            child: Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: brownColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      tr("no"),
                                      style: TextStyles.textViewMedium18
                                          .copyWith(color: mainColor),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        BlocProvider(
                          create: (context) => sl<DeleteImageCubit>(),
                          child:
                              BlocConsumer<DeleteImageCubit, DeleteImageState>(
                            listener: (context, state) {
                              if (state is DeleteImageErrorState) {
                                showToast(state.message);
                              }
                              if (state is DeleteImageSuccessState) {
                                showToast(tr("image_deleted_successfully"));
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteImageLoadingState) {
                                return const Loading();
                              }
                              return TextButton(
                                  onPressed: () {
                                    final bloc =
                                        context.read<UpdateAnnoncementCubit>();
                                    if (bloc.updateAnnoncementParams
                                        .images![widget.index]
                                        .isRight()) {
                                      context
                                          .read<UpdateAnnoncementCubit>()
                                          .removeImage(widget.index);
                                      context
                                          .read<DeleteImageCubit>()
                                          .fDeleteImage(
                                              imageId: widget.imageId!);
                                      sl<AppNavigator>().pop();
                                    } else {
                                      context
                                          .read<UpdateAnnoncementCubit>()
                                          .removeImage(widget.index);
                                      showToast(
                                          tr("image_deleted_successfully"));
                                      sl<AppNavigator>().pop();
                                    }
                                  },
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          tr("yes"),
                                          style: TextStyles.textViewMedium18
                                              .copyWith(color: white),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            const Space(
              height: 20,
            )
          ],
        )
        // The "Yes" button
      ],
    );
  }
}
