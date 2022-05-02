import 'package:flutter/material.dart';
import 'package:stores/app/di.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:stores/presentation/resources/assets_manager.dart';
import 'package:stores/presentation/resources/color_manager.dart';
import 'package:stores/presentation/resources/routes_manager.dart';
import 'package:stores/presentation/resources/strings_manager.dart';
import 'package:stores/presentation/resources/values_manager.dart';

class ForgetPassowrdView extends StatefulWidget {
  const ForgetPassowrdView({Key? key}) : super(key: key);

  @override
  State<ForgetPassowrdView> createState() => _ForgetPassowrdViewState();
}

class _ForgetPassowrdViewState extends State<ForgetPassowrdView> {
  final ForgetPasswordViewModel _viewModel =
      instance<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
              child: Image(
                image: AssetImage(
                  ImageAssetsManager.splashLogo,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s8),
            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p28,
                right: AppPadding.p28,
              ),
              child: StreamBuilder<bool>(
                stream: _viewModel.outEmailValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.email,
                      labelText: AppStrings.email,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.emailError,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p28,
                right: AppPadding.p28,
              ),
              child: StreamBuilder<bool>(
                stream: _viewModel.outEmailValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: AppSize.s60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () => _viewModel.reset()
                          : null,
                      child: const Text(AppStrings.resetPassword),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () => Navigator.of(context)
                    .pushReplacementNamed(Routes.loginRoute),
              ) ??
              _getContentWidget();
        },
      ),
    );
  }
}
