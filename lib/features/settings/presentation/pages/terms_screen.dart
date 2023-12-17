import 'package:aquar/features/settings/presentation/cubit/terms/terms_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/widgets/default_app_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: tr("terms_and_conditions"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
          leadingIcon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 30,
          )
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Divider(
                color: greyColor,
                height: 1,
              ),
              const Space(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: BlocConsumer<TermsCubit, TermsState>(
                  listener: (context, state) {
                    if (state is TermsErrorState) {
                      showToast(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is TermsSuccessState) {
                      return state.response.data.content == null
                          ? const Center(child: Text("there_are_no_data"))
                          : Column(children: [
                              const Space(height: 20),
                              Html(
                                data: state.response.data.content,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(16.0),
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                },
                              ),
                            ]);
                    }
                    return const Loading();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
