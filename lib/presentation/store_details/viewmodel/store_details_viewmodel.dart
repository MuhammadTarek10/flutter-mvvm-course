import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/subjects.dart';
import 'package:stores/domain/models/models.dart';
import 'package:stores/domain/usecase/store_details_usecase.dart';
import 'package:stores/presentation/base/base_view_model.dart';
import 'package:stores/presentation/common/state_renderer/state_rederer_implementer.dart';
import 'package:stores/presentation/common/state_renderer/state_renderer.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StreamController<StoreDetails> _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);

  void _getStoreDetails() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenEmptyState,
      ),
    );
    // ignore: void_checks
    (await _storeDetailsUseCase.execute(Void)).fold(
      (failure) => inputState.add(
        ErrorState(
          StateRendererType.fullScreenErrorState,
          failure.message,
        ),
      ),
      (storeDetails) {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}
