import 'package:aquar/features/settings/presentation/cubit/terms/terms_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/app_navigator.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/drop_down.dart';
import '../../../../core/widgets/gradiant_button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/master_textfield.dart';
import '../../../../core/widgets/password_text_feild.dart';
import '../../../../core/widgets/space.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../settings/presentation/pages/terms_screen.dart';
import '../../domain/models/cities_entity.dart';
import '../../domain/models/regines_entity.dart';
import '../../domain/models/user_types.dart';
import '../cubit/get_cities_cubit/cubit/get_cities_cubit.dart';
import '../cubit/get_regions/cubit/get_regions_cubit.dart';
import '../cubit/get_user_type/cubit/get_user_type_cubit.dart';
import '../cubit/register/cubit/register_cubit.dart';
import '../cubit/submit_register/cubit/submit_register_cubit.dart';
import '../pages/verify_register_screen.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController advertiserPhoneController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // final TextEditingController nationalIdTextController = TextEditingController();
  bool agree = false;
  UserType? userType;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      context.read<GetCitiesCubit>().clear();
      context.read<GetRegionsCubit>().clear();
      context.read<GetUserTypeCubit>().params.userType = null;
      context.read<GetUserTypeCubit>().fGetUserType(context: context);
      context.read<GetCitiesCubit>().fGetCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userTypeBloc = context.read<GetUserTypeCubit>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space(
            height: 10,
          ),

          //region:: Name TextField
          Text(
            e.tr("name"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          MasterTextField(
            hintText: e.tr("enter_your_name"),
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.name,
            controller: nameController,
            validate: (value) => Validator.defaultValidator(value),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            onChanged: (String value) {},
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: Phone Number TextField
          Text(
            e.tr("phone_number"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          MasterTextField(
            hintText: e.tr("enter_phone_number"),
            textDirection: TextDirection.ltr,
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validate: (value) => Validator.phone(value),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            onChanged: (String value) {},
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: National ID TextField
          // Text(
          //   e.tr("national_id"),
          //   style: TextStyles.textViewMedium18.copyWith(color: white,),
          // ),
          // const Space(height: 10,),
          // MasterTextField(
          //   hintText: e.tr("enter_national_id"),
          //   textDirection: TextDirection.ltr,
          //   controller: nationalIdTextController,
          //   keyboardType: TextInputType.text,
          //   validate: (value) => Validator.defaultValidator(value),
          //   onEditingComplete: () => FocusScope.of(context).nextFocus(),
          //   onChanged: (String value) {},
          // ),
          // const Space(height: 20,),
          //endregion

          //region:: City TextField
          Text(
            e.tr("city"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          BlocBuilder<GetCitiesCubit, GetCitiesState>(
            builder: (context, state) {
              if (state is GetCitiesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final blocCity = context.read<GetCitiesCubit>();
              return MainDropDown<CitiesList>(
                filled: false,
                hint: e.tr("city"),
                value: blocCity.selectCity,
                onChange: (value) {
                  context.read<GetRegionsCubit>().clear();
                  blocCity.chooseCity(value, context);
                },
                items: blocCity.citiesList.map((CitiesList value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.name,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const Space(
            height: 10,
          ),
          //endregion

          //region:: Neighborhood TextField
          Text(
            e.tr("neighborhood"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          BlocBuilder<GetRegionsCubit, GetRegionsState>(
            builder: (context, state) {
              final blocCity = context.read<GetRegionsCubit>();
              if (state is GetRegionsError) {
                return Text(
                  e.tr("there_are_no_regions"),
                  style: TextStyles.textViewMedium16.copyWith(
                    color: redColor,
                  ),
                );
              }
              return MainDropDown<Regions>(
                filled: false,
                hint: e.tr("region"),
                value: blocCity.selectCategory,
                onChange: (value) =>
                    blocCity.chooseSubCategory(context: context, model: value),
                items: blocCity.subCategories.map((Regions value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.name,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: Membership Type TextField
          Text(
            e.tr("membership_type"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          BlocBuilder<GetUserTypeCubit, GetUserTypeState>(
            builder: (context, state) {
              if (state is GetUserTypeErrorState) {
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              }
              return Wrap(
                children: List.generate(
                  userTypeBloc.userTypeList.length,
                  (index) {
                    return Row(
                      children: [
                        Radio<UserType>(
                          activeColor: mainColor,
                          focusColor: textColor,
                          hoverColor: textColor,
                          value: userTypeBloc.userTypeList[index],
                          groupValue: userTypeBloc.params.userType,
                          onChanged: (value) {
                            if (value != null) {
                              userTypeBloc.chooseUserType(value);
                              userType = value;
                              setState(() =>
                                  userTypeBloc.userLicence = userType?.kind);

                              ///BUT VALUE IN REGISTER PARAMS HERE//////
                              BlocProvider.of<RegisterCubit>(context)
                                  .registerParams
                                  .userTypeId = value.toString();
                              licenseNumberController.clear();
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                        Text(
                          userTypeBloc.userTypeList[index].name,
                          style: TextStyles.textViewMedium18.copyWith(
                            color: mainColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          //endregion

          //region:: User Licence Section
          Builder(
            builder: (context) {
              if (userTypeBloc.userLicence == "advertiser") {
                return Column(
                  children: [
                    const Space(
                      height: 10,
                    ),
                    Text(
                      e.tr("advertiser_no"),
                      style: TextStyles.textViewMedium18.copyWith(
                        color: white,
                      ),
                    ),
                    const Space(
                      height: 10,
                    ),
                    MasterTextField(
                      hintText: e.tr("enter_advertiser_no"),
                      textDirection: TextDirection.ltr,
                      validate: (value) => Validator.numbersLiecence(value),
                      controller: licenseNumberController,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      onChanged: (String value) {},
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: Password TextField
          Text(
            e.tr("password"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          PasswordMasterTextField(
            hintText: e.tr("enter_password"),
            isPassword: true,
            onChanged: (String value) {},
            controller: passwordController,
            validationFunction: (value) => Validator.password(value),
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: Confirm Password TextField
          Text(
            e.tr("confirm_password"),
            style: TextStyles.textViewMedium18.copyWith(
              color: white,
            ),
          ),
          const Space(
            height: 10,
          ),
          PasswordMasterTextField(
            hintText: e.tr("enter_password"),
            isPassword: true,
            controller: confirmPasswordController,
            onChanged: (String value) {},
            validationFunction: (value) =>
                Validator.confirmPassword(value, passwordController.text),
          ),
          const Space(
            height: 10,
          ),
          //endregion

          //region:: Terms Agree Section
          Row(
            children: [
              Checkbox(
                activeColor: mainColor,
                value: agree,
                side: const BorderSide(
                  color: mainColor,
                  width: 2,
                ),
                onChanged: (val) => setState(() => agree = !agree),
              ),
              InkWell(
                onTap: () {
                  context.read<TermsCubit>().fGetTerms();
                  sl<AppNavigator>()
                      .push(screen: const TermsAndConditionsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 7,
                  ),
                  child: Text(
                    e.tr("terms_agree"),
                    style: TextStyles.textViewUnderlineRegular15.copyWith(
                      color: mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Space(
            height: 10,
          ),
          const Space(
            height: 25,
          ),
          //endregion

          //region:: Button Register
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterErrorState) {
                showToast(state.message);
              }
              if (state is RegisterSuccessState) {
                context
                    .read<SubmitRegisterCubit>()
                    .updateCode(state.response.data.code);
                sl<AppNavigator>().push(
                    screen: VerifyRegisterScreen(
                  phone: state.response.data.phone,
                ));
              }
            },
            builder: (context, state) {
              if (state is RegisterLoodingState) {
                return const Loading();
              }
              return Center(
                child: GradiantButton(
                  title: e.tr("register"),
                  tap: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (context.read<GetCitiesCubit>().selectCity?.id == null) {
                      showToast(e.tr("select_city"));
                      return;
                    }
                    if (context.read<GetRegionsCubit>().selectCategory?.id ==
                        null) {
                      showToast(e.tr("select_region"));
                      return;
                    }
                    if (userType == null) {
                      showToast(e.tr("select_user_type"));
                      return;
                    }
                    if (agree == false) {
                      showToast(e.tr("terms_required"));
                      return;
                    }
                    context.read<RegisterCubit>().fRegister(
                          formKey: formKey,
                          name: nameController.text,
                          userTypeId: userType!.id.toString(),
                          licenseNumber: licenseNumberController.text,
                          phone: phoneController.text,
                          cityId: context.read<GetCitiesCubit>().selectCity!.id,
                          regionId: context
                              .read<GetRegionsCubit>()
                              .selectCategory!
                              .id,
                          password: passwordController.text,
                          passwordConfirm: confirmPasswordController.text,
                          // nationalId: nationalIdTextController.text,
                        );
                  },
                ),
              );
            },
          ),
          const Space(
            height: 20,
          ),
          //endregion

          //region:: You have an account Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.tr("you_have_an_account"),
                style: TextStyles.textViewRegular15.copyWith(
                  color: white,
                ),
              ),
              TextButton(
                onPressed: () {
                  sl<AppNavigator>().pop();
                },
                child: Text(
                  " ${e.tr("login")}",
                  style: TextStyles.textViewBold15.copyWith(
                    color: mainColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const Space(
            height: 5,
          ),
          //endregion
        ],
      ),
    );
  }
}
