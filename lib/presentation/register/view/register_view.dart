import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stores/app/app_prefs.dart';
import 'package:stores/app/constants.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/color_manager.dart';
import 'package:stores/presentation/resources/routes_manager.dart';
import 'package:stores/presentation/resources/strings_manager.dart';
import 'package:stores/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _mobileNumberController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberController.text);
    });
    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
        .listen((isRegesterd) {
      if (isRegesterd) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => _appPrefrences.setUserRegistered(),
        );
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p10,
        right: AppPadding.p10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppStrings.profilePicture.tr(),
            ),
          ),
          Flexible(
            child: StreamBuilder<File>(
              stream: _viewModel.outProfilePicture,
              builder: (context, snapshot) {
                return _imagePicked(snapshot.data);
              },
            ),
          ),
          Flexible(child: SvgPicture.asset(ImageAssetsManager.profileCamera)),
        ],
      ),
    );
  }

  Widget _imagePicked(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.browse_gallery),
                title: Text(AppStrings.photoGallery.tr()),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: Text(AppStrings.photoCamera.tr()),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getContentWidget() {
    return Container(
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child:
                      Image(image: AssetImage(ImageAssetsManager.splashLogo))),
              const SizedBox(height: AppSize.s1_5),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outErrorUsername,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s1_5),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CountryCodePicker(
                          onChanged: (country) =>
                              _viewModel.setCountryMobileCode(
                            country.dialCode ?? Constants.token,
                          ),
                          initialSelection: '+20',
                          favorite: const ['+39', 'FR', '+966'],
                          showCountryOnly: true,
                          hideMainText: true,
                          showOnlyCountryWhenClosed: true,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(
                          stream: _viewModel.outErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberController,
                              decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber.tr(),
                                labelText: AppStrings.mobileNumber.tr(),
                                errorText: snapshot.data,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s1_5),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s1_5),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s1_5),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                    border: Border.all(
                      color: ColorManager.grey,
                    ),
                  ),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () => _showPicker(context),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s10),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s60,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () => _viewModel.register()
                            : null,
                        child: Text(
                          AppStrings.register.tr(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p8,
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    AppStrings.alreadyHaveAccount.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.primary,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () => _viewModel.register(),
              ) ??
              _getContentWidget();
        },
      ),
    );
  }
}
