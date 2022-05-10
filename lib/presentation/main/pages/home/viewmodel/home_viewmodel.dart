import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/subjects.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/usecase/home_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final StreamController<HomeViewObject> _homeObjectStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _homeObjectStreamController.close();
  }

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
      inputHomeData.add(
        HomeViewObject(
          homeObject.data.stores,
          homeObject.data.services,
          homeObject.data.banners,
        ),
      );
    });
  }

  @override
  Sink get inputHomeData => _homeObjectStreamController.sink;

  @override
  get outputHomeObject =>
      _homeObjectStreamController.stream.map((homeObject) => homeObject);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeObject;
}

class HomeViewObject {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeViewObject(this.stores, this.services, this.banners);
}
