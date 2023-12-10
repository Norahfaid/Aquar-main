import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../domain/models/filter.dart';
import '../../../../domain/models/update_ad_response.dart';
import '../../../../domain/usecase/update_ad.dart';

part 'update_annoncement_state.dart';

class UpdateAnnoncementCubit extends Cubit<UpdateAnnoncementState> {
  UpdateAnnoncementCubit(this.usecase) : super(UpdateAnnoncementInitial());
  final UpdateAnnoncementUsecase usecase;

  UpdateAdData? _data;

  UpdateAdData get data {
    return _data!;
  }

  File? _avatar;
  File? get avatar => _avatar;
  set setAvatar(File img) {
    _avatar = img;
    emit(UploadImage());
    emit(UpdateAnnoncementInitial());
  }

  // List<NetWorkTypes> selectedNetWork = [];
  // NetWorkTypes? selectedNetWorkList;
  bool ifNoVideo() {
    return updateAnnoncementParams.video == null ||
        (updateAnnoncementParams.video!.isRight() &&
            updateAnnoncementParams.video!.getOrElse(() => "").isEmpty);
  }

  void addSelectedNetworkIdList(int id) {
    // if(selectedNetWorkList!.id==id){}

    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
      emit(RemoveId());
      emit(UpdateAnnoncementInitial());
    } else {
      selectedIds.add(id);

      emit(AddId());
      emit(UpdateAnnoncementInitial());
    }
  }

  List<int> selectedIds = [];
  void initNetworkTypes({required List<NetWorkTypes> selectedNetWork}) {
    selectedIds = [];

    for (var i = 0; i < selectedNetWork.length; i++) {
      selectedIds.add(selectedNetWork[i].id);
      // if (selectedIds.contains(selectedNetWork[i].id)) {
      //   selectedIds.remove(selectedNetWork[i].id);
      //   emit(RemoveId());
      //   emit(UpdateAnnoncementInitial());
      // } else {
      //   selectedIds.add(selectedNetWork[i].id);
      //   emit(AddId());
      //   emit(UpdateAnnoncementInitial());
      // }
    }
  }
  // bool networkSelected = false;
  // int selectedNetworkId = 0;
  // List<int> selectedNetworkIdList = [];
  // void addSelectedNetworkIdList({required int id}) {
  //   selectedNetworkIdList.add(id);
  //   emit(SelectNetWorkId());
  //   emit(UpdateAnnoncementInitial());
  // }

  bool whdat = true;
  String groupValue = '';
  String groupValue2 = '';

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

  String netWorkType = '-1';
  String buildingTypeId = '-1';
  LatLng? latLng;

  TextEditingController advLicenseNumber = TextEditingController();
  UpdateAnnouncementParams updateAnnoncementParams = UpdateAnnouncementParams();
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
  TextEditingController roomsCountController = TextEditingController();
  TextEditingController bathRoomsCountController = TextEditingController();
  TextEditingController bedRoomsController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<Either<File, ImageFilter>> imageFileList = [];
  bool isFromDashboard = false;
  Future<void> fUpdateAnnoncement(
      {required GlobalKey<FormState> formKey1,
      required GlobalKey<FormState> formKey2,
      required GlobalKey<FormState> formKey3,
      required AnnounceData announceData}) async {
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
        emit(UpdateAnnoncementLoadingState());
        final failOrUser = await usecase(UpdateAnnouncementParams(
            age: ageController.text,
            phone: phoneController.text,
            adId: announceData.id,
            icon: updateAnnoncementParams.icon,
            video: updateAnnoncementParams.video,
            additionalRoomsCount: additionalController.text,
            selectedNetworkIds: selectedIds,
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
            // cordinates: addressController.text,
            long: latLng!.longitude.toString(),
            maidRoom: isCelected2 ? "1" : "0",
            minDistance: lowDistanceController.text,
            maxDistance: highDistanceController.text,
            maxPrice: highPriceController.text,
            minPrice: lowPriceController.text,
            // networkTypeId: updateAnnoncementParams.networkTypeId,
            pool: isCelected4 ? "1" : "0",
            purpose: purpose,
            roof: isCelected9 ? "1" : "0",
            separated: isCelected3 ? "1" : "0",
            shopsCount: storesController.text,
            streetWidth: streetWidthController.text,
            supplement: isCelected1 ? "1" : "0",
            videoLink: videoLinkController.text,
            advLicenseNumber: advLicenseNumber.text,
            airConditioner: value2 ? "1" : "0",
            appartCount: apartmentCountController.text,
            carInterface: isCelected6 ? "1" : "0",
            bathRoomsCount: bathRoomsCountController.text,
            bedRoomsCount: bedRoomsController.text,
            basement: value3 ? "1" : "0",
            // courtyard: courtyard,
            buildingTypeId: int.parse(buildingTypeId),
            fromDashboard: isFromDashboard? 1 : 0,
        ),
        );
        failOrUser.fold((fail) {
          if (fail is ServerFailure) {
            emit(UpdateAnnoncementErrorState(mesage: fail.message));
          }
        }, (res) {
          _data = res.data;
          // sl<LoginCubit>().updateUser = res.user!;
          emit(UpdateAnnoncementSuccessState(data: res.data));
        });
      }
    }
  }

  void selectImages() async {
    emit(UpdateAnnoncementInitial());
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    for (var element in selectedImages) {
      imageFileList.add(left(File(element.path)));
    }
    emit(UpdatedImage());
  }

  void removeImage(int index) {
    imageFileList.removeAt(index);
    emit(UpdateAnnoncementInitial());
    emit(UpdatedImage());
  }

  final picker = ImagePicker();
  Future getVideo(BuildContext context, ImageSource imageSource) async {
    final pickerFile = await picker.pickVideo(source: imageSource);
    if (pickerFile != null) {
      updateAnnoncementParams.video = left(File(pickerFile.path));
      log("${updateAnnoncementParams.video}llllllgfgfgfg");
      emit(ImagesChangeStates());
    } else {
      updateAnnoncementParams.video = null;
      emit(ImageNotChangeState());
    }
  }

  Future getImage(BuildContext context, ImageSource imageSource) async {
    final pickerFile = await picker.pickImage(source: imageSource);
    if (pickerFile != null) {
      updateAnnoncementParams.icon = left(File(pickerFile.path));
      log("${updateAnnoncementParams.icon}llllllgfgfgfg");
      emit(ImagesChangeStates());
    } else {
      updateAnnoncementParams.icon = null;
      emit(ImageNotChangeState());
    }
  }

  void emitChnages() {
    emit(UpdateAnnoncementInitial());
    emit(ImageNotChangeState());
  }

  void emitInit() {
    emit(UpdateAnnoncementInitial());
  }
}
