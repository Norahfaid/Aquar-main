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
import '../cubit/terms_annonce/cubit/terms_annonce_cubit.dart';
import '../cubit/terms_annonce/cubit/terms_annonce_state.dart';

class TermsAdvScreen extends StatelessWidget {
  const TermsAdvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: DefaultAppBar(
          title: tr("terms"),
          ontapLeading: () {
            sl<AppNavigator>().pop();
          },
          // leadingIcon: const Icon(
          //   Icons.keyboard_arrow_right,
          //   size: 30,
          // )
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
                child: BlocConsumer<TermsAnnonceCubit, TermsAnnonceState>(
                  listener: (context, state) {
                    if (state is TermsAnnonceErrorState) {
                      showToast(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is TermsAnnonceSuccessState) {
                      return state.response.data.content == null
                          ? Center(child: Text(tr("there_are_no_data")))
                          : Column(children: [
                              const Space(height: 20),
                              Html(
                                data: state.response.data.content,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(16.0),
                                    color: brownColor,
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
