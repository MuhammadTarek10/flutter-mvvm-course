import 'dart:async';

import 'package:stores/domain/models/models.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  int _currentIndex = 0;
  late final List<SliderObject> _list;

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    _currentIndex = (_currentIndex + 1) % _list.length;
    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex = (_currentIndex - 1) % _list.length;
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSlideViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map(
        (sliderViewObject) => sliderViewObject,
      );

  void _postDataToView() {
    inputSlideViewObject.add(
      SliderViewObject(
        _list[_currentIndex],
        _list.length,
        _currentIndex,
      ),
    );
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubtitle1,
          ImageAssetsManager.onBordingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubtitle2,
          ImageAssetsManager.onBordingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubtitle3,
          ImageAssetsManager.onBordingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4,
          AppStrings.onBoardingSubtitle4,
          ImageAssetsManager.onBordingLogo4,
        ),
      ];
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink get inputSlideViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
