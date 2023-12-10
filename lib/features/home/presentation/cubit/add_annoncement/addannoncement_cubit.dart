import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../domain/models/add_annoncement_response.dart';
import '../../../domain/usecase/add_annonce.dart';

part 'addannoncement_state.dart';

class AddAnnouncementCubit extends Cubit<AddannoncementState> {
  AddAnnouncementCubit(this.usecase) : super(AddannoncementInitial());
  final AddAnnoncementUsecase usecase;

  AnnonceData? _data;

  AnnonceData get data {
    return _data!;
  }

  File? _avatar;
  File? get avatar => _avatar;
  set setAvatar(File img) {
    _avatar = img;
    emit(UploadImage());
    emit(AddannoncementInitial());
  }

  // bool networkSelected = false;
  // int selectedNetworkId = -1;
  // List<int> selectedNetworkIdList = [];
  // void addSelectedNetworkIdList({required int id}) {
  //   selectedNetworkIdList.add(id);
  //   emit(SelectNetWorkId());
  //   emit(AddannoncementInitial());
  // }

  List<int> selectedIds = [];
  void addSelectedNetworkIdList(int id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
      emit(RemoveId());
      emit(AddannoncementInitial());
    } else {
      selectedIds.add(id);

      emit(AddId());
      emit(AddannoncementInitial());
    }
  }

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  bool isCelected = false;
  bool isCelected1 = false;
  bool isCelected2 = false;
  bool isCelected3 = false;
  bool isCelected4 = false;
  bool isCelected5 = false;
  bool isCelected6 = false;
  bool isCelected7 = false;
  bool isCelected8 = false;
  bool isCelected9 = false;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool monsters = false;
  bool value4 = false;

  bool tapped1 = false;
  bool tapped2 = true;
  bool tapped3 = false;
  String purpose = '';
  // String interface = '';

  // bool isFromDashboardSelected = false;

  String netWorkType = '-1';
  String userType = '-1';
  LatLng? latLng;
  AddAnnoncementParams addAnnoncementParams = AddAnnoncementParams();
  TextEditingController addressController = TextEditingController();
  TextEditingController interFaceController = TextEditingController();
  // TextEditingController addressControllerText = TextEditingController();
  TextEditingController lowPriceController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController highPriceController = TextEditingController();
  TextEditingController lowDistanceController = TextEditingController();
  TextEditingController apartmentCountController = TextEditingController();
  TextEditingController highDistanceController = TextEditingController();
  TextEditingController storesController = TextEditingController();
  TextEditingController streetWidthController = TextEditingController();
  TextEditingController decsController = TextEditingController();
  TextEditingController authNumberController = TextEditingController();
  TextEditingController roomsCountController = TextEditingController();
  TextEditingController bathRoomsCountController = TextEditingController();
  TextEditingController bedRoomsController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<File> imageFileList = [];
  Future<void> fAddAnnoncement({
    required GlobalKey<FormState> formKey1,
    required GlobalKey<FormState> formKey2,
    required GlobalKey<FormState> formKey3,
    required AdvType advType,
    // required List<File> images,
  }) async {
    {
      if (latLng == null) {
        showToast(tr("please_pick_state_location"));
        return;
      }
      if (!formKey1.currentState!.validate() ||
          !formKey2.currentState!.validate() ||
          !formKey3.currentState!.validate()) {
        return;
      } else {
        emit(AddAnnoncementLoadingState());
        final failOrUser = await usecase(AddAnnoncementParams(
          advType: advType,
          age: ageController.text,
          phone: phoneController.text,
          icon: addAnnoncementParams.icon,
          image2: addAnnoncementParams.image2,
          image3: addAnnoncementParams.image3,
          video: addAnnoncementParams.video,
          additionalRoomsCount: additionalController.text,
          address: addressController.text,
          descrption: decsController.text,
          images: imageFileList,
          driverRoom: isCelected ? "1" : "0",
          duplex: value1 ? "1" : "0",
          elevator: isCelected5 ? "1" : "0",
          externalStaircase: isCelected8 ? "1" : "0",
          monsters: monsters ? "1" : "0",
          interface: interFaceController.text,
          kitchen: isCelected7 ? "1" : "0",
          // address: addressControllerText.text,
          lat: latLng!.latitude.toString(),
          licenseNumber: authNumberController.text,
          // cordinates: addressController.text,
          long: latLng!.longitude.toString(),
          maidRoom: isCelected2 ? "1" : "0",
          minDistance: lowDistanceController.text,
          maxDistance: highDistanceController.text,
          maxPrice: highPriceController.text,
          minPrice: lowPriceController.text,
          // networkTypeId: addAnnoncementParams.networkTypeId,
          networkTypes: selectedIds,
          pool: isCelected4 ? "1" : "0",
          purpose: purpose,
          roof: isCelected9 ? "1" : "0",
          separated: isCelected3 ? "1" : "0",
          shopsCount: storesController.text,
          streetWidth: streetWidthController.text,
          supplement: isCelected1 ? "1" : "0",
          videoLink: videoLinkController.text,
          allRooms: roomsCountController.text,
          advLicenseNumber: authNumberController.text,
          airConditioner: value2 ? "1" : "0",
          appartCount: apartmentCountController.text,
          carInterface: isCelected6 ? "1" : "0",
          bathRoomsCount: bathRoomsCountController.text,
          bedRoomsCount: bedRoomsController.text,
          basement: value3 ? "1" : "0",
          // courtyard: courtyard,
          buildingTypeId: int.parse(userType),
          fromDashboard: advType == AdvType.nafaz ? 0 : 1,
        ));
        failOrUser.fold((fail) {
          if (fail is ServerFailure) {
            emit(AddAnnoncementErrorState(mesage: fail.message));
          }
        }, (res) {
          _data = res.data;
          // sl<LoginCubit>().updateUser = res.user!;
          emit(AddAnnoncementSuccessState(data: res.data));
        });
      }
    }
  }

  clearData(BuildContext context) {
    lowPriceController.clear();
    videoLinkController.clear();
    highPriceController.clear();
    lowDistanceController.clear();
    apartmentCountController.clear();
    highDistanceController.clear();
    storesController.clear();
    streetWidthController.clear();
    authNumberController.clear();
    roomsCountController.clear();
    phoneController.clear();
    ageController.clear();
    additionalController.clear();
    addressController.clear();
    bedRoomsController.clear();
    interFaceController.clear();
    decsController.clear();
    bathRoomsCountController.clear();
    isCelected = false;
    isCelected1 = false;
    isCelected2 = false;
    isCelected3 = false;
    isCelected4 = false;
    isCelected5 = false;
    isCelected6 = false;
    isCelected7 = false;
    isCelected8 = false;
    isCelected9 = false;
    addAnnoncementParams.buildingTypeId = null;
    value1 = false;
    value2 = false;
    value3 = false;
    value4 = false;
    imageFileList = [];
    tapped1 = false;
    tapped2 = true;
    tapped3 = false;
    purpose = '';
    addAnnoncementParams.video = null;
    addAnnoncementParams.icon = null;
    // addAnnoncementParams.image2 = null;
    // addAnnoncementParams.image3 = null;
    netWorkType = '-1';
    userType = '-1';
    isCelected = false;
    isCelected1 = false;
    isCelected2 = false;
    isCelected3 = false;
    isCelected4 = false;
    isCelected5 = false;
    isCelected6 = false;
    isCelected7 = false;
    isCelected8 = false;
    isCelected9 = false;
    value1 = false;
    value2 = false;
    value3 = false;
    monsters = false;
    value4 = false;
    tapped1 = false;
    tapped2 = true;
    tapped3 = false;
    purpose = '';
    netWorkType = '-1';
    // context.read<GetNetWorkTypesCubit>().=null;
    userType = '-1';
    latLng;
  }

  void selectImages() async {
    emit(AddannoncementInitial());
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    for (var element in selectedImages) {
      imageFileList.add(File(element.path));
    }
    emit(UpdatedImage(images: imageFileList));
  }

  void removeImage(File image) {
    imageFileList.removeWhere((element) => element == image);
    emit(AddannoncementInitial());
    emit(UpdatedImage(images: imageFileList));
  }

  final picker = ImagePicker();
  Future getVideo(BuildContext context, ImageSource imageSource) async {
    final pickerFile = await picker.pickVideo(source: imageSource);
    if (pickerFile != null) {
      addAnnoncementParams.video = File(pickerFile.path);
      log("${addAnnoncementParams.video}llllllgfgfgfg");
      emit(ImagesChangeStates(avtar: addAnnoncementParams.video!));
    } else {
      addAnnoncementParams.video = null;
      emit(ImageNotChangeState());
    }
  }

  Future getImage(BuildContext context, ImageSource imageSource) async {
    final pickerFile = await picker.pickImage(source: imageSource);
    if (pickerFile != null) {
      addAnnoncementParams.icon = File(pickerFile.path);
      log("${addAnnoncementParams.icon}llllllgfgfgfg");
      emit(ImagesChangeStates(avtar: addAnnoncementParams.icon!));
    } else {
      addAnnoncementParams.icon = null;
      emit(ImageNotChangeState());
    }
  }

  // Future getImage2(BuildContext context, ImageSource imageSource) async {
  //   final pickerFile = await picker.pickImage(source: imageSource);
  //   if (pickerFile != null) {
  //     addAnnoncementParams.image2 = File(pickerFile.path);
  //     log("${addAnnoncementParams.image2}2222222222222");
  //     emit(ImagesChangeStates(avtar: addAnnoncementParams.image2!));
  //   } else {
  //     addAnnoncementParams.image2 = null;
  //     emit(ImageNotChangeState());
  //   }
  // }

  // Future getImage3(BuildContext context, ImageSource imageSource) async {
  //   final pickerFile = await picker.pickImage(source: imageSource);
  //   if (pickerFile != null) {
  //     addAnnoncementParams.image3 = File(pickerFile.path);
  //     log("${addAnnoncementParams.image3}33333333333333");
  //     emit(ImagesChangeStates(avtar: addAnnoncementParams.image3!));
  //   } else {
  //     addAnnoncementParams.image3 = null;
  //     emit(ImageNotChangeState());
  //   }
  // }
}
