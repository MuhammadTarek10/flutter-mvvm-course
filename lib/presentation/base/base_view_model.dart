abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // close view model
}

abstract class BaseViewModelOutputs {}

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
      
    }
