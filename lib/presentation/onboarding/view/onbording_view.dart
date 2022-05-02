import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/app/di.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/color_manager.dart';
import 'package:stores/presentation/resources/constant_manager.dart';
import 'package:stores/presentation/resources/routes_manager.dart';
import 'package:stores/presentation/resources/strings_manager.dart';
import 'package:stores/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = instance<OnBoardingViewModel>();
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();

  _bind() {
    _viewModel.start();
    _appPrefrences.setOnBoardingScreenViewed();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(SliderViewObject? slider) {
    return slider == null
        ? Container()
        : Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: AppSize.s0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManager.white,
                statusBarBrightness: Brightness.dark,
              ),
            ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: slider.numberOfSlides,
              onPageChanged: (index) => _viewModel.onPageChanged(index),
              itemBuilder: (context, index) =>
                  OnBoardingPage(slider.sliderObject),
            ),
            bottomSheet: Container(
              color: ColorManager.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.loginRoute,
                        );
                      },
                      child: Text(
                        AppStrings.skip,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  // widgets indicator and arrows
                  _getBottomSheetWidget(slider),
                ],
              ),
            ),
          );
  }

  Widget _getBottomSheetWidget(SliderViewObject slider) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssetsManager.leftArrowIc),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(
                  _viewModel.goPrevious(),
                  duration: const Duration(
                    milliseconds: AppConstants.sliderAnimationTime,
                  ),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < slider.numberOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: _getProperCircle(
                    i,
                    slider.currentIndex,
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppPadding.p14,
            ),
            child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(
                    ImageAssetsManager.rightArrowIc,
                  ),
                ),
                onTap: () {
                  // go to previous slide
                  _pageController.animateToPage(
                    _viewModel.goNext(),
                    duration: const Duration(
                      milliseconds: AppConstants.sliderAnimationTime,
                    ),
                    curve: Curves.bounceInOut,
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssetsManager.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssetsManager.solidCircleIc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p8,
          ),
          child: Text(
            _sliderObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
