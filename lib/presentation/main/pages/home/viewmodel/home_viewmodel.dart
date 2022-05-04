import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:rxdart/subjects.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/usecase/home_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _bannersStreamController.close();
    _storesStreamController.close();
    _servicesStreamController.close();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // -- outputs
  @override
  Stream<List<BannerAd>> get outBanner =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outStore =>
      _storesStreamController.stream.map((stores) => stores);

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    // ignore: void_checks
    (await _homeUseCase.execute(Void)).fold(
        (failure) => inputState.add(
              ErrorState(
                StateRendererType.fullScreenErrorState,
                failure.message,
              ),
            ), (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data?.banners);
      inputServices.add(homeObject.data?.services);
      inputStores.add(homeObject.data?.stores);
    });
  }
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outStore;
  Stream<List<Service>> get outServices;
  Stream<List<BannerAd>> get outBanner;
}
